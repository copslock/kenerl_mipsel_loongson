Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 09:42:33 +0100 (BST)
Received: from minnie.intcom.nl ([217.115.199.145]:65233 "EHLO
	minnie.intcom.nl") by ftp.linux-mips.org with ESMTP
	id S20028879AbYHLIm1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 09:42:27 +0100
Received: from localhost (minnie.intcom.nl [127.0.0.1])
	by minnie.intcom.nl (Postfix) with ESMTP id 52267374848;
	Tue, 12 Aug 2008 10:42:26 +0200 (CEST)
X-Virus-Scanned: IntCom scan amavisd-new at minnie.intcom.nl
Received: from minnie.intcom.nl ([127.0.0.1])
	by localhost (minnie.intcom.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kzsmsL-ExgrH; Tue, 12 Aug 2008 10:42:25 +0200 (CEST)
Received: by minnie.intcom.nl (Postfix, from userid 1000)
	id 457993748D8; Tue, 12 Aug 2008 10:42:25 +0200 (CEST)
Date:	Tue, 12 Aug 2008 10:42:25 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Cc:	Antonino Daplas <adaplas@gmail.com>, source@embeddedalley.com
Subject: Re: [PATCH] Fixes small option parsing bug in au1100fb.c.
Message-ID: <20080812084225.GA5879@dusktilldawn.nl>
References: <20080108113944.GG31548@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20080108113944.GG31548@dusktilldawn.nl>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--xXmbgvnjoT4axfJE
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 08, 2008 at 12:39:45PM +0100, Freddy Spierenburg wrote:
> I've noticed that drivers/video/au1100fb.c contains a small time
> option parsing bug. In the middle of an if...else if...
> construction was inserted a lonesome if on it's own. This is
> causing an incorrect 'unsupported option' warning, while the
> option itself is parsed successfully.
>=20
> This patch makes the lonesome if part of the whole if...else
> if... construction, like it should be. No longer the incorrect
> warning message will be displayed.
>=20
>=20
> Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

The email above I wrote last january. Unfortunately 2.6.26.2
still does not feature this correction. I tested it today and
the patch still applies cleanly. I myself use this patch and can
confirm it works.

Can anybody please apply?


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--cWoXeonUoKmBZSoM
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

--cWoXeonUoKmBZSoM--

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIoUzxbxf9XXlB0eERAiAYAJ9I30Iype909AtJnQ+Pbr3jnS4OSQCgilFg
7haSYwnpiqXJ12fCog3ycX0=
=9te/
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
