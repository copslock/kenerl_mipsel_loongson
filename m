Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 22:17:37 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36259 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010260AbbJYVRU30ctN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2015 22:17:20 +0100
Received: by lffz202 with SMTP id z202so128814190lff.3;
        Sun, 25 Oct 2015 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wyj0rX3nJiR4Od87SAv85NnPpeyXma8DOKLHjYcQ92Y=;
        b=HB1RIVgCTp/1YyV+pqELTlulxP3S6GHl30DJ9Nu5iH07szbeLyR7dMpW4u4vQsuwnt
         zp0Uk/06zfNhNUDS6GHyc3OswCbY8l+v5FmsM/j1qSO2w+kNZY1vmvQ1NlMiArZ+wJXT
         0sR1mKX1/vANXF44Bag3qLB3cihNywZO7/R02iUwyPpZ9LQUODWxU/NLSMJyW9JBwTLj
         yss6n+bCgJQlzSW8nd9cxBvUQ9taT1zsSIQ2ir1x2cQRk/Cxro+qhbM5emr7wpfUyBHj
         U8jXi+D9JwLOyesZAcCi3W5FzzUL0lDUqN8nsSPvPrDAYmqsYcIjQ+NESFP9ApDsDxxL
         j+9w==
X-Received: by 10.112.137.169 with SMTP id qj9mr15564551lbb.34.1445807835067;
        Sun, 25 Oct 2015 14:17:15 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 78sm5440312lfs.35.2015.10.25.14.17.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2015 14:17:14 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM47xx: Fix some WARNINGs pointed in sprom.c by checkpatch.pl
Date:   Sun, 25 Oct 2015 22:16:48 +0100
Message-Id: <1445807808-23257-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1445807808-23257-1-git-send-email-zajec5@gmail.com>
References: <1445807808-23257-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49681
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

There are still few left:
1) Most of them about lines over 80 chars (increased readability exception)
2) Wrong parsing of preprocessor macros

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index e19c1b9..43353db 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -60,9 +60,9 @@ static int get_nvram_var(const char *prefix, const char *postfix,
 }
 
 #define NVRAM_READ_VAL(type)						\
-static void nvram_read_ ## type (const char *prefix,			\
-				 const char *postfix, const char *name, \
-				 type *val, type allset, bool fallback) \
+static void nvram_read_ ## type(const char *prefix,			\
+				const char *postfix, const char *name,	\
+				type *val, type allset, bool fallback)	\
 {									\
 	char buf[100];							\
 	int err;							\
@@ -422,7 +422,10 @@ static void bcm47xx_fill_sprom_path_r4589(struct ssb_sprom *sprom,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sprom->core_pwr_info); i++) {
-		struct ssb_sprom_core_pwr_info *pwr_info = &sprom->core_pwr_info[i];
+		struct ssb_sprom_core_pwr_info *pwr_info;
+
+		pwr_info = &sprom->core_pwr_info[i];
+
 		snprintf(postfix, sizeof(postfix), "%i", i);
 		nvram_read_u8(prefix, postfix, "maxp2ga",
 			      &pwr_info->maxpwr_2g, 0, fallback);
@@ -470,7 +473,10 @@ static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sprom->core_pwr_info); i++) {
-		struct ssb_sprom_core_pwr_info *pwr_info = &sprom->core_pwr_info[i];
+		struct ssb_sprom_core_pwr_info *pwr_info;
+
+		pwr_info = &sprom->core_pwr_info[i];
+
 		snprintf(postfix, sizeof(postfix), "%i", i);
 		nvram_read_u16(prefix, postfix, "pa2gw3a",
 			       &pwr_info->pa_2g[3], 0, fallback);
@@ -535,10 +541,11 @@ static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 	nvram_read_macaddr(prefix, "il0macaddr", sprom->il0mac, fallback);
 
 	/* The address prefix 00:90:4C is used by Broadcom in their initial
-	   configuration. When a mac address with the prefix 00:90:4C is used
-	   all devices from the same series are sharing the same mac address.
-	   To prevent mac address collisions we replace them with a mac address
-	   based on the base address. */
+	 * configuration. When a mac address with the prefix 00:90:4C is used
+	 * all devices from the same series are sharing the same mac address.
+	 * To prevent mac address collisions we replace them with a mac address
+	 * based on the base address.
+	 */
 	if (!bcm47xx_is_valid_mac(sprom->il0mac)) {
 		u8 mac[6];
 
-- 
1.8.4.5
