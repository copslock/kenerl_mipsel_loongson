Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2006 16:47:14 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:27049 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20038596AbWILPrK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Sep 2006 16:47:10 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 97E5A5E693;
	Tue, 12 Sep 2006 17:46:57 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lvNvkVIrPEEo; Tue, 12 Sep 2006 17:46:57 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 33E765E473; Tue, 12 Sep 2006 17:46:57 +0200 (CEST)
Date:	Tue, 12 Sep 2006 17:46:57 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	adaplas@pol.net
Cc:	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: [PATCH] Fix to remove flickering.
Message-ID: <20060912154656.GY10006@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i/VKSWANvDZSIhsB"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--i/VKSWANvDZSIhsB
Content-Type: multipart/mixed; boundary="yC91f7qSViS67v3c"
Content-Disposition: inline


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antonino,

Currently a lot of flickering is seen on the VGA and LCD port
when one starts a DBAu1100 board, with 'CONFIG_PRINTK=3Dy'.

This patch removes the flickering and as a result all kernel
messages come by in a nice steady fashion.

Please apply.

Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1100fb.patch"

diff -Naur linux-2.6.17.13-orig/drivers/video/au1100fb.h linux-2.6.17.13/drivers/video/au1100fb.h
--- linux-2.6.17.13-orig/drivers/video/au1100fb.h	2006-09-09 03:23:25.000000000 +0000
+++ linux-2.6.17.13/drivers/video/au1100fb.h	2006-09-12 15:26:52.000000000 +0000
@@ -274,7 +274,7 @@
 		.bpp = 16,
 		.control_base =	0x0004886A |
 			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
-			LCD_CONTROL_BPP_16,
+			LCD_CONTROL_BPP_16 | LCD_CONTROL_SBB_4,
 		.clkcontrol_base = 0x00020000,
 		.horztiming = 0x005aff1f,
 		.verttiming = 0x16000e57,

--yC91f7qSViS67v3c--

--i/VKSWANvDZSIhsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBtZwbxf9XXlB0eERAtcRAJ98NI4P0gat6ROB3UcIs37ebhNqbQCgibi+
sKl0Oq602P5FsbJhrqksMXA=
=RJn2
-----END PGP SIGNATURE-----

--i/VKSWANvDZSIhsB--
