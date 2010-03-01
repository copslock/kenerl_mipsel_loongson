Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 23:37:10 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:39727 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492357Ab0CAWgY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 23:36:24 +0100
Received: by mail-bw0-f226.google.com with SMTP id 26so2428417bwz.27
        for <multiple recipients>; Mon, 01 Mar 2010 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=yOJHgz4oZ6lVxPr5zG8jLM+sNB+d+AM9ujFe9dpnsk8=;
        b=UNnhPJmXL+TtC1fCZoB+jKlzmjpsR+jLtzdMyhIUM2gx1/mfKJaxtQ2V/i6Brvcqzy
         P57G7vKL+xzxANvMAt/MMvDUaxOopoE2gXNRPIUexdYLNJxDLXMFKVfY8nMfecyNScLp
         4BXoMSObhedsK3tWP392io9gZ3r5lP1iJd8IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=JIJUMjgaFVoNy/gW/MQZaPNe1dDEOMxzg5BFPRgqjQJexHJppMTqsZAYXc88kXubWv
         OjKgNIM0b+QZLY9bw6CH6bRzOBmwKoTj66uiC4j8HLFI1viz7XyZWFBbVlOJ+LMqcot8
         +8Wf6P/l18LH+6TGlcab2R70FB/dKvjQ2OMTA=
Received: by 10.204.6.70 with SMTP id 6mr3672920bky.6.1267482984256;
        Mon, 01 Mar 2010 14:36:24 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id s17sm1094853bkd.6.2010.03.01.14.36.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:36:23 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 1 Mar 2010 23:36:22 +0100
Subject: [PATCH 2/4] bcm63xx: add rta1025w_16 board
MIME-Version: 1.0
X-UID:  178
X-Length: 1823
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003012336.22578.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Add the RTA1025W-16 BCM6348-based board to the list of suppported boards.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 00fa96b..0b1d60f 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -380,6 +380,25 @@ static struct board_info __initdata board_FAST2404 = {
 	.has_ehci0			= 1,
 };
 
+static struct board_info __initdata board_rta1025w_16 = {
+	.name				= "RTA1025W_16",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+};
+
+
 static struct board_info __initdata board_DV201AMR = {
 	.name				= "DV201AMR",
 	.expected_cpu_id		= 0x6348,
@@ -569,6 +588,7 @@ static const struct board_info __initdata *bcm963xx_boards[] = {
 	&board_FAST2404,
 	&board_DV201AMR,
 	&board_96348gw_a,
+	&board_rta1025w_16,
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6358
