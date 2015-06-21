Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Jun 2015 15:26:26 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35376 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007168AbbFUN0ZJEj1K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Jun 2015 15:26:25 +0200
Received: by wiga1 with SMTP id a1so54829951wig.0;
        Sun, 21 Jun 2015 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Z1TimR/3+B+ddbV6Ye2Uz/Wb5GQrBCLDzn3EjfyQrQY=;
        b=o0MUmjfbmsVOm76bgcMqlBjmm5vruB5ALod0jQhUbFTR0TeQuTOs/sjJtFC5ixDhWn
         t8FR6LRsXdJE14J+TngTZcLEoflHEa40VQiK/nwI5lCODttmkctAb8GGilFA5aVeodBh
         Yj2XAWeWayVrH4yZNbKZLoPCtHqRbtYmx7601SP3S4dvz+Btm7ENDVDYeq9cDvWTz4im
         O9UWZdOLVF8anoC6pprbJcbHM6B8DQwEsMVE03fJCbP2lACfcXDKhsxeFnlLNBkyvzoP
         q4aVgVZhwhPTeWDgh3CZcAbQJMJysNL+b7z1sos6P3g2uBkl6mh/06s0TcEWGGZ8wir5
         K9zA==
X-Received: by 10.180.84.202 with SMTP id b10mr23504493wiz.23.1434893179988;
        Sun, 21 Jun 2015 06:26:19 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id i6sm25759518wjf.29.2015.06.21.06.26.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2015 06:26:19 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47xx: Simplify handling SPROM revisions
Date:   Sun, 21 Jun 2015 15:25:49 +0200
Message-Id: <1434893149-16134-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47995
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

After the big SPROM cleanup moving code to the bcm47xx_sprom_fill_auto
we ended up with few tiny functions, two of them being identical. Let's
get rid of these [12]-liners.
This also stops extracting higher SPROM revisions as revision 1. Now we
have that function nicely handling revisions we don't need it.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 53 ++++++++---------------------------------------
 1 file changed, 9 insertions(+), 44 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index b0d62e7..2d5c7a7 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -200,6 +200,9 @@ static void bcm47xx_sprom_fill_auto(struct ssb_sprom *sprom,
 	const char *pre = prefix;
 	bool fb = fallback;
 
+	/* Broadcom extracts it for rev 8+ but it was found on 2 and 4 too */
+	ENTRY(0xfffffffe, u16, pre, "devid", dev_id, 0, fallback);
+
 	ENTRY(0xfffffffe, u16, pre, "boardrev", board_rev, 0, true);
 	ENTRY(0xfffffffe, u32, pre, "boardflags", boardflags, 0, fb);
 	ENTRY(0xfffffff0, u32, pre, "boardflags2", boardflags2, 0, fb);
@@ -412,27 +415,6 @@ static void bcm47xx_sprom_fill_auto(struct ssb_sprom *sprom,
 }
 #undef ENTRY /* It's specififc, uses local variable, don't use it (again). */
 
-static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
-					const char *prefix, bool fallback)
-{
-	nvram_read_u16(prefix, NULL, "devid", &sprom->dev_id, 0, fallback);
-	nvram_read_alpha2(prefix, "ccode", sprom->alpha2, fallback);
-}
-
-static void bcm47xx_fill_sprom_r3(struct ssb_sprom *sprom, const char *prefix,
-				  bool fallback)
-{
-	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
-			 &sprom->leddc_off_time, fallback);
-}
-
-static void bcm47xx_fill_sprom_r4589(struct ssb_sprom *sprom,
-				     const char *prefix, bool fallback)
-{
-	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
-			 &sprom->leddc_off_time, fallback);
-}
-
 static void bcm47xx_fill_sprom_path_r4589(struct ssb_sprom *sprom,
 					  const char *prefix, bool fallback)
 {
@@ -589,39 +571,22 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 
 	nvram_read_u8(prefix, NULL, "sromrev", &sprom->revision, 0, fallback);
 
+	/* Entries requiring custom functions */
+	nvram_read_alpha2(prefix, "ccode", sprom->alpha2, fallback);
+	if (sprom->revision >= 3)
+		nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
+				 &sprom->leddc_off_time, fallback);
+
 	switch (sprom->revision) {
-	case 1:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
-		break;
-	case 2:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
-		break;
-	case 3:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
-		bcm47xx_fill_sprom_r3(sprom, prefix, fallback);
-		break;
 	case 4:
 	case 5:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
-		bcm47xx_fill_sprom_r4589(sprom, prefix, fallback);
 		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
 		bcm47xx_fill_sprom_path_r45(sprom, prefix, fallback);
 		break;
 	case 8:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
-		bcm47xx_fill_sprom_r4589(sprom, prefix, fallback);
-		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
-		break;
 	case 9:
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
-		bcm47xx_fill_sprom_r4589(sprom, prefix, fallback);
 		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
 		break;
-	default:
-		pr_warn("Unsupported SPROM revision %d detected. Will extract v1\n",
-			sprom->revision);
-		sprom->revision = 1;
-		bcm47xx_fill_sprom_r1234589(sprom, prefix, fallback);
 	}
 
 	bcm47xx_sprom_fill_auto(sprom, prefix, fallback);
-- 
1.8.4.5
