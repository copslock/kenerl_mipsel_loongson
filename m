Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 15:55:10 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:39434 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225225AbTEPOy6>; Fri, 16 May 2003 15:54:58 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 050CF4AB9C; Fri, 16 May 2003 16:54:52 +0200 (CEST)
Date: Fri, 16 May 2003 16:54:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: 2.5.x on Indy r4600
Message-ID: <20030516145452.GJ27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030516134611.GH27494@lug-owl.de> <Pine.GSO.3.96.1030516161253.6533A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y87zqFmoGECkYaVu"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030516161253.6533A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--y87zqFmoGECkYaVu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-05-16 16:30:36 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1030516161253.6533A-100000@delta.ds2.pg.gda=
.pl>:
> On Fri, 16 May 2003, Jan-Benedict Glaw wrote:

[Non-booting 2.5.x on Indy]

> [...]
> > Sections:
> > Idx Name          Size      VMA       LMA       File off  Algn
> [...]
> >  14 .init.ramfs   00000080  881de000  881de000  001dc000  2**0
> >                   CONTENTS, ALLOC, LOAD, DATA
> >  15 .sbss         00000010  881df000  881df000  001dd000  2**3
> >                   ALLOC
> >  16 .bss          0003b620  881df020  881df020  001dd010  2**5
> >                   ALLOC
> >  17 .comment      00003e08  8821a640  8821a640  001dd010  2**0
> >                   CONTENTS, READONLY
> >  18 .pdr          0002b1e0  00000000  00000000  001e0e18  2**2
> >                   CONTENTS, READONLY
> >  19 .mdebug.abi32 00000000  00000000  00000000  0020bff8  2**0
> >                   CONTENTS, READONLY
>=20
>  Hmm, the NACK is reasonable as probably nothing beyond 1dc07f is loadable
> -- `objdump -p' would determine it definitely.  Better yet, please try

$ mips-linux-objdump -p indy-kernel

indy-kernel:     file format elf32-tradbigmips

Program Header:
0x70000000 off    0x001c6000 vaddr 0x881c8000 paddr 0x881c8000 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00001000 vaddr 0x88002000 paddr 0x88002000 align 2**12
         filesz 0x001a3b78 memsz 0x001a3b78 flags r-x
    LOAD off    0x001a5000 vaddr 0x881a6000 paddr 0x881a6000 align 2**12
         filesz 0x0001ec40 memsz 0x0001ec40 flags rw-
    LOAD off    0x001c4000 vaddr 0x881c6000 paddr 0x881c6000 align 2**12
         filesz 0x00018080 memsz 0x00054640 flags rwx
private flags =3D 10001001: [abi=3DO32] [mips2] [not 32bitmode]



> `readelf -Sl', which reports additional data beyond what's obtainable with

$ mips-linux-readelf -Sl indy-kernel

There are 24 section headers, starting at offset 0x20c0dc:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk I=
nf Al
  [ 0]                   NULL            00000000 000000 000000 00      0  =
 0  0
  [ 1] .text             PROGBITS        88002000 001000 176bfc 00  AX  0  =
 0 32
  [ 2] .rodata           PROGBITS        88178c00 177c00 022fd0 00   A  0  =
 0 16
  [ 3] .kstrtab          PROGBITS        8819bbd0 19abd0 005b2c 00   A  0  =
 0  4
  [ 4] __ex_table        PROGBITS        881a1700 1a0700 001ad8 00   A  0  =
 0  4
  [ 5] __dbe_table       PROGBITS        881a31d8 1a21d8 000000 00   A  0  =
 0  1
  [ 6] __ksymtab         PROGBITS        881a31d8 1a21d8 0029a0 00   A  0  =
 0  4
  [ 7] .data             PROGBITS        881a6000 1a5000 01d000 00  WA  0  =
 0 4096
  [ 8] .data.cacheline_a PROGBITS        881c3000 1c2000 001c40 00  WA  0  =
 0 32
  [ 9] .data.init_task   PROGBITS        881c6000 1c4000 002000 00  WA  0  =
 0  4
  [10] .reginfo          MIPS_REGINFO    881c8000 1c6000 000018 18   A  0  =
 0  4
  [11] .init.text        PROGBITS        881c8018 1c6018 0126c4 00  AX  0  =
 0  4
  [12] .init.data        PROGBITS        881da6dc 1d86dc 002f1c 00  WA  0  =
 0  4
  [13] .init.setup       PROGBITS        881dd600 1db600 0000d0 00  WA  0  =
 0  4
  [14] .initcall.init    PROGBITS        881dd6d0 1db6d0 0000d8 00  WA  0  =
 0  4
  [15] .init.ramfs       PROGBITS        881de000 1dc000 000080 00  WA  0  =
 0  1
  [16] .sbss             NOBITS          881df000 1dd000 000010 00 WAp  0  =
 0  8
  [17] .bss              NOBITS          881df020 1dd010 03b620 00  WA  0  =
 0 32
  [18] .comment          PROGBITS        8821a640 1dd010 003e08 00      0  =
 0  1
  [19] .pdr              PROGBITS        00000000 1e0e18 02b1e0 00      0  =
 0  4
  [20] .mdebug.abi32     PROGBITS        00000000 20bff8 000000 00      0  =
 0  1
  [21] .shstrtab         STRTAB          00000000 20bff8 0000e2 00      0  =
 0  1
  [22] .symtab           SYMTAB          00000000 20c49c 02bb90 10     23 1=
37f  4
  [23] .strtab           STRTAB          00000000 23802c 02e857 00      0  =
 0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

Elf file type is EXEC (Executable file)
Entry point 0x881c8058
There are 4 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  REGINFO        0x1c6000 0x881c8000 0x881c8000 0x00018 0x00018 R   0x4
  LOAD           0x001000 0x88002000 0x88002000 0x1a3b78 0x1a3b78 R E 0x1000
  LOAD           0x1a5000 0x881a6000 0x881a6000 0x1ec40 0x1ec40 RW  0x1000
  LOAD           0x1c4000 0x881c6000 0x881c6000 0x18080 0x54640 RWE 0x1000

 Section to Segment mapping:
  Segment Sections...
   00     .reginfo=20
   01     .text .rodata .kstrtab __ex_table __ksymtab=20
   02     .data .data.cacheline_aligned=20
   03     .data.init_task .reginfo .init.text .init.data .init.setup .initc=
all.init .init.ramfs .sbss .bss=20

> `objdump'.  But why that unloadable data is requested at all?=20

Thanks for looking at it! Maybe I'll get it up at some time:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--y87zqFmoGECkYaVu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+xPu8Hb1edYOZ4bsRAjTEAJwNQumvLp3s0v2BFQT4L00nx2L1XgCfQxHv
QA84J5eWULCt9uE88qBCaMc=
=cqs/
-----END PGP SIGNATURE-----

--y87zqFmoGECkYaVu--
