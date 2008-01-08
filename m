Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 11:40:03 +0000 (GMT)
Received: from tool.snarl.nl ([82.95.241.19]:46353 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20029396AbYAHLjy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jan 2008 11:39:54 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 346565E19B;
	Tue,  8 Jan 2008 12:39:46 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id r9dEal5BF-a1; Tue,  8 Jan 2008 12:39:45 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 7D8325DFB2; Tue,  8 Jan 2008 12:39:45 +0100 (CET)
Date:	Tue, 8 Jan 2008 12:39:45 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Antonino Daplas <adaplas@gmail.com>, source@embeddedalley.com
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Fixes small option parsing bug in au1100fb.c.
Message-ID: <20080108113944.GG31548@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--y96v7rNg6HAoELs5
Content-Type: multipart/mixed; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've noticed that drivers/video/au1100fb.c contains a small time
option parsing bug. In the middle of an if...else if...
construction was inserted a lonesome if on it's own. This is
causing an incorrect 'unsupported option' warning, while the
option itself is parsed successfully.

This patch makes the lonesome if part of the whole if...else
if... construction, like it should be. No longer the incorrect
warning message will be displayed.


Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1100fb.c-patch"

diff -Naur linux-2.6.23-orig/drivers/video/au1100fb.c linux-2.6.23/drivers/video/au1100fb.c
--- linux-2.6.23-orig/drivers/video/au1100fb.c	2008-01-08 11:07:13.000000000 +0000
+++ linux-2.6.23/drivers/video/au1100fb.c	2008-01-08 11:13:37.000000000 +0000
@@ -707,7 +707,8 @@
  					print_warn("Panel %s not supported!", this_opt);
 				}
 			}
-			if (!strncmp(this_opt, "nocursor", 8)) {
+			/* No cursor option */
+			else if (!strncmp(this_opt, "nocursor", 8)) {
 				this_opt += 8;
 				nocursor = 1;
 				print_info("Cursor disabled");

--Hlh2aiwFLCZwGcpw--

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHg2EAbxf9XXlB0eERAqJ8AJ4jgY2hIa8/+sJ/PZvQJbjbS3So/QCg5HNh
PO6EM0qsXdH/+BHt+YoLcZU=
=mo8r
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
