Received:  by oss.sgi.com id <S553941AbQKLUAy>;
	Sun, 12 Nov 2000 12:00:54 -0800
Received: from air.lug-owl.de ([62.52.24.190]:11537 "HELO air.lug-owl.de")
	by oss.sgi.com with SMTP id <S553934AbQKLUAw>;
	Sun, 12 Nov 2000 12:00:52 -0800
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 06133826A; Sun, 12 Nov 2000 21:00:49 +0100 (CET)
Date:   Sun, 12 Nov 2000 21:00:49 +0100
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     linux-mips@oss.sgi.com
Subject: Build failure for R3000 DECstation
Message-ID: <20001112210049.C26606@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I see this build failure:

mipsel-linux-gcc -D__KERNEL__ -I/usr/src/mipsel/linux/include -Wall -Wstric=
t-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=3Dr=
3000 -mips1 -pipe     -c -o sysmips.o sysmips.c
sysmips.c: In function `sys_sysmips':
sysmips.c:109: warning: implicit declaration of function `syscall_trace'
{standard input}: Assembler messages:
{standard input}:337: Error: opcode requires -mips2 or greater `ll'
{standard input}:339: Error: opcode requires -mips2 or greater `sc'
{standard input}:340: Error: opcode requires -mips2 or greater `beqzl'
{standard input}:341: Error: opcode requires -mips2 or greater `ll'
make[1]: *** [sysmips.o] Error 1

jbglaw@bootserver:/usr/src/mipsel/linux/arch/mips/kernel$ mipsel-linux-gcc =
-v
Reading specs from /usr/lib/gcc-lib/mipsel-linux/egcs-2.90.29/specs
gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoO9vEACgkQHb1edYOZ4bs4tgCbBACk+hXQGJtovwyapHVUCh/4
vFwAoIky6Q3+Ffh/ZkwTNN/taHY0Vu6p
=b1Cv
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
