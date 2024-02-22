program cypher_nm01.aleo;

struct CodeBlock:
    creator as address;
    cno as u64;

record Cyphers:
    owner as address.private;
    cypher as field.private;


mapping codes:
	key as CodeBlock.public;
	value as field.public;


mapping code_count:
	key as address.public;
	value as u64.public;

function initialize_account:
    input r0 as u32.private;
    cast r0 into r1 as field;
    add 73907546187_field r1 into r2;
    sqrt 12830210332_field into r3;
    sqrt r2 into r4;
    add r3 r4 into r5;
    cast self.caller r5 into r6 as Cyphers.record;
    output true as boolean.private;


function create_code:
    input r0 as field.private;
    async create_code self.caller r0 into r1;
    output true as boolean.private;
    output r1 as cypher_nm01.aleo/create_code.future;

finalize create_code:
    input r0 as address.public;
    input r1 as field.public;
    get.or_use code_count[r0] 0u64 into r2;
    add r2 1_u64 into r3;
    cast r0 r3 into r4 as CodeBlock;
    set r1 into codes[r4];
    set r3 into code_count[r0];
