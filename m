Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 14:48:15 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:32676 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133656AbWBQOr2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 14:47:28 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id DAE7A5DF5B
	for <linux-mips@linux-mips.org>; Fri, 17 Feb 2006 15:54:06 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29617-03-2 for <linux-mips@linux-mips.org>;
	Fri, 17 Feb 2006 15:54:06 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 8A8865DF4D; Fri, 17 Feb 2006 15:54:06 +0100 (CET)
Date:	Fri, 17 Feb 2006 15:54:06 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Small time UART configuration fix for AU1100 processor
Message-ID: <20060217145406.GE14066@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--h3LYUU6HlUDSAOzy
Content-Type: multipart/mixed; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The AU1100 processor does not have an internal UART2. Only
UART0, UART1 and UART3 exist. This patch removes the non existing
UART2 and replaces it with a descriptive comment.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uart2.patch"

diff -Naur master.orig/drivers/serial/8250_au1x00.c master.good/drivers/serial/8250_au1x00.c
--- master.orig/drivers/serial/8250_au1x00.c	2006-02-17 10:57:28.000000000 +0000
+++ master.good/drivers/serial/8250_au1x00.c	2006-02-17 14:02:38.000000000 +0000
@@ -51,7 +51,7 @@
 #elif defined(CONFIG_SOC_AU1100)
 	PORT(UART0_ADDR, AU1100_UART0_INT),
 	PORT(UART1_ADDR, AU1100_UART1_INT),
-	PORT(UART2_ADDR, AU1100_UART2_INT),
+	/* The internal UART2 does not exist on the AU1100 processor. */
 	PORT(UART3_ADDR, AU1100_UART3_INT),
 #elif defined(CONFIG_SOC_AU1550)
 	PORT(UART0_ADDR, AU1550_UART0_INT),

--f5QefDQHtn8hx44O--

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9eOObxf9XXlB0eERAm6xAJ9tfIcSuMhg27t1QhnThmFsO4Aj+gCfS60V
J3YWh12F1UKObLTo+YKoKbI=
=k/9W
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
