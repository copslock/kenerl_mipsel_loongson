Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2OLI6o02735
	for linux-mips-outgoing; Sat, 24 Mar 2001 13:18:06 -0800
Received: from air.lug-owl.de (air.lug-owl.de [62.52.24.190])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2OLI5M02732
	for <linux-mips@oss.sgi.com>; Sat, 24 Mar 2001 13:18:05 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 67DFF7C63; Sat, 24 Mar 2001 22:17:59 +0100 (CET)
Date: Sat, 24 Mar 2001 22:17:58 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: elf2ecoff problem
Message-ID: <20010324221757.B9810@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Operating-System: Linux air 2.4.2
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to get a bootable kernel from fridays CVS sources for a
R3k DECstation. The elf kernel compiles fine, but elf2ecoff fails:

make[1]: Entering directory `/home/jbglaw/kernel_src/work/mips_linux/linux/=
arch/mips/boot'
gcc -o elf2ecoff elf2ecoff.c
=2E/elf2ecoff /home/jbglaw/kernel_src/work/mips_linux/linux/vmlinux vmlinux=
.ecoff -a
Non-contiguous data can't be converted.
make[1]: *** [vmlinux.ecoff] Error 1
make[1]: Leaving directory `/home/jbglaw/kernel_src/work/mips_linux/linux/a=
rch/mips/boot'
make: *** [boot] Error 2


Any hints? I'm using binutils and gcc from simple/crossdev, but that
doesn't seem to be the problem here...

jbglaw@schaufenster:~/kernel_src/work/mips_linux/linux$ mipsel-linux-objdum=
p -h vmlinux

vmlinux:     file format elf32-littlemips

Sections:
Idx Name          Size      VMA               LMA               File off  A=
lgn
  0 .text         00144590  ffffffff80040000  ffffffff80040000  00001000  2=
**13
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .fixup        000010f0  ffffffff80184590  ffffffff80184590  00145590  2=
**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .kstrtab      000031d4  ffffffff80185680  ffffffff80185680  00146680  2=
**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 __ex_table    00001fc0  ffffffff80188860  ffffffff80188860  00149860  2=
**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 __dbe_table   00000000  ffffffff8018a820  ffffffff8018a820  0014b820  2=
**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 __ksymtab     00001888  ffffffff8018a820  ffffffff8018a820  0014b820  2=
**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .text.init    0000dd78  ffffffff8018e000  ffffffff8018e000  0014e000  2=
**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  7 .data.init    0000049c  ffffffff8019bd78  ffffffff8019bd78  0015bd78  2=
**2
                  CONTENTS, ALLOC, LOAD, DATA
  8 .setup.init   00000088  ffffffff8019c220  ffffffff8019c220  0015c220  2=
**2
                  CONTENTS, ALLOC, LOAD, DATA
  9 .initcall.init 00000058  ffffffff8019c2a8  ffffffff8019c2a8  0015c2a8  =
2**2
                  CONTENTS, ALLOC, LOAD, DATA
 10 .data.cacheline_aligned 00000200  ffffffff8019d000  ffffffff8019d000  0=
015d000  2**4
                  CONTENTS, ALLOC, LOAD, DATA
 11 .reginfo      00000018  ffffffff8019d200  ffffffff8019d200  0015d200  2=
**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_SIZE
 12 .data         00012890  ffffffff8019d220  ffffffff8019d220  0015d220  2=
**4
                  CONTENTS, ALLOC, LOAD, DATA
 13 .sbss         000002b8  ffffffff801afab0  ffffffff801afab0  0016fab0  2=
**3
                  ALLOC
 14 .bss          000259f0  ffffffff801afd70  ffffffff801afd70  0016fab8  2=
**4
                  ALLOC
 15 .mdebug       00084158  ffffffff801d5760  ffffffff801d5760  001700b8  2=
**2
                  CONTENTS, READONLY, DEBUGGING
 16 .note         00001720  ffffffff80271978  ffffffff80271978  001f4210  2=
**0
                  CONTENTS, READONLY
 17 .modinfo      00000018  ffffffff802730a0  ffffffff802730a0  001700a0  2=
**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjq9DwUACgkQHb1edYOZ4bvWpQCfYMvCVvSnOAcn6z1Fs04HpvNB
Ns8An3X2UcS6ZLnuDHEQrdcVCCutf3ge
=UN4S
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
