Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2003 12:52:53 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:29973
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225495AbTJ3MwU>; Thu, 30 Oct 2003 12:52:20 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 30 Oct 2003 12:52:39 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h9UCqE9X046389;
	Thu, 30 Oct 2003 21:52:15 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 30 Oct 2003 21:54:53 +0900 (JST)
Message-Id: <20031030.215453.78703232.nemoto@toshiba-tops.co.jp>
To: dan@debian.org
Cc: jsun@mvista.com, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20031029181516.GA14443@nevyn.them.org>
References: <20031029.163201.39178653.nemoto@toshiba-tops.co.jp>
	<20031029101400.J30683@mvista.com>
	<20031029181516.GA14443@nevyn.them.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Oct_30_21:54:53_2003_617)--"
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

----Next_Part(Thu_Oct_30_21:54:53_2003_617)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Wed, 29 Oct 2003 13:15:17 -0500, Daniel Jacobowitz <dan@debian.org> said:
dan> Atsushi-san's program would not even link with a binutils that
dan> didn't support multiple GOTs; I guess that something is going
dan> wrong with that support.

Yes, I guess too.

dan> I don't suppose you could provide a testcase?

I wrote a short script to generate a testcase.  Running attached awk
script create src0.c, src1.c, ..., src3.c.

$ mips-linux-gcc -c src[0-4].c
$ mips-linux-gcc -o bigapp src[0-4].o

This bigapp program compiled with binutils-2.14, gcc-3.3.2, uClibc
0.9.21 is corrupted.

Here is some outputs from readelf:

$ mips-linux-readelf -S bigapp
There are 31 section headers, starting at offset 0x36ad78:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        004000f4 0000f4 00000d 00   A  0   0  1
  [ 2] .reginfo          MIPS_REGINFO    00400104 000104 000018 18   A  0   0  4
  [ 3] .dynamic          DYNAMIC         0040011c 00011c 0000d8 08   A  6   0  4
  [ 4] .hash             HASH            004001f4 0001f4 028784 04   A  5   0  4
  [ 5] .dynsym           DYNSYM          00428978 028978 061c40 10   A  6   1  4
  [ 6] .dynstr           STRTAB          0048a5b8 08a5b8 041da5 00   A  0   0  1
  [ 7] .init             PROGBITS        004cc370 0cc370 0000ac 00  AX  0   0  4
  [ 8] .text             PROGBITS        004cc420 0cc420 1b7d60 00  AX  0   0 16
  [ 9] .fini             PROGBITS        00684180 284180 00005c 00  AX  0   0  4
  [10] .rodata           PROGBITS        006841e0 2841e0 000010 00   A  0   0 16
  [11] .data             PROGBITS        10000000 285000 000010 00  WA  0   0 16
  [12] .rld_map          PROGBITS        10000010 285010 000004 00  WA  0   0  4
  [13] .eh_frame         PROGBITS        10000014 285014 000004 00   A  0   0  4
  [14] .ctors            PROGBITS        10000018 285018 000008 00  WA  0   0  4
  [15] .dtors            PROGBITS        10000020 285020 000008 00  WA  0   0  4
  [16] .jcr              PROGBITS        10000028 285028 000004 00  WA  0   0  4
  [17] .got              PROGBITS        10000030 285030 02245c 04 WAp  0   0 16
  [18] .sbss             NOBITS          1002248c 2a7490 000000 00 WAp  0   0  1
  [19] .bss              NOBITS          10022490 2a7490 000020 00  WA  0   0 16
  [20] .comment          PROGBITS        00000000 2a7490 0000a2 00      0   0  1
  [21] .debug_aranges    MIPS_DWARF      00000000 2a7538 000020 00      0   0  8
  [22] .debug_info       MIPS_DWARF      00000000 2a7558 000069 00      0   0  1
  [23] .debug_abbrev     MIPS_DWARF      00000000 2a75c1 000014 00      0   0  1
  [24] .debug_line       MIPS_DWARF      00000000 2a75d5 000044 00      0   0  1
  [25] .pdr              PROGBITS        00000000 2a761c 0c3660 00      0   0  4
  [26] .rel.dyn          REL             004cc360 0cc360 000010 08   A  5   0 16
  [27] .mdebug.abi32     PROGBITS        00000000 36ac7c 000000 00      0   0  1
  [28] .shstrtab         STRTAB          00000000 36ac7c 0000fb 00      0   0  1
  [29] .symtab           SYMTAB          00000000 36b250 0620a0 10     30  45  4
  [30] .strtab           STRTAB          00000000 3cd2f0 041ee7 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
$ mips-linux-readelf -r bigapp

