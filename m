Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 12:40:46 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36312 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006743AbcDLKkn1-PyN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 12:40:43 +0200
Received: by mail-pa0-f66.google.com with SMTP id k3so1125740pav.3
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2016 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hRIORoAHQpbwrDcYxhOLWrFu9HXByYH0sU774XArSWs=;
        b=icVWXbNdVyHCmra3vGyuatLLmmKneDT4twDADp6Ql4oMa+JwXxVBg+dXR4RzuHTEFG
         DkMwCxClKPf8+HlmP/G/AaADaUCm5ToUzBxySglWyhwgbLAMt4dgR9mYhUvHW/5g9rOZ
         siPDSUCwRed6cTev1O9jwkO8UslZ44bOnIHSEd/l+nUr7v8ek19z8D+B7o+0+RWm3jlw
         ESx9dcTjNxGOFvoFU/OaRqSWKWABujeiInuQ5AzQrUm1D2SllbdffCCYju4qRadkk3Mk
         iO5v+vn+Vc5V9PC8X3Oyg2wmwxIZmM7NwiyT/VeSBbkoX34iUxxJcj3pVt82I0Bfl2WE
         dWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRIORoAHQpbwrDcYxhOLWrFu9HXByYH0sU774XArSWs=;
        b=IEwtPP1gudXVk5k3+7bKLxedLsCEQ30CdyhVq1JkvsAwhQqpmjTb6xiJV59PYC/wxA
         SW7neNrN3zNksch4Xlc2RE4R+kyILzRDduK0uWvFdtwpK1Z4iO0eV7pbi3f+CefQ/1w9
         NLTMJVyiJ1tzuoPWHVkyB+qCnS4Cku8iC/jgqrjRfwWPN0KN3Dc0DP/VboOQIDh22kEH
         lgSBB/CRFBTq0XMZu+eqyDN3u5mdts+kJvwmDQzFQfYrOCHwG1A+3gHNc8MnAgkyEcbF
         r8ojFGZkgTWWfHaSN9qLs2EjKObCxdN9DMhghuq1u2n9R+HDwONXp474L3S6h7VhOfQF
         d2AQ==
X-Gm-Message-State: AOPr4FWVcNoSCS9Lw3kg7cIrl8yO65nEmTH/usIvZ8NtFST7ukM9inHD7f7700+bVm7ybg==
X-Received: by 10.66.168.177 with SMTP id zx17mr3501397pab.3.1460457637302;
        Tue, 12 Apr 2016 03:40:37 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m87sm42588365pfj.38.2016.04.12.03.40.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 03:40:36 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 1/5] cpufreq: Loongson1: Rename the file to loongson1-cpufreq.c
Date:   Tue, 12 Apr 2016 18:40:15 +0800
Message-Id: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch renames the file to loongson1-cpufreq.c,
and also includes some minor updates.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V1:
   Merge the minor updates into this patch.
---
 drivers/cpufreq/Makefile                                |  2 +-
 drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (96%)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..bebe9c8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
-obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
+obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
similarity index 96%
rename from drivers/cpufreq/ls1x-cpufreq.c
rename to drivers/cpufreq/loongson1-cpufreq.c
index 262581b..57fae9b 100644
--- a/drivers/cpufreq/ls1x-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  * CPU Frequency Scaling for Loongson 1 SoC
  *
- * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -208,15 +208,15 @@ out:
 }
 
 static struct platform_driver ls1x_cpufreq_platdrv = {
-	.driver = {
+	.probe	= ls1x_cpufreq_probe,
+	.remove	= ls1x_cpufreq_remove,
+	.driver	= {
 		.name	= "ls1x-cpufreq",
 	},
-	.probe		= ls1x_cpufreq_probe,
-	.remove		= ls1x_cpufreq_remove,
 };
 
 module_platform_driver(ls1x_cpufreq_platdrv);
 
 MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
-MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
+MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1
