Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jan 2016 15:30:21 +0100 (CET)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33365 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008924AbcAAOaTlGm9B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jan 2016 15:30:19 +0100
Received: by mail-lb0-f169.google.com with SMTP id sv6so128396147lbb.0;
        Fri, 01 Jan 2016 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=oWMQ7igmu570vuJq4+RIk2XegVxnqKpx1tE8lmQCx4c=;
        b=emykIyJz1ApaIhPBwHN1RvK9eDWunQihmBoRSvFhzqRnxlRssgUjtd9BHRFtMEPIkP
         HrETzOTfWS+MF76pM0E/c27uTcodq8muqbD/i8BWcd0RrgEW6K3/XqzM8cQVlzktFp5p
         QgPa/m8YwgOleHBA+nbNbXkF0r24LTuCvMAa9pEgqnJ9z0eBd89KuyJ8kr+IhhtNr6ia
         3Z/ad+UXyCMTchasJB0PnVS7WmV2lzTBiTAXhhckKzgkSC2BDiQzGrNUJKEuD4J/n8sn
         ldZwy7bSL3WFisRfWYaHkZhH9gMvmnCLkxUz1RLJFVymBmD7bJyn+2vXwlkddgnsIGI2
         qTOQ==
X-Received: by 10.112.198.72 with SMTP id ja8mr17110690lbc.142.1451658613235;
        Fri, 01 Jan 2016 06:30:13 -0800 (PST)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id zu7sm3249849lbb.36.2016.01.01.06.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jan 2016 06:30:12 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47xx: Support SPROM prefixes on other platforms
Date:   Fri,  1 Jan 2016 15:30:03 +0100
Message-Id: <1451658603-31298-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50813
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

BCM47XX platform has specific PCI setup because all buses share the same
domain. It's different e.g. on ARM ARCH_BCM_5301X where each PCI bus
gets its own domain (they are handled by iProc PCIe controller driver).

As we want to make SPROM driver more generic, let's add an exception for
BCM47xx. It was tested on BCM4706 (MIPS) and BCM4708A0 (ARM).

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index a7e569c..959c145 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -666,9 +666,15 @@ static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 	switch (bus->hosttype) {
 	case BCMA_HOSTTYPE_PCI:
 		memset(out, 0, sizeof(struct ssb_sprom));
-		snprintf(buf, sizeof(buf), "pci/%u/%u/",
-			 bus->host_pci->bus->number + 1,
-			 PCI_SLOT(bus->host_pci->devfn));
+		/* On BCM47XX all PCI buses share the same domain */
+		if (config_enabled(CONFIG_BCM47XX))
+			snprintf(buf, sizeof(buf), "pci/%u/%u/",
+				 bus->host_pci->bus->number + 1,
+				 PCI_SLOT(bus->host_pci->devfn));
+		else
+			snprintf(buf, sizeof(buf), "pci/%u/%u/",
+				 pci_domain_nr(bus->host_pci->bus) + 1,
+				 bus->host_pci->bus->number);
 		bcm47xx_sprom_apply_prefix_alias(buf, sizeof(buf));
 		prefix = buf;
 		break;
-- 
1.8.4.5
