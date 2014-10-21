Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:32:12 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46207 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011995AbaJUE25JowpR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:57 +0200
Received: by mail-pd0-f177.google.com with SMTP id v10so492292pde.22
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6STHg2cTwYVEoYlP0k+HpgvVNnwo0H4Vqd1brogRJd0=;
        b=kLpQCc0S/X8sZ7Dd8+m0MmoBL94nDqz3unLYZIM4Ms0FZA/8Y+oYormvZdYvk68Kb/
         HcuL1YbW9IHpptLCcT0BYm+jTUMBYQHn96sx2D1PcwoxNkwnDGWsRtoJdr2RNJ0Yy2nS
         ccEW3PxWzG4ViYLyCTVPh3ARaoWyWlZOnEq1GqKn9/KVpxr7r8XYZyXQSv29vPXWDwmy
         F07WQXGdCcMg329TCOdnyg0qnWPzcp8QFH8Gm6mHt2bBUCnXbT/Qc47aM/nRZ+YPqmxL
         nburr4xnoUjL1eKjR1eyXsywC7NHBwkNurXqL6niCz3qbLMU384XaAxMrPz8p1gyEoZs
         z/QA==
X-Received: by 10.66.138.47 with SMTP id qn15mr32272836pab.82.1413865731064;
        Mon, 20 Oct 2014 21:28:51 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:50 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 12/17] MIPS: Create a helper function for DT setup
Date:   Mon, 20 Oct 2014 21:28:02 -0700
Message-Id: <1413865687-15255-13-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43410
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
