Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 09:14:13 +0200 (CEST)
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33678 "EHLO
        mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006953AbbDBHOLTVYpA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 09:14:11 +0200
Received: by wgoe14 with SMTP id e14so75718281wgo.0;
        Thu, 02 Apr 2015 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=0de47pcgA9xN5xXj6BLqAnnRPvBEQHU1lHtRT33s8is=;
        b=uX22+pIpGQxySyslmyPdqJQ0OCw6nEj8v0KlPFkxE0G9JxwxifdWGU/oltLMF9zTCX
         lypDLoBZK+dB2FNQGmDH8jlHG2F3PVh2Bk2SUx6oLrXrnslpuK2tkSe9DDSqK1mpw5Cu
         rEDyilROMe2izyKaxO8PGEOpEbFqfXneL4w1FKmlGS4EG2AJKTqFo+4mHSV8Fh76jh0G
         GT9VaCkRnaMp1qCQIn3mGAjD9QitMp+b2NlBS9WXnDtrZlBj0ZZnVLG3poAJkoyF70lD
         wczCWE05Fq21N01WRowOQxP/elhOaciRY0gvIgVaNVzvNfSCnGcxscCw55VPLyuVLvAp
         xWKg==
X-Received: by 10.194.222.234 with SMTP id qp10mr1725129wjc.39.1427958846493;
        Thu, 02 Apr 2015 00:14:06 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id w8sm5924533wja.4.2015.04.02.00.14.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 00:14:05 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Add generic function filling SPROM entries
Date:   Thu,  2 Apr 2015 09:13:49 +0200
Message-Id: <1427958829-7673-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46698
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

Handling many SPROM revisions became messy, we have tons of functions
specific to various revision groups which are quite hard to track.
For years there is yet another revision 11 asking for support, but
adding it in current the form would make things even worse.
To resolve this problem let's add new function with table-like entries
that will contain revision bitmask for every SPROM variable.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
I've tested this for regressions (filling SPROM with different values) on
BCM4704 (SPROM revision 2)
BCM5357B0 (SPROM revision 8)
BCM4706 (SPROM revision 8 plus 11 & 9 on extra WiFi cards)
---
 arch/mips/bcm47xx/sprom.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 5d32afc..77790c9 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -180,6 +180,33 @@ static void nvram_read_alpha2(const char *prefix, const char *name,
 	memcpy(val, buf, 2);
 }
 
+/* This is one-function-only macro, it uses local "sprom" variable! */
+#define ENTRY(_revmask, _type, _prefix, _name, _val, _allset, _fallback) \
+	if (_revmask & BIT(sprom->revision)) \
+		nvram_read_ ## _type(_prefix, NULL, _name, &sprom->_val, \
+				     _allset, _fallback)
+/*
+ * Special version of filling function that can be safely called for any SPROM
+ * revision. For every NVRAM to SPROM mapping it contains bitmask of revisions
+ * for which the mapping is valid.
+ * It obviously requires some hexadecimal/bitmasks knowledge, but allows
+ * writing cleaner code (easy revisions handling).
+ * Note that while SPROM revision 0 was never used, we still keep BIT(0)
+ * reserved for it, just to keep numbering sane.
+ */
+static void bcm47xx_sprom_fill_auto(struct ssb_sprom *sprom,
+				    const char *prefix, bool fallback)
+{
+	const char *pre = prefix;
+	bool fb = fallback;
+
+	ENTRY(0xfffffffe, u16, pre, "boardrev", board_rev, 0, true);
+	ENTRY(0xfffffffe, u16, pre, "boardnum", board_num, 0, fb);
+
+	/* TODO: Move more mappings here */
+}
+#undef ENTRY /* It's specififc, uses local variable, don't use it (again). */
+
 static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
 					const char *prefix, bool fallback)
 {
@@ -714,9 +741,6 @@ static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix,
 				    bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0, true);
-	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0,
-		       fallback);
 	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0, true);
 	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
 			 &sprom->boardflags_hi, fallback);
@@ -787,6 +811,8 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 		bcm47xx_fill_sprom_r12389(sprom, prefix, fallback);
 		bcm47xx_fill_sprom_r1(sprom, prefix, fallback);
 	}
+
+	bcm47xx_sprom_fill_auto(sprom, prefix, fallback);
 }
 
 #ifdef CONFIG_BCM47XX_SSB
-- 
1.8.4.5
