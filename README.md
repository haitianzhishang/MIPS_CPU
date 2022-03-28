# MIPS CPU

## Instruction Set

### R-format

| Instruction | Description                                           | Opcode | Func |
| ----------- | ----------------------------------------------------- | ------ | ---- |
| uaddr       | Addition of two unsigned integers                     |        |      |
| addr        | Addition of two signed integers                       |        |      |
| usubr       | Subtraction of two unsigned integers                  |        |      |
| subr        | Subtraction of two signed integers                    |        |      |
| umult       | Multiplication of two unsigned integers               |        |      |
| mult        | Multiplication of two signed integers                 |        |      |
| udiv        | division of two unsigned integers                     |        |      |
| div         | division of two signed integers                       |        |      |
| andr        | Logic and of two registers                            |        |      |
| orr         | Logic or of two registers                             |        |      |
| xorr        | Logic xor of two registers                            |        |      |
| norr        | Logic nor of two registers                            |        |      |
| sll         | Signed shift left by shamt                            |        |      |
| srl         | Signed shift right by shamt                           |        |      |
| usrl        | Unsigned shift right by shamt                         |        |      |
| sllr        | Signed shift left by value of register                |        |      |
| srlr        | Signed shift right by value of register               |        |      |
| usrlr       | Unsigned shift right by value of register             |        |      |
| jr          | Jump to the address stored in register                |        |      |
| jalr        | Jump to the address stored in Rs and store PC+4 in Rd |        |      |
| mfhi        | Copy value of hi to general register                  |        |      |
| mthi        | Copy general register to hi                           |        |      |
| mflo        | Copy value of lo to general register                  |        |      |
| mtlo        | Copy general register to lo                           |        |      |
| slt         | Set on less than signed (Rs < Rt)                     |        |      |
| uslt        | Set on less than unsigned (Rs < Rt)                   |        |      |

### I-format

| Instruction | Description                                                  | Opcode | Func |
| ----------- | ------------------------------------------------------------ | ------ | ---- |
| beq         | Branch to PC+4+i<<2 if registers are equal       PC <- PC + 4 + SignExt18b({i, 2b'0}) |        |      |
| bne         | Branch to PC+4+i<<2 if registers are not equal               |        |      |
| blez        | Branch to PC+4+i<<2 if register is <= 0                      |        |      |
| bgez        | Branch to PC+4+i<<2 if register is >  0                      |        |      |
| addi        | Addition of signed register and i                          Rt <- Rs + SignExt16b(imm) |        |      |
| uaddi       | Addition of unsigned register and i                          |        |      |
| slti        | Set on less than signed (Rs < i)                           Rt=1 <- Rs < SignExt16b(imm) |        |      |
| uslti       | Set on less than unsigned (Rs < i)                           |        |      |
| andi        | Logic and of register and i                                  |        |      |
| ori         | Logic or of register and i                                   |        |      |
| xori        | Logic xor of register and i                                  |        |      |
| lui         | i <<16 and store to register                                 |        |      |
| lb          | Load byte                         Rt <- SignExt8b(Mem8b(Rs + SignExt16b(i)) |        |      |
| lh          | Load half word                 Rt <- SignExt16b(Mem16b(Rs + SignExt16b(i)) |        |      |
| lw          | Load word                        Rt <- Mem32b(Rs + SignExt16b(i) |        |      |
| ulb         | Load unsigned byte         Rt <-  {24b'0, Mem8b(Rs + SignExt16b(i)} |        |      |
| ulh         | Load unsigned half word Rt <-  {16b'0, Mem16b(Rs + SignExt16b(i)} |        |      |
| sb          | Store byte                        Mem8b(Rs + SignExt16b(i))  <- Rt[7:0] |        |      |
| sh          | Store half word                Mem16b(Rs + SignExt16b(i))  <- Rt[15:0] |        |      |
| sw          | Store word                       Mem32b(Rs + SignExt16b(i))  <- Rt |        |      |

### J-format

| Instruction | Description                                               | Opcode | Func |
| ----------- | --------------------------------------------------------- | ------ | ---- |
| j           | Jump to {PC+4[31:28], i, 2'b0}                            |        |      |
| jal         | Jump to {PC+4[31:28], i, 2'b0} and store PC+8 in register |        |      |

## Architecture

![Architecture](https://github.com/haitianzhishang/MIPS_CPU/blob/main/datasheet/MIPS%20CPU.drawio.png?raw=true)

