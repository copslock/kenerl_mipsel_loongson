Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 23:37:33 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:38502 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492349Ab0CAWga (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 23:36:30 +0100
Received: by mail-bw0-f226.google.com with SMTP id 26so2428504bwz.27
        for <multiple recipients>; Mon, 01 Mar 2010 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=cxpTMaEW94/4aqeJAKh7Jzx0BRNnmpm4tWu2KoqchoY=;
        b=vOJ5J41m9eDctw0w+QBnzUHVMRIRoihSqCYJIFNKYCIwsqBe4tPl4pYjzJorpgs/qT
         PtpwTxxySmeWAL5SyzP1pyLkf2nhDfrEDp9Aw9aseheVLmeqJ5obuUlCOmZG4W0r9wQb
         kGGB8rsrC3VwFwkK0uDX5p8KP4OIpvqVZzIYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=VJkrRQPmgPdRW0G4NPqFH1qVddq6YRWpO2TXP0jSzzS9tmsft3MjoeIbQiRZ9me2Pi
         RVyyJz/4DKnHb4Y4F2irl/vz1kmcLDX0xI+s/c6UMI7EtJoc7OLzesQ97KDqEB9GlztJ
         JaU3wxBk8G9hnFefuBlzqtW/O01euLEmh+qA4=
Received: by 10.204.20.137 with SMTP id f9mr3587707bkb.130.1267482990399;
        Mon, 01 Mar 2010 14:36:30 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id p13sm1095155bkp.9.2010.03.01.14.36.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:36:29 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 1 Mar 2010 23:36:27 +0100
Subject: [PATCH 3/4] bcm63xx: add DWVS0 board
MIME-Version: 1.0
X-UID:  179
X-Length: 1693
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003012336.28071.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

The DWVS0 board is a BCM6358-based board with an on-board OHCI controler.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 0b1d60f..8bf2c01 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -567,6 +567,27 @@ static struct board_info __initdata board_AGPFS0 = {
 	.has_ohci0 = 1,
 	.has_ehci0 = 1,
 };
+
+static struct board_info __initdata board_DWVS0 = {
+	.name				= "DWV-S0",
+	.expected_cpu_id		= 0x6358,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0 = 1,
+};
 #endif
 
 /*
@@ -595,6 +616,7 @@ static const struct board_info __initdata *bcm963xx_boards[] = {
 	&board_96358vw,
 	&board_96358vw2,
 	&board_AGPFS0,
+	&board_DWVS0,
 #endif
 };
 
