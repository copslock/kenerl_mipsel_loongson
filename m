Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA29540
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 00:40:10 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA3992410; Wed, 30 Jun 1999 15:38:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA72780
	for linux-list;
	Wed, 30 Jun 1999 15:35:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA33643
	for <linux@engr.sgi.com>;
	Wed, 30 Jun 1999 15:35:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08270
	for <linux@engr.sgi.com>; Wed, 30 Jun 1999 15:35:50 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-20.uni-koblenz.de [141.26.131.20])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA26344
	for <linux@engr.sgi.com>; Thu, 1 Jul 1999 00:35:13 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA30446;
	Thu, 1 Jul 1999 00:34:58 +0200
Date: Thu, 1 Jul 1999 00:34:58 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu,
        Linux Announce Mailinglist <linux-announce@sws1.ctd.ornl.gov>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kirill Malkin <malkin@reldata.com>
Subject: New Linux/MIPS crosscompilers available
Message-ID: <19990701003458.A30366@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi,

I've uploaded new patches to build native and cross binutils and compilers
for mips-linux and mipsel-linux targets for Linux/MIPS on ftp.linux.sgi.com
into /pub/linux/mips/crossdev/src/ rsp.  /pub/linux/mips/crossdev/src/egcs/.

Binaries of binutils and egcs are available for the following types of
hosts are available in /pub/linux/mips/crossdev/

  - Linux/i386 (glibc 2.1 required)
  - Linux/Alpha (glibc 2.0 or newer required)
  - Linux/Sparc (glibc 2.0 or newer required)
  - Linux/PPC (glibc 2.0 or newer required)

Credits for providing the Alpha and Sparc binaries go to Arnaldo Carvalho
de Melo (acme@conectiva.com.br).

Please read the list of changes to the patch files and RPM packages below.

Please report problems ralf@uni-koblenz.de or one of the Linux/MIPS
mailing lists.

  Ralf

Changes to egcs since egcs 1.0.2:

 - Fixed #ident operator to generate .ident, not .string.

 You must upgrade binutils to at least binutils-2.8.1-1.diff before you can
 use or build this compiler.

 You must installed this compiler release if you want to compile modutils;
 previous releases were producing bad code.

Changes to binutils since version binutils-2.8.1-2.diff:

 - TLB instructions are now applied to the same instruction scheduling
   rules as other coprocessor instructions.
 - Rebuilt the binary RPM using the new patch.

 You must upgrade to binutils-2.8.1-2.diff if you wish to compile Linux/MIPS
 kernels for R3000 CPUs.

Changes to binutils since version binutils-2.8.1-1.diff:

 - Fix the .ident pseudo op in gas to handle sections correctly.

 You must upgrade to at least this version before you want to upgrade
 to egcs-1.0.3a.diff.

