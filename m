Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 09:43:52 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37135 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011042AbbENHnuLhIFe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 09:43:50 +0200
Received: by wibt6 with SMTP id t6so4912804wib.0;
        Thu, 14 May 2015 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=OUOi0LpkMbA0l+m9AJFz7Cg9QhV83VP9hIOtJzySd8I=;
        b=VcoSkeiIVZeo7PDH3SLxl5icjlQNDCM2o7pge89IJs3DUDU8AoVXKKR80YQtMIRLVZ
         LDlxzDNhcbg6Dh8Y5kkRJFOCmwy+NVXnTVeURYQxin0f9SElqqnpdMSRsq5zdiD/wbor
         ck7kL4XDPLjKjWKkMb5X3aZfbLNaDH3f5Oqs3Eh/nT9VKqZrw+BbTh0WePkDdigGSOfy
         ICQhytZX5rz/Gvbps38EOL/m+2m/rS818Ag0mkbH5gRmsxJE8MArXZPRsmCt4/CboExU
         lkRX9Yd+ChOrzGi9oPZ0QFORcr3seHM+oGi3ICYFZpCS///p8GNKAM5NaPgYv4JymruH
         eCVg==
X-Received: by 10.194.172.72 with SMTP id ba8mr5386429wjc.136.1431589427247;
        Thu, 14 May 2015 00:43:47 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id l6sm36753450wjz.4.2015.05.14.00.43.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 00:43:46 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Fix regression in reading WiFi SoC SPROM
Date:   Thu, 14 May 2015 09:42:50 +0200
Message-Id: <1431589370-30147-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47391
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

In the recent SPROM commit:
MIPS: BCM47xx: Read board info for all bcma buses
a proper handling of "fallback" argument has been dropped. Restore it.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 8485143..b0d62e7 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -698,6 +698,7 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 	struct bcma_device *core;
 	char buf[10];
 	char *prefix;
+	bool fallback = false;
 
 	switch (bus->hosttype) {
 	case BCMA_HOSTTYPE_PCI:
@@ -715,6 +716,7 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 			snprintf(buf, sizeof(buf), "sb/%u/",
 				 core->core_index);
 			prefix = buf;
+			fallback = true;
 		} else {
 			prefix = NULL;
 		}
@@ -729,7 +731,7 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 		binfo->vendor = SSB_BOARDVENDOR_BCM;
 	nvram_read_u16(prefix, NULL, "boardtype", &binfo->type, 0, true);
 
-	bcm47xx_fill_sprom(out, prefix, false);
+	bcm47xx_fill_sprom(out, prefix, fallback);
 
 	return 0;
 }
-- 
1.8.4.5
