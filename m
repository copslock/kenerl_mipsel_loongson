Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 16:07:15 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:15300 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20023234AbXIYPHN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 16:07:13 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 2AEDF8E6E3E;
	Tue, 25 Sep 2007 17:06:24 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 32658D0E315;
	Tue, 25 Sep 2007 17:06:24 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	blogic@openwrt.org, nbd@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 1/3] MTX1 : fix wrong ifdef leading to USB switch not powered
Date:	Tue, 25 Sep 2007 17:07:24 +0200
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart37215530.6ueQjyZ4jY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709251707.25419.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart37215530.6ueQjyZ4jY
Content-Type: multipart/mixed;
  boundary="Boundary-01=_tQS+GXgXlakp0D8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_tQS+GXgXlakp0D8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch fixes a wrong ifdef in the board setup code, leading to the GPIO=
=20
pin not being pulled high, and thus the USB switch not being powered at all.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
=2D-=20

--Boundary-01=_tQS+GXgXlakp0D8
Content-Type: text/plain;
  charset="us-ascii";
  name="usb-power.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="usb-power.patch"

diff --git a/arch/mips/au1000/mtx-1/board_setup.c b/arch/mips/au1000/mtx-1/=
board_setup.c
index 7bc5af8..1a2a5ca 100644
=2D-- a/arch/mips/au1000/mtx-1/board_setup.c
+++ b/arch/mips/au1000/mtx-1/board_setup.c
@@ -54,7 +54,7 @@ void board_reset (void)
=20
 void __init board_setup(void)
 {
=2D#ifdef CONFIG_USB_OHCI
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)=20
 	// enable USB power switch
 	au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
 	au_writel( 0x100000, GPIO2_OUTPUT );

--Boundary-01=_tQS+GXgXlakp0D8--

--nextPart37215530.6ueQjyZ4jY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG+SQtmx9n1G/316sRAvCFAJ0ae/hDiPyCrdbv1qMlzEZdTF1afACgw0Gr
/qHWB8SpiCDMzX7QaxNcQ4g=
=Ll7L
-----END PGP SIGNATURE-----

--nextPart37215530.6ueQjyZ4jY--
