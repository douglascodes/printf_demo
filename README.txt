64-bit C calling convention demo for printf. System V ABI. Using Intel instruction set.
Run under Bodhi-64, (Ubuntu) Linux 3.7.0-7-generic x86_64
CPU: Intel(R) Pentium(R) CPU B960 @ 2.20GHz
Compile with: `nasm -f elf64 -o pf_demo.o -g -F stabs pf_demo.asm`
Link with: `gcc -o pf_demo pf_demo.o`
Run with: `./pf_demo`