66f22d90c7bdbf77035f35a4cffa0e63  binutils-2.8.1-3.diff.gz
24906a53ab1abc105256d29e4928a77e  binutils-mips-linux-2.8.1-1.alpha.rpm
331bbbe37ec6005a429d8e5886ccba1c  binutils-mipsel-linux-2.8.1-1.alpha.rpm
17c1a924b4934040e6a5d0f7eef42278  binutils-mips-linux-2.8.1-1.i386.rpm
1e45a295ec695b241434332721144b1e  binutils-mipsel-linux-2.8.1-1.i386.rpm
c3214c60813f045e72ca2162a23c717e  binutils-mips-linux-2.8.1-1.ppc.rpm
30652af3c6d6daf390f1c8b682dcdbde  binutils-mipsel-linux-2.8.1-1.ppc.rpm
289f49618cb1fd122c0a1080575e30b8  binutils-mips-linux-2.8.1-1.sparc.rpm
489e2e34bf8d1671645b85fb3c630f68  binutils-mipsel-linux-2.8.1-1.sparc.rpm
ef30d241f81c13cf443631bcd5ab1914  cross-binutils-2.8.1-1.src.rpm
e64f9950999f3e0850ba7f73e65b75e5  cross-egcs-1.0.3a-1.src.rpm
5f57e092d9b5f221054332fc039dc4ff  egcs-1.0.3a-2.diff.gz
04b9084199eb234b588ae8fcdb930dac  egcs-c++-mips-linux-1.0.3a-1.alpha.rpm
f10ddf2c07d2fd36ad02bed7a3e3acc7  egcs-c++-mipsel-linux-1.0.3a-1.alpha.rpm
bbcfe6b7b1594d639156b90687fb4a5c  egcs-g77-mips-linux-1.0.3a-1.alpha.rpm
1ccb88ad648f1ee762f45788e4a61e79  egcs-g77-mipsel-linux-1.0.3a-1.alpha.rpm
67af9cea602b93b6d125e569a3f938b3  egcs-libstdc++-mips-linux-2.8.0-1.alpha.rpm
f0d2a5c19cbaf63859405f725f41818b  egcs-libstdc++-mipsel-linux-2.8.0-1.alpha.rpm
e3bf275316b98adb6367304d9db01a1d  egcs-mips-linux-1.0.3a-1.alpha.rpm
1ae65785a9deb0cdedb5a656ade821c4  egcs-mipsel-linux-1.0.3a-1.alpha.rpm
720e571214f8d9ba05a998a10704af6b  egcs-objc-mips-linux-1.0.3a-1.alpha.rpm
32bc3f37365483d5b65bd1aa4c8e0876  egcs-objc-mipsel-linux-1.0.3a-1.alpha.rpm
3d0dc466d92175c121300bdef4881a33  egcs-c++-mips-linux-1.0.3a-1.i386.rpm
c4272a37fe8e57b3f9bb8be738274836  egcs-c++-mipsel-linux-1.0.3a-1.i386.rpm
c0de740218490e1b5256c002df724e9e  egcs-g77-mips-linux-1.0.3a-1.i386.rpm
9d539da26bb07b7edca4c2106cb23d3a  egcs-g77-mipsel-linux-1.0.3a-1.i386.rpm
e6bd26ab57563f6d6e854325728fe3f2  egcs-libstdc++-mips-linux-2.8.0-1.i386.rpm
42300569bb1356d4c3209006700f1c6a  egcs-libstdc++-mipsel-linux-2.8.0-1.i386.rpm
9d69a4a9bb481ff8bde126b58e13f184  egcs-mips-linux-1.0.3a-1.i386.rpm
a84256a9295121d8042e0a5a8f1127ea  egcs-mipsel-linux-1.0.3a-1.i386.rpm
e5583f2486e5a87e4715e2a0757f316d  egcs-objc-mips-linux-1.0.3a-1.i386.rpm
0a1d9166d05c40fe242ebf3e8e4c9d67  egcs-objc-mipsel-linux-1.0.3a-1.i386.rpm
f0f1d54a00c61541326d7a9c6fabd856  egcs-c++-mips-linux-1.0.3a-1.ppc.rpm
f28e90e7bf2494be0c55d85a15ed7763  egcs-c++-mipsel-linux-1.0.3a-1.ppc.rpm
ee7eb7f1bb1a24ba024ef6b16eb140d1  egcs-g77-mips-linux-1.0.3a-1.ppc.rpm
599424fb7cb8c6f9c665b4724be07bc8  egcs-g77-mipsel-linux-1.0.3a-1.ppc.rpm
bf4a42ed26188fd3deaceeaf864d7765  egcs-libstdc++-mips-linux-2.8.0-1.ppc.rpm
770888f1c4c2882c9e5d1c6627c3ab81  egcs-libstdc++-mipsel-linux-2.8.0-1.ppc.rpm
be4bf0ac5d0804fcd6a31ec88cfe651e  egcs-mips-linux-1.0.3a-1.ppc.rpm
679de1a46ea47ef7a829e6abcb47a257  egcs-mipsel-linux-1.0.3a-1.ppc.rpm
3ab9e864b8b3d58bcac6c07fa7363daf  egcs-objc-mips-linux-1.0.3a-1.ppc.rpm
c48aaeabd8b7373ee8fd3b358fa0869c  egcs-objc-mipsel-linux-1.0.3a-1.ppc.rpm
f5dacd4ad42184f57a8cff6ea650e4be  egcs-c++-mips-linux-1.0.3a-1.sparc.rpm
09f2301fc208bf434fb83c6ccebe9752  egcs-c++-mipsel-linux-1.0.3a-1.sparc.rpm
dd9630b77a2ec7fa057da244040b4d6d  egcs-g77-mips-linux-1.0.3a-1.sparc.rpm
26c01a32ec26cbc1746bca05c9726e3b  egcs-g77-mipsel-linux-1.0.3a-1.sparc.rpm
f6c2debe62d93ddedf95a91ee98805fb  egcs-libstdc++-mips-linux-2.8.0-1.sparc.rpm
3da0d34a7420762c75fe477416451b71  egcs-libstdc++-mipsel-linux-2.8.0-1.sparc.rpm2ab9227097946bfbd4e795a07cad82a1  egcs-mips-linux-1.0.3a-1.sparc.rpm
0f19e28546a185da5969442a6d35b495  egcs-mipsel-linux-1.0.3a-1.sparc.rpm
6cdcfe0d1b52d3fd033c64a289ee4836  egcs-objc-mips-linux-1.0.3a-1.sparc.rpm
32ca712e0aa483520afe39b87b0fc6ab  egcs-objc-mipsel-linux-1.0.3a-1.sparc.rpm

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i
Charset: latin1

iQCVAwUBN3qbV0ckbl6vezDBAQGUsgP9F1VrQQELRKgm5SuVG7z13235ZgBmRnhA
dYkE9NQMY798XedAnuf7SmZZGeaqYivM1/td8AXaDG8gueMcAzOoIkNhdeOGBVj2
L7CilWqpW60iMdTsjbXYT+azD4/xAB8CoBnK7hgEeZIqkEgTXfxPuOeb8G+2NAGc
QpMp1L5xE+k=
=Spnq
-----END PGP SIGNATURE-----
