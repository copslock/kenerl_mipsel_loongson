Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 11:13:38 +0100 (CET)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37008 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009217AbbJZKNgopWXc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 11:13:36 +0100
Received: by wicfv8 with SMTP id fv8so108103546wic.0;
        Mon, 26 Oct 2015 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oNni/ExsKPgcE5Ra73/JYMDlMKzxHGBVeUnQVHQvZBI=;
        b=Ws6/NwsXrNoPp15/LisMrQKGUo9r2DhXG+wafLJbIB/KYcPJASs6FmgwjNMki8PZpg
         DPUjhAzq85D9f74ZhGJa0lLmaoChR0WwVkqkrpvuuyCQoTVr+xMWc62LmVRg9WeSbZvh
         Pnjtcj+KO0/CsLHoB98Iqxzi5Z8bZ7A5YgjwKpp6nk+h/pQYg5eF4ovLxbFtTifh9RKH
         GmRmC+WpYLZKXDFymUzJxCew2C3rn48MZBj4EwHix2wyj8RT0Ac1e0W0YHCx1wwpP9/b
         WoVTJq2dVXld55AkCNccbxtGHtAeiGrG/yAsmV27goHmhD85sli5kwzzyP0t9AkdsPyz
         7Z+A==
X-Received: by 10.194.91.164 with SMTP id cf4mr19135192wjb.139.1445854411285;
        Mon, 26 Oct 2015 03:13:31 -0700 (PDT)
Received: from linux-tdhb.lan ([217.153.142.106])
        by smtp.gmail.com with ESMTPSA id r5sm4985004wia.19.2015.10.26.03.13.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 03:13:30 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47xx: Fetch board info directly in callback function
Date:   Mon, 26 Oct 2015 11:13:16 +0100
Message-Id: <1445854396-12981-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1445842575-22354-1-git-send-email-zajec5@gmail.com>
References: <1445842575-22354-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49690
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
V2: Fix:
arch/mips/bcm47xx/setup.c: In function ‘bcm47xx_get_invariants’:
arch/mips/bcm47xx/setup.c:115:12: error: ignoring return value of ‘kstrtou16’, declared with attribute warn_unused_result
arch/mips/bcm47xx/setup.c:121:12: error: ignoring return value of ‘kstrtou16’, declared with attribute warn_unused_result
---
 arch/mips/bcm47xx/setup.c                    | 19 ++++++++++++++++++-
 arch/mips/bcm47xx/sprom.c                    | 13 -------------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |  5 -----
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 17503a0..6d38948 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -105,11 +105,28 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 				  struct ssb_init_invariants *iv)
 {
 	char buf[20];
+	int len, err;
 
 	/* Fill boardinfo structure */
 	memset(&iv->boardinfo, 0 , sizeof(struct ssb_boardinfo));
 
-	bcm47xx_fill_ssb_boardinfo(&iv->boardinfo, NULL);
+	len = bcm47xx_nvram_getenv("boardvendor", buf, sizeof(buf));
+	if (len > 0) {
+		err = kstrtou16(strim(buf), 0, &iv->boardinfo.vendor);
+		if (err)
+			pr_warn("Couldn't parse nvram board vendor entry with value \"%s\"\n",
+				buf);
+	}
+	if (!iv->boardinfo.vendor)
+		iv->boardinfo.vendor = SSB_BOARDVENDOR_BCM;
+
+	len = bcm47xx_nvram_getenv("boardtype", buf, sizeof(buf));
+	if (len > 0) {
+		err = kstrtou16(strim(buf), 0, &iv->boardinfo.type);
+		if (err)
+			pr_warn("Couldn't parse nvram board type entry with value \"%s\"\n",
+				buf);
+	}
 
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
