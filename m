Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 20:53:26 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:7598 "EHLO smtp2.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20024072AbXESTxZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 May 2007 20:53:25 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 3EC8D30A43
	for <linux-mips@linux-mips.org>; Sat, 19 May 2007 21:52:47 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: [PATCH 1/2] Add MIPS generic GPIO support
Date:	Sat, 19 May 2007 21:51:37 +0200
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3854567.y6R4gSk0uk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200705192151.37338.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-MCPCheck: 
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart3854567.y6R4gSk0uk
Content-Type: multipart/mixed;
  boundary="Boundary-01=_JV1TGrXFenrKCni"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_JV1TGrXFenrKCni
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds support for the generic GPIO API to MIPS boards.
=2D-=20
Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>

--Boundary-01=_JV1TGrXFenrKCni
Content-Type: text/plain;
  charset="us-ascii";
  name="mips-gpio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mips-gpio.patch"

--- linux-2.6.21.1/include/asm-mips/gpio.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.21.1.new/include/asm-mips/gpio.h	2007-05-19 21:34:14.000000000 +0200
@@ -0,0 +1,7 @@
+#ifndef _ASM_MIPS_GPIO_H
+#define _ASM_MIPS_GPIO_H
+
+/* Not all MIPS platforms support this API */
+#include <asm-generic/gpio.h>
+
+#endif /* _ASM_MIPS_GPIO_H

--Boundary-01=_JV1TGrXFenrKCni--

--nextPart3854567.y6R4gSk0uk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGT1VJmx9n1G/316sRAnslAJ0WHNkYyNSoZgyg4PlYLXcFP7w9bgCZAdrq
gt7fCMEq3SGUwLLM3qYaX5A=
=V2vY
-----END PGP SIGNATURE-----

--nextPart3854567.y6R4gSk0uk--
