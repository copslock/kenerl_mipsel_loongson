Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 14:57:11 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37443 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834799Ab3DDM5E5-aij (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Apr 2013 14:57:04 +0200
Received: by mail-pb0-f50.google.com with SMTP id jt11so1398090pbb.23
        for <linux-mips@linux-mips.org>; Thu, 04 Apr 2013 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=SStXx6KXJhqenewEaQX6j0wlWvwCBn+paeL7XKlhFcg=;
        b=QHAy+HS+lTJakG1CQyKiooq3IqipskXYOdGiRqwRkHZ7d07RxQwMMZj0oVcDvBANwk
         dlMKY4/BvgkZnuBxuan+nFiwYUCEVCKPrd0p+ghCJ8LDsOBY+doCQ1ENcyhTsm9x6NDE
         oe35p+jFUJQ6hLFbxd0BeRiwZ7MXDdcBmyXmSzIaovuw9TEpgroi5Pz6EPWl5dvwqf1C
         ud35wvLaWeECVSXQSG8+92yk6QJQYYO4xhSATdBmgq08tCenOMVxJAdEJaeP5o851U3+
         /iyR7fqbW0jId3l7caNiDDszdx5lct8f9FiqLLC1BWBXIlsSWkThI/bRUuL6kQ7qKQOQ
         cOSQ==
X-Received: by 10.68.241.132 with SMTP id wi4mr8541134pbc.8.1365080218360;
        Thu, 04 Apr 2013 05:56:58 -0700 (PDT)
Received: from localhost ([122.172.193.181])
        by mx.google.com with ESMTPS id wm3sm10174296pbc.4.2013.04.04.05.56.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 05:56:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rjw@sisk.pl
Cc:     robin.randhawa@arm.com, Steve.Bannister@arm.com,
        Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
        arvind.chauhan@arm.com, cpufreq@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-kernel@lists.linaro.org, patches@linaro.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 13/18] cpufreq: mips: move cpufreq driver to drivers/cpufreq
Date:   Thu,  4 Apr 2013 18:24:21 +0530
Message-Id: <a4974a6f4ec6c81250aecd58ddd38683b408f8af.1365079581.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <cover.1365079581.git.viresh.kumar@linaro.org>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1365079581.git.viresh.kumar@linaro.org>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
X-Gm-Message-State: ALoCoQmhFB502mzIlie5NpRiwNiiiu7AzHLu6CVvrSZfmEhRP+3aBYOXaAVlfpY3xkOjsh05ux1G
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

This patch moves cpufreq driver of MIPS architecture to drivers/cpufreq.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig                                  |  9 ++++-
 arch/mips/kernel/Makefile                          |  2 --
 arch/mips/kernel/cpufreq/Kconfig                   | 41 ----------------------
 arch/mips/kernel/cpufreq/Makefile                  |  5 ---
 drivers/cpufreq/Kconfig                            | 18 ++++++++++
 drivers/cpufreq/Makefile                           |  1 +
 .../kernel => drivers}/cpufreq/loongson2_cpufreq.c |  0
 7 files changed, 27 insertions(+), 49 deletions(-)
 delete mode 100644 arch/mips/kernel/cpufreq/Kconfig
 delete mode 100644 arch/mips/kernel/cpufreq/Makefile
 rename {arch/mips/kernel => drivers}/cpufreq/loongson2_cpufreq.c (100%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cd2e21f..22e8417 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2539,7 +2539,14 @@ source "kernel/power/Kconfig"
 
 endmenu
 
-source "arch/mips/kernel/cpufreq/Kconfig"
+config MIPS_EXTERNAL_TIMER
+	bool
+
+if CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
+menu "CPU Power Management"
+source "drivers/cpufreq/Kconfig"
+endmenu
+endif
 
 source "net/Kconfig"
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f81d98f..c69ca65 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -92,8 +92,6 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
-obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
-
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
 
diff --git a/arch/mips/kernel/cpufreq/Kconfig b/arch/mips/kernel/cpufreq/Kconfig
deleted file mode 100644
index 58c601e..0000000
--- a/arch/mips/kernel/cpufreq/Kconfig
+++ /dev/null
@@ -1,41 +0,0 @@
-#
-# CPU Frequency scaling
-#
-
-config MIPS_EXTERNAL_TIMER
-	bool
-
-config MIPS_CPUFREQ
-	bool
-	default y
-	depends on CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
-
-if MIPS_CPUFREQ
-
-menu "CPU Frequency scaling"
-
-source "drivers/cpufreq/Kconfig"
-
-if CPU_FREQ
-
-comment "CPUFreq processor drivers"
-
-config LOONGSON2_CPUFREQ
-	tristate "Loongson2 CPUFreq Driver"
-	select CPU_FREQ_TABLE
-	depends on MIPS_CPUFREQ
-	help
-	  This option adds a CPUFreq driver for loongson processors which
-	  support software configurable cpu frequency.
-
-	  Loongson2F and it's successors support this feature.
-
-	  For details, take a look at <file:Documentation/cpu-freq/>.
-
-	  If in doubt, say N.
-
-endif	# CPU_FREQ
-
-endmenu
-
-endif	# MIPS_CPUFREQ
diff --git a/arch/mips/kernel/cpufreq/Makefile b/arch/mips/kernel/cpufreq/Makefile
deleted file mode 100644
index 05a5715..0000000
--- a/arch/mips/kernel/cpufreq/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for the Linux/MIPS cpufreq.
-#
-
-obj-$(CONFIG_LOONGSON2_CPUFREQ) += loongson2_cpufreq.o
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a2f1600..5030df5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -235,6 +235,24 @@ config IA64_ACPI_CPUFREQ
 
 endmenu
 
+menu "MIPS CPUFreq processor drivers"
+depends on MIPS
+
+config LOONGSON2_CPUFREQ
+	tristate "Loongson2 CPUFreq Driver"
+	select CPU_FREQ_TABLE
+	help
+	  This option adds a CPUFreq driver for loongson processors which
+	  support software configurable cpu frequency.
+
+	  Loongson2F and it's successors support this feature.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  If in doubt, say N.
+
+endmenu
+
 menu "PowerPC CPU frequency scaling drivers"
 depends on PPC32 || PPC64
 source "drivers/cpufreq/Kconfig.powerpc"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index aaa018c..f6226d1 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_BLACKFIN)			+= blackfin-cpufreq.o
 obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
+obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
similarity index 100%
rename from arch/mips/kernel/cpufreq/loongson2_cpufreq.c
rename to drivers/cpufreq/loongson2_cpufreq.c
-- 
1.7.12.rc2.18.g61b472e
