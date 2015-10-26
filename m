Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 07:56:28 +0100 (CET)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38676 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008859AbbJZG41BXLiT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 07:56:27 +0100
Received: by wicll6 with SMTP id ll6so99918280wic.1;
        Sun, 25 Oct 2015 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AcEErKymQLwXldYq4elJk/azoddleyfe9Z1LWVvqv0M=;
        b=E+5lcdbGkXXU/+qi0QLOrBG0rgCJmVaAoajjK3mwbMNxAj5gbAFYf7uXIwWYDER1fo
         4O98G2DrxqlziPur+KORqpq6k1E58Dps+LftxFd4RLQyxnKT0zXPaZ9jADS0EWwWFmEw
         Q1U1XD8UB1mPav/c7kG21bIHZqpHNve/vtGJFSxXNP2RHZP0G1rj2sf79aBC+oVE2YzL
         1XgtMTD0hhU0f51X9OaftYwVWIvLqdJIlZCGsTUcEDU9Jw0D6w1IQxfssWP8DPvcz8vg
         j/+0qGdRkKHAgNMWnAiNkFRA2D0avR5yxaimrh1C1kBzWxgGY+0hKAB+7g7Khtcx6IUI
         60tA==
X-Received: by 10.180.86.232 with SMTP id s8mr18663087wiz.35.1445842581696;
        Sun, 25 Oct 2015 23:56:21 -0700 (PDT)
Received: from linux-tdhb.lan ([217.153.142.106])
        by smtp.gmail.com with ESMTPSA id kr10sm37163722wjc.25.2015.10.25.23.56.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2015 23:56:21 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47xx: Fetch board info directly in callback function
Date:   Mon, 26 Oct 2015 07:56:15 +0100
Message-Id: <1445842575-22354-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49688
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

This drops another symbol dependency between setup.c and sprom.c which
will allow us to make SPROM code a separated module (and share it with
ARM).
Patch tested on Linksys WRT300N V1.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/setup.c                    | 11 ++++++++++-
 arch/mips/bcm47xx/sprom.c                    | 13 -------------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |  5 -----
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 17503a0..af0c683 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -105,11 +105,20 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 				  struct ssb_init_invariants *iv)
 {
 	char buf[20];
+	int len;
 
 	/* Fill boardinfo structure */
 	memset(&iv->boardinfo, 0 , sizeof(struct ssb_boardinfo));
 
-	bcm47xx_fill_ssb_boardinfo(&iv->boardinfo, NULL);
+	len = bcm47xx_nvram_getenv("boardvendor", buf, sizeof(buf));
+	if (len > 0)
+		kstrtou16(strim(buf), 0, &iv->boardinfo.vendor);
+	if (!iv->boardinfo.vendor)
+		iv->boardinfo.vendor = SSB_BOARDVENDOR_BCM;
+
+	len = bcm47xx_nvram_getenv("boardtype", buf, sizeof(buf));
+	if (len > 0)
+		kstrtou16(strim(buf), 0, &iv->boardinfo.type);
 
 	memset(&iv->sprom, 0, sizeof(struct ssb_sprom));
 	bcm47xx_fill_sprom(&iv->sprom, NULL, false);
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 43353db..a7e569c 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -599,19 +599,6 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 	bcm47xx_sprom_fill_auto(sprom, prefix, fallback);
 }
 
-#ifdef CONFIG_BCM47XX_SSB
-void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
-				const char *prefix)
-{
-	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0,
-		       true);
-	if (!boardinfo->vendor)
-		boardinfo->vendor = SSB_BOARDVENDOR_BCM;
-
-	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0, true);
-}
-#endif
-
 #if defined(CONFIG_BCM47XX_SSB)
 static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 {
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 1461c10..71e4096 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -48,11 +48,6 @@ extern enum bcm47xx_bus_type bcm47xx_bus_type;
 void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 			bool fallback);
 
-#ifdef CONFIG_BCM47XX_SSB
-void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
-				const char *prefix);
-#endif
-
 void bcm47xx_set_system_type(u16 chip_id);
 
 #endif /* __ASM_BCM47XX_H */
-- 
1.8.4.5
