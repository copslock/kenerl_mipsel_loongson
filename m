Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 14:46:21 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:53257 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225217AbTEPNqN>; Fri, 16 May 2003 14:46:13 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id C07514AB9E; Fri, 16 May 2003 15:46:11 +0200 (CEST)
Date: Fri, 16 May 2003 15:46:11 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: 2.5.x on Indy r4600
Message-ID: <20030516134611.GH27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zs32KGgguTW8DKq/"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--zs32KGgguTW8DKq/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently tryin' to get 2.5.x running on MIPS (for background,
please read http://www.lug-owl.de/~jbglaw/linux-ports/ ). I got current
CVS HEAD to build (with minor tweaks), but my Indy doesn't completely
load the kernel (via tftp). It starts loading the kernel, but TFTP
packet #3810 (containing bytes 1950208..1950719 resp. 1dc200..1dc3ff
from the kernel file) gets NACKed with error (5), code 3 (wrt. ethereal,
this is "Disk full or allocation exceeded"). After this, the box seems to
be completely dead: no serial break, no power button, no reset
button...).

Because 2.4.x basically runs on this machine, I suspect the linker
script changes. I've tried some older versions (added missing symbols
into them) to see if I can overcome these loading problems. Up to now, I
failed. Here's my kernel image's "objdump -h" output:

$ mips-linux-objdump -h indy-kernel

indy-kernel:     file format elf32-tradbigmips

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00176bfc  88002000  88002000  00001000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00022fd0  88178c00  88178c00  00177c00  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .kstrtab      00005b2c  8819bbd0  8819bbd0  0019abd0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 __ex_table    00001ad8  881a1700  881a1700  001a0700  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 __dbe_table   00000000  881a31d8  881a31d8  001a21d8  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 __ksymtab     000029a0  881a31d8  881a31d8  001a21d8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .data         0001d000  881a6000  881a6000  001a5000  2**12
                  CONTENTS, ALLOC, LOAD, DATA
  7 .data.cacheline_aligned 00001c40  881c3000  881c3000  001c2000  2**5
                  CONTENTS, ALLOC, LOAD, DATA
  8 .data.init_task 00002000  881c6000  881c6000  001c4000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  9 .reginfo      00000018  881c8000  881c8000  001c6000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_SIZE
 10 .init.text    000126c4  881c8018  881c8018  001c6018  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 11 .init.data    00002f1c  881da6dc  881da6dc  001d86dc  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 12 .init.setup   000000d0  881dd600  881dd600  001db600  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 13 .initcall.init 000000d8  881dd6d0  881dd6d0  001db6d0  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 14 .init.ramfs   00000080  881de000  881de000  001dc000  2**0
                  CONTENTS, ALLOC, LOAD, DATA
 15 .sbss         00000010  881df000  881df000  001dd000  2**3
                  ALLOC
 16 .bss          0003b620  881df020  881df020  001dd010  2**5
                  ALLOC
 17 .comment      00003e08  8821a640  8821a640  001dd010  2**0
                  CONTENTS, READONLY
 18 .pdr          0002b1e0  00000000  00000000  001e0e18  2**2
                  CONTENTS, READONLY
 19 .mdebug.abi32 00000000  00000000  00000000  0020bff8  2**0
                  CONTENTS, READONLY

Does anybody have some suggestions for me?

MfG, JBG
--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--zs32KGgguTW8DKq/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+xOujHb1edYOZ4bsRAs9VAJ9PcQObYrp48PggU9ACKFSli9uGjQCcDAtT
1EjKGV3VemlpqrKC5p+EUM0=
=FUH9
-----END PGP SIGNATURE-----

--zs32KGgguTW8DKq/--