Relocation section '.rel.dyn' at offset 0xcc360 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000000  00000000 R_MIPS_NONE      
1001f4f0  00314703 R_MIPS_REL32      004cc490   getpid
$ mips-linux-readelf -x 17 bigapp | grep 1001f4f0
  0x1001f4f0 004cc490 005ea570 00655ba0 0062c9e0 .L...^.p.e[..b..
$ mips-linux-readelf -s bigapp | grep getpid
 12615: 004cc490     0 FUNC    GLOBAL DEFAULT  UND getpid
  4109: 004cc490     0 FUNC    GLOBAL DEFAULT  UND getpid


Strangely the bigapp works correct if I compiled it with glibc 2.2.5.

Here is some outputs from readelf on bigapp.glibc:

$ mips-linux-readelf -S bigapp.glibc
There are 36 section headers, starting at offset 0x378644:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        00400114 000114 00000d 00   A  0   0  1
  [ 2] .note.ABI-tag     NOTE            00400130 000130 000020 00   A  0   0 16
  [ 3] .reginfo          MIPS_REGINFO    00400150 000150 000018 18   A  0   0  4
  [ 4] .dynamic          DYNAMIC         00400168 000168 0000f0 08   A  7   0  4
  [ 5] .hash             HASH            00400258 000258 028764 04   A  6   0  4
  [ 6] .dynsym           DYNSYM          004289bc 0289bc 061bc0 10   A  7   1  4
  [ 7] .dynstr           STRTAB          0048a57c 08a57c 041d6d 00   A  0   0  1
  [ 8] .gnu.version      VERSYM          004cc2ea 0cc2ea 00c378 02   A  6   0  2
  [ 9] .gnu.version_r    VERNEED         004d8664 0d8664 000020 00   A  7   1  4
  [10] .init             PROGBITS        004d86a0 0d86a0 0000ac 00  AX  0   0  4
  [11] .text             PROGBITS        004d8750 0d8750 1b7d40 00  AX  0   0 16
  [12] .fini             PROGBITS        00690490 290490 00005c 00  AX  0   0  4
  [13] .rodata           PROGBITS        006904f0 2904f0 000020 00   A  0   0 16
  [14] .data             PROGBITS        10000000 291000 000020 00  WA  0   0 16
  [15] .rld_map          PROGBITS        10000020 291020 000004 00  WA  0   0  4
  [16] .eh_frame         PROGBITS        10000024 291024 000004 00   A  0   0  4
  [17] .ctors            PROGBITS        10000028 291028 000008 00  WA  0   0  4
  [18] .dtors            PROGBITS        10000030 291030 000008 00  WA  0   0  4
  [19] .jcr              PROGBITS        10000038 291038 000004 00  WA  0   0  4
  [20] .got              PROGBITS        10000040 291040 022460 04 WAp  0   0 16
  [21] .sbss             NOBITS          100224a0 2b34a0 000000 00 WAp  0   0  1
  [22] .bss              NOBITS          100224a0 2b34a0 000020 00  WA  0   0 16
  [23] .comment          PROGBITS        00000000 2b34a0 0000b4 00      0   0  1
  [24] .debug_aranges    MIPS_DWARF      00000000 2b3558 000058 00      0   0  8
  [25] .debug_pubnames   MIPS_DWARF      00000000 2b35b0 000025 00      0   0  1
  [26] .debug_info       MIPS_DWARF      00000000 2b35d5 000c55 00      0   0  1
  [27] .debug_abbrev     MIPS_DWARF      00000000 2b422a 00012b 00      0   0  1
  [28] .debug_line       MIPS_DWARF      00000000 2b4355 00028e 00      0   0  1
  [29] .debug_str        MIPS_DWARF      00000000 2b45e3 000960 01  MS  0   0  1
  [30] .pdr              PROGBITS        00000000 2b4f44 0c35c0 00      0   0  4
  [31] .mdebug.abi32     PROGBITS        00000000 378504 000000 00      0   0  1
  [32] .rel.dyn          REL             004d8690 0d8690 000010 08   A  6   0 16
  [33] .shstrtab         STRTAB          00000000 378504 000140 00      0   0  1
  [34] .symtab           SYMTAB          00000000 378be4 062200 10     35  59  4
  [35] .strtab           STRTAB          00000000 3dade4 04204e 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
$ mips-linux-readelf -r bigapp.glibc

Relocation section '.rel.dyn' at offset 0xd8690 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000000  00000000 R_MIPS_NONE      
1001c3c0  00340403 R_MIPS_REL32      00000000   getpid
$ mips-linux-readelf -x 20 bigapp.glibc | grep 1001c3c0
  0x1001c3c0 00000000 0060d3e0 0063cd10 00608f70 .....`...c...`.p
$ mips-linux-readelf -s bigapp.glibc | grep getpid
 13316: 00000000     0 FUNC    GLOBAL DEFAULT  UND getpid@GLIBC_2.0 (2)
  2943: 00000000     0 FUNC    GLOBAL DEFAULT  UND getpid@@GLIBC_2.0


Is there other informations I can provide?

---
Atsushi Nemoto

----Next_Part(Thu_Oct_30_21:54:53_2003_617)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename=mkbigapp

#!/bin/awk -f
BEGIN {
	nfile = 5;
	nfunc = 5000;
	for (j = 0; j < nfile; j++) {
		fname = "src" j ".c";
		printf("/* %s */\n", fname) > fname;
		for (i = 0; i < nfunc; i++) {
			printf("void func%d_%d(void) {}\n", j, i, i) >> fname;
		}
		printf("int func%d(void) {\n", j) >> fname;
		for (i = 0; i < nfunc; i++) {
			printf("func%d_%d();\n", j, i) >> fname;
		}
		printf("return getpid();\n") >> fname;
		printf("}\n") >> fname;
		if (j == 0) {
			printf("int main(int argc, char **argv) {\n") > fname;
			for (i = 0; i < nfile; i++) {
				printf("printf(\"%%d\\n\", func%d());\n", i) >> fname;
			}
			printf("return 0;\n") >> fname;
			printf("}\n") >> fname;
		}
		close(fname);
	}
}

----Next_Part(Thu_Oct_30_21:54:53_2003_617)----
