Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 16:50:53 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:61928
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224861AbTDQPus>; Thu, 17 Apr 2003 16:50:48 +0100
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 196BeY-0003TF-00; Thu, 17 Apr 2003 17:50:22 +0200
Received: from [62.109.119.183] (helo=bruno.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 196BeY-0003k4-00; Thu, 17 Apr 2003 17:50:22 +0200
From: Bruno Randolf <bruno.randolf@4g-systems.de>
Organization: 4G Mobile Systeme
To: ilya@theIlya.com
Subject: Re: insmod segfault
Date: Thu, 17 Apr 2003 17:50:13 +0200
User-Agent: KMail/1.5.1
References: <200304171329.37998.bruno.randolf@4g-systems.de> <20030417145911.GC4485@gateway.total-knowledge.com>
In-Reply-To: <20030417145911.GC4485@gateway.total-knowledge.com>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Cc: linux-mips@linux-mips.org
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304171750.17603.bruno.randolf@4g-systems.de>
Return-Path: <bruno.randolf@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

thanks for the tip - i have that defined in hello_module.c

bruno

On Thursday 17 April 2003 16:59, you wrote:
> I think you have to add -DMODULE when compiling soemthing as module...
>
> On Thu, Apr 17, 2003 at 01:29:33PM +0200, Bruno Randolf wrote:
> Content-Description: clearsigned data
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > hello!
> >
> > i have problems with a kernel module: when i insmod it, i get a
> > segmentation fault and "Unable to handle kernel paging request at virtual
> > address 00000004" oops, so as far as i understand it, it seems like
> > relocation does not occur properly.
> >
> > i can reproduce the problem with the attached simple test code. when i
> > insmod only hello_module.o it works fine, but when i insmod the result of
> > "ld" (mod.o) i get the error. so it seems the problem is with the linker.
> > or am i using wrong compiler / linker flags or doing something stupid?
> >
> > i compile with "gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> > - -fno-strict-aliasing -mno-abicalls -G 0 -fno-pic -mcpu=r4600 -mips2
> > - -Wa,--trap -pipe -mlong-calls -I/usr/src/linux/include -O3 -D__KERNEL__
> > - -DLINUX -DMESSAGES"
> >
> > and link with "ld -r -o mod.o hello_module.o b.o"
> >
> > versions:
> > * au1500 CPU
> > * kernel version 2.4.21-pre4 from cvs
> > * gcc version 3.0.4 (also: gcc version 2.95.4)
> > * GNU ld version 2.12.90.0.1 20020307 Debian/GNU Linux
> > * insmod version 2.4.15
> >
> > objdump -x mod.o says:
> >
> > - ---
> >
> > mod.o:     file format elf32-tradlittlemips
> > mod.o
> > architecture: mips:6000, flags 0x00000011:
> > HAS_RELOC, HAS_SYMS
> > start address 0x00000000
> > private flags = 10001001: [abi=O32] [mips2] [not 32bitmode]
> >
> > Sections:
> > Idx Name          Size      VMA               LMA               File off
> > Algn 0 .reginfo      00000018  00000000  00000000  00000034  2**2
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA,
> > LINK_ONCE_SAME_SIZE 1 .text         00000070  00000000  00000000
> > 00000050  2**4
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >   2 .rodata       00000030  00000000  00000000  000000c0  2**4
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   3 .modinfo      0000001c  00000000  00000000  000000f0  2**2
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   4 .data         00000000  00000000  00000000  00000110  2**4
> >                   CONTENTS, ALLOC, LOAD, DATA
> >   5 .sbss         00000000  00000000  00000000  00000110  2**0
> >                   ALLOC
> >   6 .bss          00000000  00000000  00000000  00000110  2**4
> >                   ALLOC
> >   7 .comment      00000024  00000000  00000000  00000110  2**0
> >                   CONTENTS, READONLY
> >   8 .pdr          00000040  00000000  00000000  00000134  2**2
> >                   CONTENTS, RELOC, READONLY
> > SYMBOL TABLE:
> > 00000000 l    d  .reginfo       00000000
> > 00000000 l    d  .text  00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    d  .rodata        00000000
> > 00000000 l    d  .modinfo       00000000
> > 00000000 l    d  .data  00000000
> > 00000000 l    d  .sbss  00000000
> > 00000000 l    d  .bss   00000000
> > 00000000 l    d  .comment       00000000
> > 00000000 l    d  .pdr   00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    d  *ABS*  00000000
> > 00000000 l    df *ABS*  00000000 hello_module.c
> > 00000000 l     O .modinfo       0000001b __module_kernel_version
> > 00000000 l    df *ABS*  00000000 b.c
> > 00000004 g     O .scommon       00000004 b
> > 00000038 g     F .text  00000000 cleanup_module
> > 00000000 g     F .text  00000000 init_module
> > 00000000         *UND*  00000000 printk
> > 00000004 g     O .scommon       00000004 glob_int
> >
> >
> > RELOCATION RECORDS FOR [.text]:
> > OFFSET   TYPE              VALUE
> > 00000008 R_MIPS_HI16       .rodata
> > 0000000c R_MIPS_LO16       .rodata
> > 00000010 R_MIPS_HI16       printk
> > 00000014 R_MIPS_LO16       printk
> > 00000028 R_MIPS_HI16       glob_int
> > 0000002c R_MIPS_LO16       glob_int
> > 00000040 R_MIPS_HI16       .rodata
> > 00000044 R_MIPS_LO16       .rodata
> > 00000048 R_MIPS_HI16       printk
> > 0000004c R_MIPS_LO16       printk
> >
> >
> > RELOCATION RECORDS FOR [.pdr]:
> > OFFSET   TYPE              VALUE
> > 00000000 R_MIPS_32         init_module
> > 00000020 R_MIPS_32         cleanup_module
> >
> > - ---
> >
> > thanks for any hints.
> >
> > btw: this issue is not related to the one i posted about before
> > ("au1500mm problems") - which is resolved already and was caused by a
> > wrong initialization of the dual PHY ethernet hardware.
> >
> > bruno
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.2.1 (GNU/Linux)
> >
> > iD8DBQE+npAhfg2jtUL97G4RAu5qAJ4xWO8tpPYTCTkcWzkIn3D2ylhAhQCgo2As
> > dAXSGorKOTB9E6C1r3I1WEU=
> > =2wA9
> > -----END PGP SIGNATURE-----

- --
4G Mobile Systeme GmbH
Sierichstrasse 149
22299 Hamburg
fon: +49 (0)40 / 48 40 33 28
fax: +49 (0)40 / 48 40 33 30
mail: bruno.randolf@4g-systems.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ns05fg2jtUL97G4RAp8BAJ9ljWye7MxVLhY5rTOJ/qiIjO+OCwCfdAfz
ERNTs8nJjR7x8NEWEN3Vsk0=
=cBUe
-----END PGP SIGNATURE-----
