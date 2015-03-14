Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Mar 2015 17:56:17 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34343 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008200AbbCNQ4QW7yzN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Mar 2015 17:56:16 +0100
Received: by wibg7 with SMTP id g7so7445121wib.1;
        Sat, 14 Mar 2015 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8N2tDGZpDEdryVf8zfy1cXqti2B7Th8+H5JRdny+l58=;
        b=pFw5OEcThFl6zk4jhai4z/5OcweXp1yYI+orVYNq+NSe4rWfDVMqYg+gkTZn0MKN31
         O+KNIkUAKaJ+TlxAFAbxebX1sYcIoGt7KruZP8TSAasGWvkuBSsBCUIBGgeDusstgQ/Z
         Q3ht0q4wKPlkRGVL7PwfulDLWfKsFG0IWxBbsdvcyw9lxLg8oWID7yuDhQneFXHwZ5TW
         ZVzk70PbYiRZjyuTctMOvfmJse1Dhy68inHzV6Sk8swz1+0/NJUZIinDxfGVbyVRv3mh
         BY2Gg4DscosQ90goDKlnQg018tbSpeCfdES4xezzrAd8h9wbkEK0ByKBL90CCsCG5S6H
         vTXQ==
X-Received: by 10.180.75.140 with SMTP id c12mr77777823wiw.14.1426352171695;
        Sat, 14 Mar 2015 09:56:11 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id bd1sm7670404wib.13.2015.03.14.09.56.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Mar 2015 09:56:10 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47XX: Support SPROM prefixes for PCI devices
Date:   Sat, 14 Mar 2015 17:55:54 +0100
Message-Id: <1426352154-10253-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1426098570-4685-1-git-send-email-zajec5@gmail.com>
References: <1426098570-4685-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46386
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
V2: I've noticed that Buffalo WZR-1750 uses an extra slash in NVRAM
    devpaths entries. I added support for them and updated comment.
    This adds one line over 80 chars, but it improved condition
    readability so I think it's alright there. 
---
 arch/mips/bcm47xx/sprom.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 290309e..5d32afc 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -835,6 +835,38 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 #endif
 
 #if defined(CONFIG_BCM47XX_BCMA)
+/*
+ * Having many NVRAM entries for PCI devices led to repeating prefixes like
+ * pci/1/1/ all the time and wasting flash space. So at some point Broadcom
+ * decided to introduce prefixes like 0: 1: 2: etc.
+ * If we find e.g. devpath0=pci/2/1 or devpath0=pci/2/1/ we should use 0:
+ * instead of pci/2/1/.
+ */
+static void bcm47xx_sprom_apply_prefix_alias(char *prefix, size_t prefix_size)
+{
+	size_t prefix_len = strlen(prefix);
+	size_t short_len = prefix_len - 1;
+	char nvram_var[10];
+	char buf[20];
+	int i;
+
+	/* Passed prefix has to end with a slash */
+	if (prefix_len <= 0 || prefix[prefix_len - 1] != '/')
+		return;
+
+	for (i = 0; i < 3; i++) {
+		if (snprintf(nvram_var, sizeof(nvram_var), "devpath%d", i) <= 0)
+			continue;
+		if (bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf)) < 0)
+			continue;
+		if (!strcmp(buf, prefix) ||
+		    (short_len && strlen(buf) == short_len && !strncmp(buf, prefix, short_len))) {
+			snprintf(prefix, prefix_size, "%d:", i);
+			return;
+		}
+	}
+}
+
 static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
@@ -846,6 +878,7 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
 			 bus->host_pci->bus->number + 1,
 			 PCI_SLOT(bus->host_pci->devfn));
+		bcm47xx_sprom_apply_prefix_alias(prefix, sizeof(prefix));
 		bcm47xx_fill_sprom(out, prefix, false);
 		return 0;
 	case BCMA_HOSTTYPE_SOC:
-- 
1.8.4.5
