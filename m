Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 13:49:41 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:55055 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225192AbTCaMtl>; Mon, 31 Mar 2003 13:49:41 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 632784AB75; Mon, 31 Mar 2003 14:49:40 +0200 (CEST)
Date: Mon, 31 Mar 2003 14:49:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: [Patch-2.5] Add path to elf2ecoff
Message-ID: <20030331124940.GL26678@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64LDleNqNegJ4g97"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--64LDleNqNegJ4g97
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This small patch is needed since `pwd` is _not_ the directory a
Makefile resides in.

MfG, JBG


Index: arch/mips/boot/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/arch/mips/boot/=
Makefile,v
retrieving revision 1.22
diff -u -r1.22 Makefile
--- arch/mips/boot/Makefile	9 Mar 2003 13:58:13 -0000	1.22
+++ arch/mips/boot/Makefile	31 Mar 2003 12:38:59 -0000
@@ -32,7 +32,7 @@
 		$< $@
=20
 vmlinux.ecoff:	$(obj)/elf2ecoff vmlinux
-	./elf2ecoff vmlinux $(obj)/vmlinux.ecoff $(E2EFLAGS)
+	$(obj)/elf2ecoff vmlinux $(obj)/vmlinux.ecoff $(E2EFLAGS)
=20
 $(obj)/elf2ecoff: $(obj)/elf2ecoff.c
 	$(HOSTCC) -o $@ $^


--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--64LDleNqNegJ4g97
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+iDlkHb1edYOZ4bsRAkoLAJ0aDO4aKZL2Fgc8QmaD4x/TMQwg7QCcDA7d
WbvSBw4KFYJNxRDFc73oLZU=
=gaEl
-----END PGP SIGNATURE-----

--64LDleNqNegJ4g97--
