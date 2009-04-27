Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 16:00:03 +0100 (BST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:64624 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023685AbZD0O75 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 15:59:57 +0100
Received: by bwz25 with SMTP id 25so2451873bwz.0
        for <multiple recipients>; Mon, 27 Apr 2009 07:59:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type:message-id;
        bh=DotBlUOrJ+mXmlz1k2nO53m2YfWtW2t0fHrHX5BLDFY=;
        b=h178MFyFXo47yU7coNFMK/05OjIqUyFdzNGcFHiPGbgd0h7OGAlJ1YrG+MSwap+m6G
         uIpTv+d4iI4yMdabuGlGwdoTuv+zZ9EJkD2U23E90dGhincwqa+RrHOEhW5LVxhp0UXr
         L9+VCveRcufjQ8/l0nFvPl2aNj9S9ycWxcUiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:message-id;
        b=RrX6TonnA6qFOK550U9T4Nkzo5yyjrUIFfkMxEVQKqmLDbls9J4DxKn5vPBwVBxy+j
         kn+divrzRz0cplsSno6D5fjcsYyYo0WAbCwx0Bn+IcQ4Bh7/UWe4tCN1uETUPuNcGxyJ
         1JdWiJ5diEr4ctG1dMDymDQG/+kBWJ/Pto5JY=
Received: by 10.103.224.2 with SMTP id b2mr3296105mur.2.1240844390902;
        Mon, 27 Apr 2009 07:59:50 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id j10sm8411923muh.15.2009.04.27.07.59.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 07:59:50 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 27 Apr 2009 16:59:48 +0200
Subject: [PATCH] fix build failures on msp_irq_slp.c
MIME-Version: 1.0
X-UID:	109
X-Length: 1896
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_khc9JywEXo4Mi05"
Message-Id: <200904271659.48357.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--Boundary-00=_khc9JywEXo4Mi05
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Trying to build MSP4200 VoIP defconfig also fails on msp_irq_slp.c
with a non-existing reference to mask_slp_irq, which is in turn
mask_msp_slp_irq. Passed that, we will also miss a comma when
calling set_irq_chip_and_handler. This patch fixes both issues.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
index f5f1b8d..66f6f85 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
@@ -45,7 +45,7 @@ static inline void mask_msp_slp_irq(unsigned int irq)
  */
 static inline void ack_msp_slp_irq(unsigned int irq)
 {
-	mask_slp_irq(irq);
+	mask_msp_slp_irq(irq);
 
 	/*
 	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
@@ -79,7 +79,7 @@ void __init msp_slp_irq_init(void)
 
 	/* initialize all the IRQ descriptors */
 	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++)
-		set_irq_chip_and_handler(i, &msp_slp_irq_controller
+		set_irq_chip_and_handler(i, &msp_slp_irq_controller,
 					 handle_level_irq);
 }
 

--Boundary-00=_khc9JywEXo4Mi05
Content-Type: text/x-patch;
  name="0049-fix-build-failures-on-msp_irq_slp.c.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0049-fix-build-failures-on-msp_irq_slp.c.patch"

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
index f5f1b8d..66f6f85 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
@@ -45,7 +45,7 @@ static inline void mask_msp_slp_irq(unsigned int irq)
  */
 static inline void ack_msp_slp_irq(unsigned int irq)
 {
-	mask_slp_irq(irq);
+	mask_msp_slp_irq(irq);
 
 	/*
 	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
@@ -79,7 +79,7 @@ void __init msp_slp_irq_init(void)
 
 	/* initialize all the IRQ descriptors */
 	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++)
-		set_irq_chip_and_handler(i, &msp_slp_irq_controller
+		set_irq_chip_and_handler(i, &msp_slp_irq_controller,
 					 handle_level_irq);
 }
 

--Boundary-00=_khc9JywEXo4Mi05--
