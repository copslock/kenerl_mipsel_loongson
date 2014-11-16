Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:24:33 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43994 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013776AbaKPATxaLL5o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:53 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so19683045pab.5
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6STHg2cTwYVEoYlP0k+HpgvVNnwo0H4Vqd1brogRJd0=;
        b=aXXXa6Pnut6CjP4WQzmAHfUnjVAshDprFJ5yiVci47YG8AqqwezO1vXOGdBChwf21D
         /qkYXSbe40/C51KZWZaTq1U1nMGcncxtZ2jr7FhmmZaN6sERRXxA4ZIeHx18eJbcPU9n
         g22Bii0vOzQTJ5AI4Q5Pldj0ruvY7FAxdHctx25oN7ZJINN8oTfG+FYJcWtgf9Z8fGz7
         NZx0ewq5lIMrC2w5q8RQWMia+j2GZPGRZI1JAob96JF3yitrs928RkYvLA5G3oT60dIi
         fdLf+rLpehsad/3LiToXe7rdGPeotJaSGlYDeWWaY/rQG+cEl9eaot7+8nPMY6OgQE0b
         divQ==
X-Received: by 10.70.21.168 with SMTP id w8mr19713420pde.95.1416097187882;
        Sat, 15 Nov 2014 16:19:47 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:47 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 18/22] MIPS: Create a helper function for DT setup
Date:   Sat, 15 Nov 2014 16:17:42 -0800
Message-Id: <1416097066-20452-19-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

A couple of platforms register two buses and call of_platform_populate().
Move this into a common function to reduce duplication.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/prom.h |  1 +
 arch/mips/kernel/prom.c      | 18 ++++++++++++++++++
 arch/mips/lantiq/prom.c      | 11 +----------
 arch/mips/ralink/of.c        | 14 ++------------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index a9494c0..eaa2627 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -22,6 +22,7 @@ extern void device_tree_init(void);
 struct boot_param_header;
 
 extern void __dt_setup_arch(void *bph);
+extern int __dt_register_buses(const char *bus0, const char *bus1);
 
 #define dt_setup_arch(sym)						\
 ({									\
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 5d39bb8..452d435 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 
 #include <asm/page.h>
 #include <asm/prom.h>
@@ -54,4 +55,21 @@ void __init __dt_setup_arch(void *bph)
 
 	mips_set_machine_name(of_flat_dt_get_machine_name());
 }
+
+int __init __dt_register_buses(const char *bus0, const char *bus1)
+{
+	static struct of_device_id of_ids[3];
+
+	if (!of_have_populated_dt())
+		panic("device tree not present");
+
+	strlcpy(of_ids[0].compatible, bus0, sizeof(of_ids[0].compatible));
+	strlcpy(of_ids[1].compatible, bus1, sizeof(of_ids[1].compatible));
+
+	if (of_platform_populate(NULL, of_ids, NULL, NULL))
+		panic("failed to populate DT");
+
+	return 0;
+}
+
 #endif
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 7447d32..758970e 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -97,16 +97,7 @@ void __init prom_init(void)
 
 int __init plat_of_setup(void)
 {
-	static struct of_device_id of_ids[3];
-
-	if (!of_have_populated_dt())
-		panic("device tree not present");
-
-	strlcpy(of_ids[0].compatible, soc_info.compatible,
-		sizeof(of_ids[0].compatible));
-	strncpy(of_ids[1].compatible, "simple-bus",
-		sizeof(of_ids[1].compatible));
-	return of_platform_populate(NULL, of_ids, NULL, NULL);
+	return __dt_register_buses(soc_info.compatible, "simple-bus");
 }
 
 arch_initcall(plat_of_setup);
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 7c4598c..f68115f 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -74,19 +74,9 @@ void __init plat_mem_setup(void)
 
 static int __init plat_of_setup(void)
 {
-	static struct of_device_id of_ids[3];
-	int len = sizeof(of_ids[0].compatible);
+	__dt_register_buses(soc_info.compatible, "palmbus");
 
-	if (!of_have_populated_dt())
-		panic("device tree not present");
-
-	strlcpy(of_ids[0].compatible, soc_info.compatible, len);
-	strlcpy(of_ids[1].compatible, "palmbus", len);
-
-	if (of_platform_populate(NULL, of_ids, NULL, NULL))
-		panic("failed to populate DT");
-
-	/* make sure ithat the reset controller is setup early */
+	/* make sure that the reset controller is setup early */
 	ralink_rst_init();
 
 	return 0;
-- 
2.1.1
