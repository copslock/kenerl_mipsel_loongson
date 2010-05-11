Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 11:19:44 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:35411 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491111Ab0EKJTk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 May 2010 11:19:40 +0200
Received: by wwb22 with SMTP id 22so2363042wwb.36
        for <multiple recipients>; Tue, 11 May 2010 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=pbMVpo5rzswu2AWZFbFrR/dS6QYt5arYI0xs0PJJggg=;
        b=e3KtdDKBu1VAY/x4by5jhnNa4uOpgcLpIakuQMQNWCH0oMiMOKs0vbcWC+YKRr3Iga
         BXebz+vRknMkhKlIQxLuyvXorUl9D/5fh82s7hN8h6vEQqK5DfDR61XeIvRAbYjGhbSr
         SIj+u1vuUWUvo7Jrb5xuWprcFNrRFO0HAhx9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=F4Zx5Q7n9FroVDyb4dBw1DtQyrdD/tMRImqvvr4G1bN0U2hHaDIqcUblrVqKgc2xyK
         ZnvrCBw/FyaGCxc9/vlVa1eKCi3jgX1keTwizihUAFkuSCKppkGV4oP+IsoSJkKA5PlA
         vFVJ5YdL+JhOBFr6wKcVDJfDdRPTxPfQF0sJ8=
Received: by 10.216.156.133 with SMTP id m5mr3256589wek.115.1273569574153;
        Tue, 11 May 2010 02:19:34 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id t70sm1990202weq.2.2010.05.11.02.19.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 02:19:33 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 11 May 2010 11:20:09 +0200
Subject: [PATCH 1/2] AR7: use ar7_has_high_vlynq() to determine watchdog base address
MIME-Version: 1.0
X-UID:  64
X-Length: 1908
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201005111120.09710.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Instead of doing yet another switch/case on the chip_id, use existing
inline function to set the watchdog base address.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 2fafc78..1d4a466 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -576,7 +576,6 @@ static int __init ar7_register_devices(void)
 {
 	void __iomem *bootcr;
 	u32 val;
-	u16 chip_id;
 	int res;
 
 	res = ar7_register_uarts();
@@ -635,18 +634,10 @@ static int __init ar7_register_devices(void)
 	val = readl(bootcr);
 	iounmap(bootcr);
 	if (val & AR7_WDT_HW_ENA) {
-		chip_id = ar7_chip_id();
-		switch (chip_id) {
-		case AR7_CHIP_7100:
-		case AR7_CHIP_7200:
-			ar7_wdt_res.start = AR7_REGS_WDT;
-			break;
-		case AR7_CHIP_7300:
+		if (ar7_has_high_vlynq())
 			ar7_wdt_res.start = UR8_REGS_WDT;
-			break;
-		default:
-			break;
-		}
+		else
+			ar7_wdt_res.start = AR7_REGS_WDT;
 
 		ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
 		res = platform_device_register(&ar7_wdt);
