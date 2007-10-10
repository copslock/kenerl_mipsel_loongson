Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 14:05:56 +0100 (BST)
Received: from mx1.minet.net ([157.159.40.25]:9698 "EHLO mx1.minet.net")
	by ftp.linux-mips.org with ESMTP id S20022194AbXJJNFr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2007 14:05:47 +0100
Received: from localhost (unknown [192.168.1.97])
	by mx1.minet.net (Postfix) with ESMTP id 84BCF5CD1C
	for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 15:04:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at minet.net
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id 5BD375CD25
	for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 14:55:42 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id AF17BD338
	for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 04:11:13 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Wed, 10 Oct 2007 14:55:55 +0200
Subject: [PATCH] Add missing generic GPIO option support for au1000
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
X-UID:	104
X-Length: 1275
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_evMDHXZ9IbR0RL6"
Message-Id: <200710101455.58249.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--Boundary-00=_evMDHXZ9IbR0RL6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

With the generic GPIO support for au1000, we do not
select it in the kernel configuration.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
 arch/mips/au1000/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--Boundary-00=_evMDHXZ9IbR0RL6
Content-Type: text/plain;
  charset="utf-8";
  name="8dea23a2b6dae52267b3a969e715d3f0753acf47.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="8dea23a2b6dae52267b3a969e715d3f0753acf47.diff"

diff --git a/arch/mips/au1000/Kconfig b/arch/mips/au1000/Kconfig
index 29c95d9..f03b2eb 100644
--- a/arch/mips/au1000/Kconfig
+++ b/arch/mips/au1000/Kconfig
@@ -141,3 +141,4 @@ config SOC_AU1X00
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
 	select SYS_SUPPORTS_KGDB
+	select GENERIC_GPIO

--Boundary-00=_evMDHXZ9IbR0RL6--
