Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 00:52:21 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:58833 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225518AbUBAAwU>; Sun, 1 Feb 2004 00:52:20 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 860714B4F3; Sun,  1 Feb 2004 01:52:18 +0100 (CET)
Date: Sun, 1 Feb 2004 01:52:18 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Warning while building current 2.6.x CVS
Message-ID: <20040201005218.GM20536@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/hP/389S7qb5BOej"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--/hP/389S7qb5BOej
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I get a warning while compiling current CVS (end of non-void function).
This patch would fix it...

MfG, JBG



Index: arch/mips/lib-32/dump_tlb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/arch/mips/lib-3=
2/dump_tlb.c,v
retrieving revision 1.2
diff -u -r1.2 dump_tlb.c
--- arch/mips/lib-32/dump_tlb.c	18 Dec 2003 21:52:33 -0000	1.2
+++ arch/mips/lib-32/dump_tlb.c	1 Feb 2004 00:46:22 -0000
@@ -31,6 +31,7 @@
 	case PM_64M:	return "64Mb";
 	case PM_256M:	return "256Mb";
 #endif
+	default:	return "unknown";
 	}
 }
=20
--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--/hP/389S7qb5BOej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAHE3CHb1edYOZ4bsRAs7VAJ9oluiTDgbxUpIIUpP/LYcE34hY9gCfVIxh
/yg/IEQO5SSlSjRaLrf10FU=
=su70
-----END PGP SIGNATURE-----

--/hP/389S7qb5BOej--
