Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 19:29:52 +0100 (CET)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34358 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008511AbbCKS3utq-NE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 19:29:50 +0100
Received: by wiwl15 with SMTP id l15so39137351wiw.1;
        Wed, 11 Mar 2015 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Qjvonl4mOz9qCRxtSwtMjQcnBi+cnHr6lzhluyJJnQ0=;
        b=dLw3j4xNE8FpSDLq7xDkf6ejlodKDaDrKCJpcEzRthEYUcCxpEk7ZshsZioxOaPR78
         dmtTRoslz3BbBb2RrIdzx0Ei7YFGQYYCtR9PjjkPE/WEZsT1AjNGlZ1nPN0y9h9r41q3
         6dkHkPkhXOBoSAh7C0sB8ALf6T+qI8s2kOIuUTTgB4iyqv4Dpxot9js6Vrso1V9qgxE7
         eUWQHizrmDqaJ/0bP0DLQFWYGSWbVlmMPLl4POAyN0twaeKt1e2QzkUJ4GwYZamQDjDe
         DjSrDi/riW6QRN1fPYG/EhX+HyW3DOQv8knKt5b+UCRiy5NqxpAWENyOlz6hpQTj+eKF
         PlPA==
X-Received: by 10.194.62.52 with SMTP id v20mr80350017wjr.137.1426098585300;
        Wed, 11 Mar 2015 11:29:45 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id ei3sm12481905wib.4.2015.03.11.11.29.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2015 11:29:44 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Support for SPROM prefixes for PCI devices
Date:   Wed, 11 Mar 2015 19:29:30 +0100
Message-Id: <1426098570-4685-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46339
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

Support parsing SPROMs with prefixes defined like devpath1=pci/1/1

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 290309e..e5d254b 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -835,6 +835,36 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 #endif
 
 #if defined(CONFIG_BCM47XX_BCMA)
+/*
+ * Having many NVRAM entries for PCI devices led to repeating prefixes like
+ * pci/1/1/ all the time and wasting flash space. So at some point Broadcom
+ * decided to introduce prefixes like 0: 1: 2: etc.
+ * If we find e.g. devpath0=pci/2/1 we should use 0: instead of pci/2/1/.
+ */
+static void bcm47xx_sprom_apply_prefix_alias(char *prefix, size_t prefix_len)
+{
+	size_t needle_len = strlen(prefix) - 1;
+	char nvram_var[10];
+	char buf[20];
+	int i;
+
+	/* Standard prefix ends with / but devpath-s don't include it */
+	if (needle_len <= 0 || prefix[needle_len] != '/')
+		return;
+
+	for (i = 0; i < 3; i++) {
+		if (snprintf(nvram_var, sizeof(nvram_var), "devpath%d", i) <= 0)
+			continue;
+		if (bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf)) < 0)
+			continue;
+		if (strlen(buf) == needle_len &&
+		    !strncmp(buf, prefix, needle_len)) {
+			snprintf(prefix, prefix_len, "%d:", i);
+			return;
+		}
+	}
+}
+
 static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
@@ -846,6 +876,7 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
 			 bus->host_pci->bus->number + 1,
 			 PCI_SLOT(bus->host_pci->devfn));
+		bcm47xx_sprom_apply_prefix_alias(prefix, sizeof(prefix));
 		bcm47xx_fill_sprom(out, prefix, false);
 		return 0;
 	case BCMA_HOSTTYPE_SOC:
-- 
1.8.4.5
