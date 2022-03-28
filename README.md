# MIPS CPU

## Instruction Set

### R-format

| Instruction | Description                                           | Opcode | Func   |
| ----------- | ----------------------------------------------------- | ------ | ------ |
| uaddr       | Addition of two unsigned integers                     | 000000 | 000001 |
| addr        | Addition of two signed integers                       | 000000 | 000000 |
| usubr       | Subtraction of two unsigned integers                  | 000000 | 000011 |
| subr        | Subtraction of two signed integers                    | 000000 | 000010 |
| umult       | Multiplication of two unsigned integers               | 000000 | 000100 |
| mult        | Multiplication of two signed integers                 | 000000 | 000011 |
| udiv        | division of two unsigned integers                     | 000000 | 000101 |
| div         | division of two signed integers                       | 000000 | 000110 |
| andr        | Logic and of two registers                            | 000000 | 001000 |
| orr         | Logic or of two registers                             | 000000 | 001001 |
| xorr        | Logic xor of two registers                            | 000000 | 001010 |
| norr        | Logic nor of two registers                            | 000000 | 001011 |
| sll         | Signed shift left by shamt                            | 000000 | 001100 |
| srl         | Signed shift right by shamt                           | 000000 | 001101 |
| usrl        | Unsigned shift right by shamt                         | 000000 | 001110 |
| sllr        | Signed shift left by value of register                | 000000 | 001100 |
| srlr        | Signed shift right by value of register               | 000000 | 001101 |
| usrlr       | Unsigned shift right by value of register             | 000000 | 001110 |
| jr          | Jump to the address stored in register                | 100000 |        |
| jalr        | Jump to the address stored in Rs and store PC+4 in Rd | 100001 |        |
| mfhi        | Copy value of hi to general register                  |        |        |
| mthi        | Copy general register to hi                           |        |        |
| mflo        | Copy value of lo to general register                  |        |        |
| mtlo        | Copy general register to lo                           |        |        |
| slt         | Set on less than signed (Rs < Rt)                     |        |        |
| uslt        | Set on less than unsigned (Rs < Rt)                   |        |        |

### I-format

| Instruction | Description                                                  | Opcode | Func   |
| ----------- | ------------------------------------------------------------ | ------ | ------ |
| beq         | Branch to PC+4+i<<2 if registers are equal       PC <- PC + 4 + SignExt18b({i, 2b'0}) | 010000 | 000000 |
| bne         | Branch to PC+4+i<<2 if registers are not equal               | 010001 | 000000 |
| blez        | Branch to PC+4+i<<2 if register is <= 0                      | 010010 | 000000 |
| bgez        | Branch to PC+4+i<<2 if register is >  0                      | 010011 | 000000 |
| addi        | Addition of signed register and i                          Rt <- Rs + SignExt16b(imm) | 011111 | 000000 |
| uaddi       | Addition of unsigned register and i                          | 011111 | 000001 |
| slti        | Set on less than signed (Rs < i)                           Rt=1 <- Rs < SignExt16b(imm) |        |        |
| uslti       | Set on less than unsigned (Rs < i)                           |        |        |
| andi        | Logic and of register and i                                  | 011111 | 001000 |
| ori         | Logic or of register and i                                   | 011111 | 001001 |
| xori        | Logic xor of register and i                                  | 011111 | 001010 |
| lui         | i <<16 and store to register                                 |        |        |
| lb          | Load byte                         Rt <- SignExt8b(Mem8b(Rs + SignExt16b(i)) | 011000 | 000000 |
| lh          | Load half word                 Rt <- SignExt16b(Mem16b(Rs + SignExt16b(i)) | 011001 | 000000 |
| lw          | Load word                        Rt <- Mem32b(Rs + SignExt16b(i) | 011010 | 000000 |
| ulb         | Load unsigned byte         Rt <-  {24b'0, Mem8b(Rs + SignExt16b(i)} | 011011 | 000000 |
| ulh         | Load unsigned half word Rt <-  {16b'0, Mem16b(Rs + SignExt16b(i)} | 011100 | 000000 |
| sb          | Store byte                        Mem8b(Rs + SignExt16b(i))  <- Rt[7:0] | 010100 | 000000 |
| sh          | Store half word                Mem16b(Rs + SignExt16b(i))  <- Rt[15:0] | 010101 | 000000 |
| sw          | Store word                       Mem32b(Rs + SignExt16b(i))  <- Rt | 010110 | 000000 |

### J-format

| Instruction | Description                                               | Opcode | Func |
| ----------- | --------------------------------------------------------- | ------ | ---- |
| j           | Jump to {PC+4[31:28], i, 2'b0}                            | 100010 |      |
| jal         | Jump to {PC+4[31:28], i, 2'b0} and store PC+8 in register | 100011 |      |

## Architecture

![Architecture](https://github.com/haitianzhishang/MIPS_CPU/blob/main/datasheet/MIPS%20CPU.drawio.png?raw=true)

