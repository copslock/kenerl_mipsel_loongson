Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 12:52:25 +0100 (CET)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34540 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011577AbaJ1LwYBltB2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 12:52:24 +0100
Received: by mail-wi0-f169.google.com with SMTP id q5so8514427wiv.2
        for <multiple recipients>; Tue, 28 Oct 2014 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RR8JVtR75GoAmTa4LYoR3M2Ps0kv0kgwaUybolXvibc=;
        b=EugS0xCwuK9KIDplWGz4gY8GIinWcoxUznkzJL7lkuOT+PlkCPkfBX7jeMunOjsI8c
         N8mfyOVo10IbSpHNaIijVtqKD9s8rg0x/uAgiZSHFP0XKSmB1fqOwHIOqEcBvRD1oP1E
         5NwcA5/DmjdAmQUNvVAgRKDBTaMUNJjlqYl8ePAbEfSYHuYaYIDFuP8Z9SqDmIQDMoYF
         Iw4U57aGfFxSGw7l6r8MzBss3rbqchbVkAPCbic18Jx5Kuo7QkX02ySJNwm9KLZyp+Cv
         S2iWIb+luHygJD6mOpIzDJnveKGiD6h9n3KmqwKSB/4SSs4V7INQWczZVQeBSVPN2WJj
         IsHw==
X-Received: by 10.180.81.134 with SMTP id a6mr3996025wiy.11.1414497138708;
        Tue, 28 Oct 2014 04:52:18 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id f9sm1281823wjw.31.2014.10.28.04.52.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 04:52:17 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47XX: Move SPROM fallback code into sprom.c
Date:   Tue, 28 Oct 2014 12:52:02 +0100
Message-Id: <1414497122-17999-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1409904503-31202-1-git-send-email-zajec5@gmail.com>
References: <1409904503-31202-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43623
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

This is some general cleanup as well as preparing sprom.c to become a
standalone driver. We will need this for bcm53xx ARM arch support.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
V2: Rebase to apply nicely on top for 3.18-rcX
---
 arch/mips/bcm47xx/bcm47xx_private.h |  3 ++
 arch/mips/bcm47xx/setup.c           | 58 ++-----------------------------
 arch/mips/bcm47xx/sprom.c           | 68 +++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
index f1cc9d0..12a112d 100644
--- a/arch/mips/bcm47xx/bcm47xx_private.h
+++ b/arch/mips/bcm47xx/bcm47xx_private.h
@@ -6,6 +6,9 @@
 /* prom.c */
 void __init bcm47xx_prom_highmem_init(void);
 
+/* sprom.c */
+void bcm47xx_sprom_register_fallbacks(void);
+
 /* buttons.c */
 int __init bcm47xx_buttons_register(void);
 
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index c00585d..444c65a 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -102,23 +102,6 @@ static void bcm47xx_machine_halt(void)
 }
 
 #ifdef CONFIG_BCM47XX_SSB
-static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
-{
-	char prefix[10];
-
-	if (bus->bustype == SSB_BUSTYPE_PCI) {
-		memset(out, 0, sizeof(struct ssb_sprom));
-		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
-			 bus->host_pci->bus->number + 1,
-			 PCI_SLOT(bus->host_pci->devfn));
-		bcm47xx_fill_sprom(out, prefix, false);
-		return 0;
-	} else {
-		printk(KERN_WARNING "bcm47xx: unable to fill SPROM for given bustype.\n");
-		return -EINVAL;
-	}
-}
-
 static int bcm47xx_get_invariants(struct ssb_bus *bus,
 				  struct ssb_init_invariants *iv)
 {
@@ -144,11 +127,6 @@ static void __init bcm47xx_register_ssb(void)
 	char buf[100];
 	struct ssb_mipscore *mcore;
 
-	err = ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom_ssb);
-	if (err)
-		printk(KERN_WARNING "bcm47xx: someone else already registered"
-			" a ssb SPROM callback handler (err %d)\n", err);
-
 	err = ssb_bus_ssbbus_register(&(bcm47xx_bus.ssb), SSB_ENUM_BASE,
 				      bcm47xx_get_invariants);
 	if (err)
@@ -171,44 +149,10 @@ static void __init bcm47xx_register_ssb(void)
 #endif
 
 #ifdef CONFIG_BCM47XX_BCMA
