Received:  by oss.sgi.com id <S554013AbRBWOOi>;
	Fri, 23 Feb 2001 06:14:38 -0800
Received: from mail.sonytel.be ([193.74.243.200]:12282 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554022AbRBWOO2>;
	Fri, 23 Feb 2001 06:14:28 -0800
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA21748
	for <linux-mips@oss.sgi.com>; Fri, 23 Feb 2001 15:13:57 +0100 (MET)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id PAA21266
	for linux-mips@oss.sgi.com; Fri, 23 Feb 2001 15:13:55 +0100 (MET)
Date:   Fri, 23 Feb 2001 15:13:55 +0100
From:   Tom Appermont <tea@sonycom.com>
To:     linux-mips@oss.sgi.com
Subject: ELF header kernel module wrong?
Message-ID: <20010223151355.A9091@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Greetings,

I'm trying to get modules to work on my R5000 little endian 
target, linux 2.4.1 + modutils 2.4.2 .

When I insmod a module, I get error messages like: 

[root@192 /]# insmod dummy.o 
dummy.o: local symbol gcc2_compiled. with index 10 exceeds local_symtab_size 10
dummy.o: local symbol __gnu_compiled_c with index 11 exceeds local_symtab_size 10
dummy.o: local symbol __module_kernel_version with index 12 exceeds local_symtab_size 10
dummy.o: local symbol set_multicast_list with index 13 exceeds local_symtab_size 10
dummy.o: local symbol dummy_init with index 14 exceeds local_symtab_size 10
dummy.o: local symbol dummy_xmit with index 15 exceeds local_symtab_size 10
dummy.o: local symbol dummy_get_stats with index 18 exceeds local_symtab_size 10
dummy.o: local symbol dummy_init_module with index 21 exceeds local_symtab_size 10
dummy.o: local symbol dev_dummy with index 22 exceeds local_symtab_size 10
dummy.o: local symbol dummy_cleanup_module with index 26 exceeds local_symtab_size 10
[root@192 /]#

Looking at the source code of modutils, I suspect that there is 
something wrong with the ELF header of the module (the sh_info
field of the SYMTAB section is 0xa while it should be 0x17 ??).
ELF header is attached below. The command used to compile the 
module is :

mipsel-linux-gcc -I/usr/src/linux/include/asm/gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r8000 -mips2 -Wa,--trap -pipe -DMODULE -mlong-calls

I use egcs 1.2.1 + binutils 2.9.5. Is this a problem with my
binutils?


Tom


--
Elf header
  e_ident =  7f 45 4c 46 1 1 1 0 0 0 0 0 0 0 0 0  
  e_ident[EI_CLASS] = ELFCLASS32
  e_ident[EI_DATA] = ELFDATA2LSB
  e_ident[EI_VERSION] = 1
  e_type = ET_REL
  e_machine = EM_MIPS
  e_version = 1
  e_entry = 0x0
  e_phoff = 0x0
  e_shoff = 0xa1c
  e_flags = 0x30000101
  e_ehsize = 52
  e_phentsize = 0
  e_phnum = 0
  e_shentsize = 40
  e_shnum = 15
  e_shstrndx = 12

Section header #0
  sh_name = <NULL>
  sh_type = SHT_NULL
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x0
  sh_size = 0x0
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 0
  sh_entsize = 0

Section header #1
  sh_name = .text
  sh_type = SHT_PROGBITS
  sh_flags = 0x6 (Execinstr, Alloc)
  sh_addr = 0x0
  sh_offset = 0x40
  sh_size = 0x220
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 16
  sh_entsize = 0

Section header #2
  sh_name = .rel.text
  sh_type = SHT_REL
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0xf90
  sh_size = 0x128
  sh_link = 0xd
  sh_info = 0x1
  sh_addralign = 4
  sh_entsize = 8

Section header #3
  sh_name = .rela.text
  sh_type = SHT_RELA
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x10b8
  sh_size = 0x0
  sh_link = 0xd
  sh_info = 0x1
  sh_addralign = 4
  sh_entsize = 12

Section header #4
  sh_name = .data
  sh_type = SHT_PROGBITS
  sh_flags = 0x3 (Alloc, Write)
  sh_addr = 0x0
  sh_offset = 0x260
  sh_size = 0x0
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 16
  sh_entsize = 0

Section header #5
  sh_name = .bss
  sh_type = SHT_NOBITS
  sh_flags = 0x3 (Alloc, Write)
  sh_addr = 0x0
  sh_offset = 0x260
  sh_size = 0x130
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 16
  sh_entsize = 0

Section header #6
  sh_name = .reginfo
  sh_type = <<< unknown sh_type (0x70000006) >>>
  sh_flags = 0x2 (Alloc)
  sh_addr = 0x0
  sh_offset = 0x260
  sh_size = 0x18
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 4
  sh_entsize = 1


Section header #7
  sh_name = .mdebug
  sh_type = <<< unknown sh_type (0x70000005) >>>
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x278
  sh_size = 0x614
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 4
  sh_entsize = 1

Section header #8
  sh_name = .note
  sh_type = SHT_NOTE
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x88c
  sh_size = 0x14
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 1
  sh_entsize = 0

Section header #9
  sh_name = .modinfo
  sh_type = SHT_PROGBITS
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x8a0
  sh_size = 0x18
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 4
  sh_entsize = 0

Section header #10
  sh_name = .rodata
  sh_type = SHT_PROGBITS
  sh_flags = 0x2 (Alloc)
  sh_addr = 0x0
  sh_offset = 0x8c0
  sh_size = 0xb0
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 16
  sh_entsize = 0

Section header #11
  sh_name = .comment
  sh_type = SHT_PROGBITS
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x970
  sh_size = 0x37
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 1
  sh_entsize = 0


Section header #12
  sh_name = .shstrtab
  sh_type = SHT_STRTAB
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0x9a7
  sh_size = 0x72
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 1
  sh_entsize = 0

Section header #13
  sh_name = .symtab
  sh_type = SHT_SYMTAB
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0xc74
  sh_size = 0x1f0
  sh_link = 0xe
  sh_info = 0xa
  sh_addralign = 4
  sh_entsize = 16

Section header #14
  sh_name = .strtab
  sh_type = SHT_STRTAB
  sh_flags = 0x0 (no flags)
  sh_addr = 0x0
  sh_offset = 0xe64
  sh_size = 0x12a
  sh_link = 0x0
  sh_info = 0x0
  sh_addralign = 1
  sh_entsize = 0

Symbol Table: .symtab (@ 0xc74)
0. <NULL>, value=0, size=0, info=0, shndx=0
1. <NULL>, value=0, size=0, info=(local, section), shndx=.text(1)
2. <NULL>, value=0, size=0, info=(local, section), shndx=.data(4)
3. <NULL>, value=0, size=0, info=(local, section), shndx=.bss(5)
4. <NULL>, value=0, size=0, info=(local, section), shndx=.modinfo(9)
5. <NULL>, value=0, size=0, info=(local, section), shndx=.rodata(10)
6. <NULL>, value=0, size=0, info=(local, section), shndx=.reginfo(6)
7. <NULL>, value=0, size=0, info=(local, section), shndx=.mdebug(7)
8. <NULL>, value=0, size=0, info=(local, section), shndx=.note(8)
9. <NULL>, value=0, size=0, info=(local, section), shndx=.comment(11)
10. gcc2_compiled., value=0, size=0, info=0, shndx=.text(1)
11. __gnu_compiled_c, value=0, size=0, info=0, shndx=.text(1)
12. __module_kernel_version, value=0, size=21, info=(local, object), shndx=.modinfo(9)
13. set_multicast_list, value=0, size=8, info=(local, func), shndx=.text(1)
14. dummy_init, value=8, size=168, info=(local, func), shndx=.text(1)
15. dummy_xmit, value=0xb0, size=124, info=(local, func), shndx=.text(1)
16. kmalloc, value=0, size=0, info=(global, notype), shndx=0
17. memset, value=0, size=0, info=(global, notype), shndx=0
18. dummy_get_stats, value=0x12c, size=8, info=(local, func), shndx=.text(1)
19. ether_setup, value=0, size=0, info=(global, notype), shndx=0
20. __kfree_skb, value=0, size=0, info=(global, notype), shndx=0
21. dummy_init_module, value=0x134, size=124, info=(local, func), shndx=.text(1)
22. dev_dummy, value=0, size=304, info=(local, object), shndx=.bss(5)
23. __this_module, value=0, size=0, info=(global, notype), shndx=0
24. dev_alloc_name, value=0, size=0, info=(global, notype), shndx=0
25. register_netdev, value=0, size=0, info=(global, notype), shndx=0
26. dummy_cleanup_module, value=0x1b0, size=104, info=(local, func), shndx=.text(1)
27. unregister_netdev, value=0, size=0, info=(global, notype), shndx=0
28. kfree, value=0, size=0, info=(global, notype), shndx=0
29. init_module, value=0x134, size=124, info=(global, func), shndx=.text(1)
30. cleanup_module, value=0x1b0, size=104, info=(global, func), shndx=.text(1)

Relocation section .rel.text (2)
Index   Offset          Symbol          Type
0.      1c              1               R_MIPS_HI16 (5)
1.      20              1               R_MIPS_LO16 (6)
2.      24              16              R_MIPS_HI16 (5)
3.      28              16              R_MIPS_LO16 (6)
4.      48              17              R_MIPS_HI16 (5)
5.      4c              17              R_MIPS_LO16 (6)
6.      5c              1               R_MIPS_HI16 (5)
7.      60              1               R_MIPS_LO16 (6)
8.      64              1               R_MIPS_HI16 (5)
9.      68              1               R_MIPS_LO16 (6)
10.     70              19              R_MIPS_HI16 (5)
11.     74              19              R_MIPS_LO16 (6)
12.     94              1               R_MIPS_26 (4)
13.     10c             20              R_MIPS_HI16 (5)
14.     110             20              R_MIPS_LO16 (6)
15.     138             3               R_MIPS_HI16 (5)
16.     13c             3               R_MIPS_LO16 (6)
17.     140             1               R_MIPS_HI16 (5)
18.     144             1               R_MIPS_LO16 (6)
19.     154             23              R_MIPS_HI16 (5)
20.     158             23              R_MIPS_LO16 (6)
21.     164             5               R_MIPS_HI16 (5)
22.     168             5               R_MIPS_LO16 (6)
23.     16c             24              R_MIPS_HI16 (5)
24.     170             24              R_MIPS_LO16 (6)
25.     184             25              R_MIPS_HI16 (5)
26.     188             25              R_MIPS_LO16 (6)
27.     1b8             3               R_MIPS_HI16 (5)
28.     1bc             3               R_MIPS_LO16 (6)
29.     1c0             27              R_MIPS_HI16 (5)
30.     1c4             27              R_MIPS_LO16 (6)
31.     1d4             28              R_MIPS_HI16 (5)
32.     1d8             28              R_MIPS_LO16 (6)
33.     1ec             17              R_MIPS_HI16 (5)
34.     1f0             17              R_MIPS_LO16 (6)
35.     200             1               R_MIPS_HI16 (5)
36.     204             1               R_MIPS_LO16 (6)
