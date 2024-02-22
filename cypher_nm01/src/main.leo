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
        let gen1: field = 12830210332_field;
        let gen2: field = 73907546187_field + nonce as field;
        let msk: field = gen1.square_root() + gen2.square_root();
        let cyph: Cyphers = Cyphers {owner: owner, cypher: msk};
        return true;
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