-static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
-{
-	char prefix[10];
-	struct bcma_device *core;
-
-	switch (bus->hosttype) {
-	case BCMA_HOSTTYPE_PCI:
-		memset(out, 0, sizeof(struct ssb_sprom));
-		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
-			 bus->host_pci->bus->number + 1,
-			 PCI_SLOT(bus->host_pci->devfn));
-		bcm47xx_fill_sprom(out, prefix, false);
-		return 0;
-	case BCMA_HOSTTYPE_SOC:
-		memset(out, 0, sizeof(struct ssb_sprom));
-		core = bcma_find_core(bus, BCMA_CORE_80211);
-		if (core) {
-			snprintf(prefix, sizeof(prefix), "sb/%u/",
-				 core->core_index);
-			bcm47xx_fill_sprom(out, prefix, true);
-		} else {
-			bcm47xx_fill_sprom(out, NULL, false);
-		}
-		return 0;
-	default:
-		pr_warn("bcm47xx: unable to fill SPROM for given bustype.\n");
-		return -EINVAL;
-	}
-}
-
 static void __init bcm47xx_register_bcma(void)
 {
 	int err;
 
-	err = bcma_arch_register_fallback_sprom(&bcm47xx_get_sprom_bcma);
-	if (err)
-		pr_warn("bcm47xx: someone else already registered a bcma SPROM callback handler (err %d)\n", err);
-
 	err = bcma_host_soc_register(&bcm47xx_bus.bcma);
 	if (err)
 		panic("Failed to register BCMA bus (err %d)", err);
@@ -229,6 +173,7 @@ void __init plat_mem_setup(void)
 		printk(KERN_INFO "bcm47xx: using bcma bus\n");
 #ifdef CONFIG_BCM47XX_BCMA
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
+		bcm47xx_sprom_register_fallbacks();
 		bcm47xx_register_bcma();
 		bcm47xx_set_system_type(bcm47xx_bus.bcma.bus.chipinfo.id);
 #ifdef CONFIG_HIGHMEM
@@ -239,6 +184,7 @@ void __init plat_mem_setup(void)
 		printk(KERN_INFO "bcm47xx: using ssb bus\n");
 #ifdef CONFIG_BCM47XX_SSB
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_SSB;
+		bcm47xx_sprom_register_fallbacks();
 		bcm47xx_register_ssb();
 		bcm47xx_set_system_type(bcm47xx_bus.ssb.chip_id);
 #endif
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 41226b6..e772e77 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -801,3 +801,71 @@ void bcm47xx_fill_bcma_boardinfo(struct bcma_boardinfo *boardinfo,
 	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0, true);
 }
 #endif
+
+#if defined(CONFIG_BCM47XX_SSB)
+static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
+{
+	char prefix[10];
+
+	if (bus->bustype == SSB_BUSTYPE_PCI) {
+		memset(out, 0, sizeof(struct ssb_sprom));
+		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
+			 bus->host_pci->bus->number + 1,
+			 PCI_SLOT(bus->host_pci->devfn));
+		bcm47xx_fill_sprom(out, prefix, false);
+		return 0;
+	} else {
+		pr_warn("bcm47xx: unable to fill SPROM for given bustype.\n");
+		return -EINVAL;
+	}
+}
+#endif
+
+#if defined(CONFIG_BCM47XX_BCMA)
+static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
+{
+	char prefix[10];
+	struct bcma_device *core;
+
+	switch (bus->hosttype) {
+	case BCMA_HOSTTYPE_PCI:
+		memset(out, 0, sizeof(struct ssb_sprom));
+		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
+			 bus->host_pci->bus->number + 1,
+			 PCI_SLOT(bus->host_pci->devfn));
+		bcm47xx_fill_sprom(out, prefix, false);
+		return 0;
+	case BCMA_HOSTTYPE_SOC:
+		memset(out, 0, sizeof(struct ssb_sprom));
+		core = bcma_find_core(bus, BCMA_CORE_80211);
+		if (core) {
+			snprintf(prefix, sizeof(prefix), "sb/%u/",
+				 core->core_index);
+			bcm47xx_fill_sprom(out, prefix, true);
+		} else {
+			bcm47xx_fill_sprom(out, NULL, false);
+		}
+		return 0;
+	default:
+		pr_warn("bcm47xx: unable to fill SPROM for given bustype.\n");
+		return -EINVAL;
+	}
+}
+#endif
+
+/*
+ * On bcm47xx we need to register SPROM fallback handler very early, so we can't
+ * use anything like platform device / driver for this.
+ */
+void bcm47xx_sprom_register_fallbacks(void)
+{
+#if defined(CONFIG_BCM47XX_SSB)
+	if (ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom_ssb))
+		pr_warn("Failed to registered ssb SPROM handler\n");
+#endif
+
+#if defined(CONFIG_BCM47XX_BCMA)
+	if (bcma_arch_register_fallback_sprom(&bcm47xx_get_sprom_bcma))
+		pr_warn("Failed to registered bcma SPROM handler\n");
+#endif
+}
-- 
1.8.4.5
