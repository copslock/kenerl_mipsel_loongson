Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 14:48:48 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2742 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903699Ab2EHMnI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 14:43:08 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 08 May 2012 05:43:12 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 May 2012 05:42:48 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 133099F9F6; Tue, 8
 May 2012 05:42:48 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 8 May 2012 05:42:47 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 14/14] MIPS: Netlogic: Add XLP SoC devices in FDT
Date:   Tue, 8 May 2012 18:12:08 +0530
Message-ID: <1336480928-18887-15-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 63B7CB6A44G1245370-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Probe and add devices on SoC "simple-bus" on startup. This will
in turn add devices like I2C controller that are specified in the
device tree under 'soc'.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/xlp/setup.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index b3df7c2..3dec9f2 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -41,6 +41,8 @@
 #include <asm/bootinfo.h>
 
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/common.h>
@@ -109,3 +111,17 @@ void __init prom_init(void)
 	register_smp_ops(&nlm_smp_ops);
 #endif
 }
+
+static struct of_device_id __initdata xlp_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+int __init xlp8xx_ds_publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		return 0;
+	return of_platform_bus_probe(NULL, xlp_ids, NULL);
+}
+
+device_initcall(xlp8xx_ds_publish_devices);
-- 
1.7.9.5
