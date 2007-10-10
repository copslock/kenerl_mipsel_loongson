Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 15:07:02 +0100 (BST)
Received: from mx1.minet.net ([157.159.40.25]:4782 "EHLO mx1.minet.net")
	by ftp.linux-mips.org with ESMTP id S20023306AbXJJOGx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2007 15:06:53 +0100
Received: by mx1.minet.net (Postfix, from userid 101)
	id 389405CD39; Wed, 10 Oct 2007 16:05:48 +0200 (CEST)
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id 9D4E45CD94
	for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 15:55:18 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id 446A3D338
	for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 05:10:50 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Wed, 10 Oct 2007 15:55:44 +0200
Subject: [PATCH] Remove select GENERIC_GPIO for PNX8550
MIME-Version: 1.0
X-UID:	107
X-Length: 1290
To:	linux-mips@linux-mips.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gnNDHpT6Aotx6ka"
Message-Id: <200710101555.44586.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--Boundary-00=_gnNDHpT6Aotx6ka
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch removes the selection of GENERIC_GPIO
for PNX8550 which was accidentally introduced with
commit 524022f507c1158adbcc2259671af01e6117dd5e

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
 arch/mips/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

--Boundary-00=_gnNDHpT6Aotx6ka
Content-Type: text/plain;
  charset="utf-8";
  name="cb644a00b290a2671730c98666d60e130f8be7e2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cb644a00b290a2671730c98666d60e130f8be7e2.diff"

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f775d8c..6c67fec 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -860,7 +860,6 @@ config SOC_PNX8550
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select SYS_SUPPORTS_KGDB
-	select GENERIC_GPIO
 
 config SWAP_IO_SPACE
 	bool

--Boundary-00=_gnNDHpT6Aotx6ka--
