Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jan 2014 14:52:18 +0100 (CET)
Received: from mail-ee0-f42.google.com ([74.125.83.42]:50774 "EHLO
        mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831302AbaAFNwMr5efI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jan 2014 14:52:12 +0100
Received: by mail-ee0-f42.google.com with SMTP id e53so7840082eek.15
        for <multiple recipients>; Mon, 06 Jan 2014 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CAnAfhwM1NfE9bgVGdbgnb0duc1a4K7n1Gpw237djQw=;
        b=VRd3/TFq84XHPA35aDWY6isDleawvxZlvMtdT/KzARbAFqZIAtEbPpamsOgv+KiHK6
         PaBFvpck9/eLJXucYyfr2I1mJ2f5jSHycFYJBxfXONr+hrxNkobqfyx65wCnX/kUJ+oQ
         Z/ecyv7gJdzVWrUnCheMlnv8JWBsFElsuKuv2OC0taniCQ1t5/iWzfgTF9BvYFHt+O1Z
         VNkyikoLSVHdRNCh9AZwwLQQmZVv8XzXoxBPKjlc8rtje8cpZTyfPUHOV29/Pak3uTy4
         PpnrO7B3Bwxo8ordYyX5dsuaAQfiw32UjGlVdTJjtG9JhMhL5mxSOnp97qiRKEcGhBs0
         QspQ==
X-Received: by 10.14.221.193 with SMTP id r41mr15846565eep.92.1389016326833;
        Mon, 06 Jan 2014 05:52:06 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id a51sm171134414eeh.8.2014.01.06.05.52.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2014 05:52:06 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2] MIPS: BCM47XX: fix position of cpu_wait disabling
Date:   Mon,  6 Jan 2014 14:51:59 +0100
Message-Id: <1389016319-22381-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1388685979-20678-1-git-send-email-hauke@hauke-m.de>
References: <1388685979-20678-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Hauke Mehrtens <hauke@hauke-m.de>

The disabling of cpu_wait was done too early, before the detection was
done. This moves the code to a position where it actually works.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: Remove empty spaces at ends of lines
---
 arch/mips/bcm47xx/setup.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 0bd4702..fb74862 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -205,15 +205,6 @@ static void __init bcm47xx_register_bcma(void)
 		panic("Failed to initialize BCMA bus (err %d)", err);
 
 	bcm47xx_fill_bcma_boardinfo(&bcm47xx_bus.bcma.bus.boardinfo, NULL);
-
-	/* The BCM4706 has a problem with the CPU wait instruction.
-	 * When r4k_wait or r4k_wait_irqoff is used will just hang and 
-	 * not return from a msleep(). Removing the cpu_wait 
-	 * functionality is a workaround for this problem. The BCM4716 
-	 * does not have this problem.
-	 */
-	if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
-		cpu_wait = NULL;
 }
 #endif
 
@@ -244,6 +235,31 @@ void __init plat_mem_setup(void)
 	mips_set_machine_name(bcm47xx_board_get_name());
 }
 
+static int __init bcm47xx_cpu_fixes(void)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		/* Nothing to do */
+		break;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		/* The BCM4706 has a problem with the CPU wait instruction.
+		 * When r4k_wait or r4k_wait_irqoff is used will just hang and
+		 * not return from a msleep(). Removing the cpu_wait
+		 * functionality is a workaround for this problem. The BCM4716
+		 * does not have this problem.
+		 */
+		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
+			cpu_wait = NULL;
+		break;
+#endif
+	}
+	return 0;
+}
+arch_initcall(bcm47xx_cpu_fixes);
+
 static struct fixed_phy_status bcm47xx_fixed_phy_status __initdata = {
 	.link	= 1,
 	.speed	= SPEED_100,
-- 
1.7.10.4
