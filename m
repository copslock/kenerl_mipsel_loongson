Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARBs2x14574
	for linux-mips-outgoing; Tue, 27 Nov 2001 03:54:02 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARBrlo14568
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 03:53:47 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id AB8D383E; Tue, 27 Nov 2001 11:53:40 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A489F3F47; Tue, 27 Nov 2001 11:48:49 +0100 (CET)
Date: Tue, 27 Nov 2001 11:48:49 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Cc: linux-mips@oss.sgi.com, karel@sparta.research.kpn.com
Subject: Re: Decstation /150 kernel (cvs) problems
Message-ID: <20011127114849.D27987@paradigm.rfc822.org>
References: <20011127025622.D28037@paradigm.rfc822.org> <200111270753.IAA24915@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <200111270753.IAA24915@sparta.research.kpn.com>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 08:53:40AM +0100, Houten K.H.C. van (Karel) wrote:
> I've noticed that recent kernels can't be booted by delo.
> As far as I have dug into that, it might be the changed loadaddr,
> that is hardcoded in delo...

Delo should load the kernel to a specific address and then move
the single ELF segments to their address in the ELF header (copyelf.c).

> TFTP booting the same kernel does indeed start the kernel
> (for me it usually crashes or hangs some moments later).

*Urgs* I'am just having a look at it... It looks the elf segments have
changed moved and its either overwriting itself or the prom.

>>boot 3/rz0 2/linux.test
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok                                 =20
Loading /boot/vmlinux-2.4.14 ................ ok             =20
fhdr->e_entry =3D fhdr->e_shoff =3D 1549940/17a674               =20
fhdr->e_phoff =3D 52/34                                        =20
fhdr->e_shentsize =3D 40
fhdr->e_shnum =3D 20
fhdr->e_shstrndx =3D fhdr->e_phentsize =3D fhdr->e_phnum =3D  0 0017a674
00000000 00000000 00000000 00000000 00000000
 1 0017a69c 00000001 80040000 00001000 00131ed0 00000000
memcpy( 2 0017a6c4 00000001 80171ed0 00132ed0 00000e6c 00000000
memcpy( 3 0017a6ec 00000001 80172d3c 00133d3c 000035b4 00000000
memcpy( 4 0017a714 00000001 801762f0 001372f0 00001b98 00000000
memcpy( 5 0017a73c 00000001 80177e88 00138e88 00000000 00000000
 6 0017a764 00000001 80177e88 00138e88 00001a38 00000000
memcpy( 7 0017a78c 00000001 8017a000 0013b000 0000c30c 00000000
memcpy( 8 0017a7b4 00000001 8018630c 0014730c 0000040c 00000000
memcpy( 9 0017a7dc 00000001 80186720 00147720 000000a0 00000000
memcpy(10 0017a804 00000001 801867c0 001477c0 00000070 00000000
memcpy(11 0017a82c 00000001 80187000 00148000 00000260 00000000
memcpy(12 0017a854 70000006 80187260 00148260 00000018 00000000
13 0017a87c 00000001 80187280 00148280 00011d80 00000000
memcpy(14 0017a8a4 00000008 80199000 0015a000 000256e0 00000000
memset(15 0017a8cc 00000001 801be6e0 0015a000 00003a33 00000000
memcpy(16 0017a8f4 00000001 00000000 0015da34 0001cb80 00000000
memcpy(


When having a look at the kernel file it looks broken - Have a look
at segment 16 which is type PROGBITS but address "0"=20

(flo@paradigm)/tmp/i/linux# readelf -e vmlinux=20
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00=20
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x8004046c
  Start of program headers:          52 (bytes into file)
  Start of section headers:          1549940 (bytes into file)
  Flags:                             0x10000001, noreorder, mips2
UNKNOWN
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         2
  Size of section headers:           40 (bytes)
  Number of section headers:         20
  Section header string table index: 17

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk I=
nf Al
  [ 0]                   NULL            00000000 000000 000000 00 0   0  0
  [ 1] .text             PROGBITS        80040000 001000 131ed0 00  AX 0   =
0 8192
  [ 2] .fixup            PROGBITS        80171ed0 132ed0 000e6c 00  AX 0   =
0  1
  [ 3] .kstrtab          PROGBITS        80172d3c 133d3c 0035b4 00   A 0   =
0  4
  [ 4] __ex_table        PROGBITS        801762f0 1372f0 001b98 00   A 0   =
0  4
  [ 5] __dbe_table       PROGBITS        80177e88 138e88 000000 00   A 0   =
0  1
  [ 6] __ksymtab         PROGBITS        80177e88 138e88 001a38 00   A 0   =
0  4
  [ 7] .text.init        PROGBITS        8017a000 13b000 00c30c 00  AX 0   =
0  4
  [ 8] .data.init        PROGBITS        8018630c 14730c 00040c 00  WA 0   =
0  4
  [ 9] .setup.init       PROGBITS        80186720 147720 0000a0 00  WA 0   =
0  4
  [10] .initcall.init    PROGBITS        801867c0 1477c0 000070 00  WA 0   =
0  4
  [11] .data.cacheline_a PROGBITS        80187000 148000 000260 00  WA 0   =
0 32
  [12] .reginfo          MIPS_REGINFO    80187260 148260 000018 18   A 0   =
0  4
  [13] .data             PROGBITS        80187280 148280 011d80 00  WA 0   =
0 32
  [14] .bss              NOBITS          80199000 15a000 0256e0 00  WA 0   =
0 32
  [15] .comment          PROGBITS        801be6e0 15a000 003a33 00 0   0  1
  [16] .pdr              PROGBITS        00000000 15da34 01cb80 00 0   0  4
  [17] .shstrtab         STRTAB          00000000 17a5b4 0000bd 00 0   0  1
  [18] .symtab           SYMTAB          00000000 17a994 01dfe0 10 19 cf2  4
  [19] .strtab           STRTAB          00000000 198974 01e130 00 0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor
specific)

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg
Align
  REGINFO        0x148260 0x80187260 0x80187260 0x00018 0x00018 R   0x4
  LOAD           0x001000 0x80040000 0x80040000 0x159000 0x17e6e0 RWE
0x1000

 Section to Segment mapping:
  Segment Sections...
   00     .reginfo=20
   01     .text .fixup .kstrtab __ex_table __ksymtab .text.init
=2Edata.init .setup.init .initcall.init .data.cacheline_aligned .reginfo
=2Edata .bss=20



(flo@paradigm)/tmp/i/linux# mipsel-linux-gcc --version
3.0.2
(flo@paradigm)/tmp/i/linux# mipsel-linux-as --version
GNU assembler 2.11.92.0.10 Debian/GNU Linux
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `mipsel-linux'.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A2+RUaz2rXW+gJcRApJUAKCvFj7pO15Bk22zsUc3QoZnyMxNOgCgq4Gp
Lg4yL6KcE3ETKuRDVhMtNBA=
=T88G
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
