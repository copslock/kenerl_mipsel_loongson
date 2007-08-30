Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 13:55:27 +0100 (BST)
Received: from host78-221-dynamic.2-87-r.retail.telecomitalia.it ([87.2.221.78]:51978
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022321AbXH3MzS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 13:55:18 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IQjVA-00012g-04
	for linux-mips@linux-mips.org; Thu, 30 Aug 2007 14:52:02 +0200
Subject: Re: Exception while loading kernel
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio>  <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
Content-Type: text/plain
Date:	Thu, 30 Aug 2007 14:52:22 +0200
Message-Id: <1188478342.6770.14.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Markus,

Il giorno mer, 29/08/2007 alle 04.25 +0200, Markus Gothe ha scritto:
> Use gdb and list the read address.

I think I understood what you mean. I recompiled the kernel adding the
debug symbols, stripped it and booted with it.
There I got those numbers (using the 32bit version):

Exception PC: 0x8021c9fc, Exception RA: 0x804ddc6c
gpda 0x81060e08, _regs 0x81061008
arg: 81070000 0 80503518 1
tmp: 81070000 1000 8051a868 fff8054f ffffffff 81412ef4 a13fab68 7
sve: 81070000 4083ae51 0 4608a976 0 4085cc91 0 3ed97758

then run gdb and issue those commands:

(gdb) info symbol 0x8021c9fc
__bzero + 56 in section .text
(gdb) info symbol 0x804ddc6c
init_bootmem_core + 196 in section .init.text
(gdb) list *0x804ddc6c
0x804ddc6c is in init_bootmem_core (mm/bootmem.c:107).
102              */
103             mapsize = get_mapsize(bdata);
104             memset(bdata->node_bootmem_map, 0xff, mapsize);
105
106             return mapsize;
107     }
108
109     /*
110      * Marks a particular physical memory range as unallocatable. Usable RAM
111      * might be used for boot-time allocations - or it might get added
(gdb) list *0x8021c9fc
No source file for address 0x8021c9fc.
(gdb) disassemble 0x804ddc6c
Dump of assembler code for function init_bootmem_core:
0xffffffff804ddba8 <init_bootmem_core+0>:       daddiu  sp,sp,-32
0xffffffff804ddbac <init_bootmem_core+4>:       sd      ra,16(sp)
0xffffffff804ddbb0 <init_bootmem_core+8>:       sd      s1,8(sp)
0xffffffff804ddbb4 <init_bootmem_core+12>:      sd      s0,0(sp)
0xffffffff804ddbb8 <init_bootmem_core+16>:      li      v0,-13
0xffffffff804ddbbc <init_bootmem_core+20>:      ld      s1,648(a0)
0xffffffff804ddbc0 <init_bootmem_core+24>:      dsll    a1,a1,0xc
0xffffffff804ddbc4 <init_bootmem_core+28>:      dsll32  v0,v0,0x1b
0xffffffff804ddbc8 <init_bootmem_core+32>:      daddu   a1,a1,v0
0xffffffff804ddbcc <init_bootmem_core+36>:      dsll    a2,a2,0xc
0xffffffff804ddbd0 <init_bootmem_core+40>:      sd      a1,16(s1)
0xffffffff804ddbd4 <init_bootmem_core+44>:      sd      a3,8(s1)
0xffffffff804ddbd8 <init_bootmem_core+48>:      sd      a2,0(s1)
0xffffffff804ddbdc <init_bootmem_core+52>:      lui     v1,0x0
0xffffffff804ddbe0 <init_bootmem_core+56>:      lui     at,0x8049
0xffffffff804ddbe4 <init_bootmem_core+60>:      daddiu  v1,v1,0
0xffffffff804ddbe8 <init_bootmem_core+64>:      dsll32  v1,v1,0x0
0xffffffff804ddbec <init_bootmem_core+68>:      daddu   v1,v1,at
0xffffffff804ddbf0 <init_bootmem_core+72>:      ld      v1,2112(v1)
0xffffffff804ddbf4 <init_bootmem_core+76>:      lui     a1,0x0
0xffffffff804ddbf8 <init_bootmem_core+80>:      lui     at,0x8049
0xffffffff804ddbfc <init_bootmem_core+84>:      daddiu  a1,a1,0
0xffffffff804ddc00 <init_bootmem_core+88>:      daddiu  at,at,2112
0xffffffff804ddc04 <init_bootmem_core+92>:      dsll32  a1,a1,0x0
0xffffffff804ddc08 <init_bootmem_core+96>:      daddu   a1,a1,at
0xffffffff804ddc0c <init_bootmem_core+100>:     bnel    v1,a1,0x804ddc88 <init_bootmem_core+224>
0xffffffff804ddc10 <init_bootmem_core+104>:     ld      v0,-48(v1)
0xffffffff804ddc14 <init_bootmem_core+108>:     daddiu  v0,s1,48
0xffffffff804ddc18 <init_bootmem_core+112>:     sd      a1,48(s1)
0xffffffff804ddc1c <init_bootmem_core+116>:     move    a0,s1
0xffffffff804ddc20 <init_bootmem_core+120>:     lui     at,0x0
0xffffffff804ddc24 <init_bootmem_core+124>:     daddiu  at,at,0
0xffffffff804ddc28 <init_bootmem_core+128>:     dsll    at,at,0x10
0xffffffff804ddc2c <init_bootmem_core+132>:     daddiu  at,at,-32695
0xffffffff804ddc30 <init_bootmem_core+136>:     dsll    at,at,0x10
0xffffffff804ddc34 <init_bootmem_core+140>:     sd      v0,2120(at)
0xffffffff804ddc38 <init_bootmem_core+144>:     lui     at,0x0
0xffffffff804ddc3c <init_bootmem_core+148>:     daddiu  at,at,0
0xffffffff804ddc40 <init_bootmem_core+152>:     dsll    at,at,0x10
0xffffffff804ddc44 <init_bootmem_core+156>:     daddiu  at,at,-32695
0xffffffff804ddc48 <init_bootmem_core+160>:     dsll    at,at,0x10
0xffffffff804ddc4c <init_bootmem_core+164>:     sd      v0,2112(at)
0xffffffff804ddc50 <init_bootmem_core+168>:     jal     0x804dd5c8 <get_mapsize>
0xffffffff804ddc54 <init_bootmem_core+172>:     sd      a1,8(v0)
0xffffffff804ddc58 <init_bootmem_core+176>:     ld      a0,16(s1)
0xffffffff804ddc5c <init_bootmem_core+180>:     move    s0,v0
0xffffffff804ddc60 <init_bootmem_core+184>:     li      a1,255
0xffffffff804ddc64 <init_bootmem_core+188>:     jal     0x8021c9a0 <memset>
0xffffffff804ddc68 <init_bootmem_core+192>:     move    a2,v0
0xffffffff804ddc6c <init_bootmem_core+196>:     move    v0,s0
0xffffffff804ddc70 <init_bootmem_core+200>:     ld      ra,16(sp)
0xffffffff804ddc74 <init_bootmem_core+204>:     ld      s1,8(sp)
0xffffffff804ddc78 <init_bootmem_core+208>:     ld      s0,0(sp)
0xffffffff804ddc7c <init_bootmem_core+212>:     jr      ra
[...]
(gdb) info line *0x804ddc6c
Line 107 of "mm/bootmem.c" starts at address 0x804ddc6c <init_bootmem_core+196> and ends at 0x804ddc88 <init_bootmem_core+224>.
(gdb) info line *0x804ddc6b
Line 104 of "mm/bootmem.c" starts at address 0x804ddc60 <init_bootmem_core+184> and ends at 0x804ddc6c <init_bootmem_core+196>.


So, it this what you requested?

>From what I understand the problem may be that bdata->node_bootmem_map
maybe incorrectly initialised for this machine.

Bye,
Giuseppe
