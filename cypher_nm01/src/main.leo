// The 'helloworld' program.
program cypher_nm01.aleo {
    

    struct CodeBlock {
        creator: address,
        cno: u64,
    }

    record Cyphers {
        owner: address,
        cypher: field,
        
    }

   
    
    mapping codes: CodeBlock => field;
    mapping code_count: address => u64;
    
    

    transition initialize_account(nonce: u32) -> bool{
        let owner: address = self.caller;
        return true then finalize(owner, nonce);
    }

    finalize initialize_account(owner: address, nonce: u32) {
        let gen: u32 = ChaCha::rand_u32();
        let gen2: u32 = gen + nonce;
        let msk: field = (gen as field).square_root() + (gen2 as field).square_root();
        let cyph: Cyphers = Cyphers {owner: owner, cypher: msk};

    }

    transition create_code(val: field) -> bool {
        let owner: address = self.caller;

        return true then finalize(owner, val);
    }

    finalize create_code(owner: address, val: field) {
        
        let code_no: u64 = Mapping::get_or_use(code_count, owner, 0u64) + 1_u64;
        let code_obj: CodeBlock = CodeBlock{creator: owner, cno: code_no};
        Mapping::set(codes, code_obj, val);
        Mapping::set(code_count, owner, code_no);


    }

    
}
