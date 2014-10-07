Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:30:39 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:50941 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010661AbaJGFaXD6YJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:30:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=cIdAPz0kaAL1xF4qWYWwTieXLQYa14OC7yN1haJYCOg=;
        b=mEcYn3E6/MXETv4khprhc+TQg1Vz7li3ca6Mz3coc0YhEizEHwEvQQe0EAR9of9vB1XRMgfsaBfr2k1ykxp1wYN9rYgHFE5aM+Ux9wuUB69cpPTDyJN6KESaJNxzVssq6ndDn+YjP5kuOB3yKfShjbQO9ZtY0mcRy2VlsoCHpmk=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLi-002eGe-6x
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:30:14 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32897 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNKb-002Zwh-2p; Tue, 07 Oct 2014 05:29:05 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@uclinux.org>,
        Joshua Thompson <funaho@jurai.org>
Subject: [PATCH 04/44] m68k: Replace mach_power_off with pm_power_off
Date:   Mon,  6 Oct 2014 22:28:06 -0700
Message-Id: <1412659726-29957-5-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020204.54337A66.00C7,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 499
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Replace mach_power_off with pm_power_off to simplify the subsequent
move of pm_power_off to generic code.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/m68k/emu/natfeat.c         | 3 ++-
 arch/m68k/include/asm/machdep.h | 1 -
 arch/m68k/kernel/process.c      | 5 +++--
 arch/m68k/kernel/setup_mm.c     | 1 -
 arch/m68k/kernel/setup_no.c     | 1 -
 arch/m68k/mac/config.c          | 3 ++-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index 71b78ec..91e2ae7 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/io.h>
 #include <asm/machdep.h>
 #include <asm/natfeat.h>
@@ -90,5 +91,5 @@ void __init nf_init(void)
 	pr_info("NatFeats found (%s, %lu.%lu)\n", buf, version >> 16,
 		version & 0xffff);
 
-	mach_power_off = nf_poweroff;
+	pm_power_off = nf_poweroff;
 }
diff --git a/arch/m68k/include/asm/machdep.h b/arch/m68k/include/asm/machdep.h
index 953ca21..f9fac51 100644
--- a/arch/m68k/include/asm/machdep.h
+++ b/arch/m68k/include/asm/machdep.h
@@ -24,7 +24,6 @@ extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_clock_mmss)(unsigned long);
 extern void (*mach_reset)( void );
 extern void (*mach_halt)( void );
-extern void (*mach_power_off)( void );
 extern unsigned long (*mach_hd_init) (unsigned long, unsigned long);
 extern void (*mach_hd_setup)(char *, int *);
 extern long mach_max_dma_address;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index c55ff71..afe3d6e 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -22,6 +22,7 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
@@ -77,8 +78,8 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	if (mach_power_off)
-		mach_power_off();
+	if (pm_power_off)
+		pm_power_off();
 	for (;;);
 }
 
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 5b8ec4d..002fea6 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -96,7 +96,6 @@ EXPORT_SYMBOL(mach_get_rtc_pll);
 EXPORT_SYMBOL(mach_set_rtc_pll);
 void (*mach_reset)( void );
 void (*mach_halt)( void );
-void (*mach_power_off)( void );
 long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
 #ifdef CONFIG_HEARTBEAT
 void (*mach_heartbeat) (int);
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 88c27d9..1520156 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -55,7 +55,6 @@ int (*mach_hwclk) (int, struct rtc_time*);
 /* machine dependent reboot functions */
 void (*mach_reset)(void);
 void (*mach_halt)(void);
-void (*mach_power_off)(void);
 
 #ifdef CONFIG_M68000
 #if defined(CONFIG_M68328)
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index a471eab..677913ff 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 /* keyb */
 #include <linux/random.h>
 #include <linux/delay.h>
@@ -159,7 +160,7 @@ void __init config_mac(void)
 	mach_set_clock_mmss = mac_set_clock_mmss;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
-	mach_power_off = mac_poweroff;
+	pm_power_off = mac_poweroff;
 	mach_max_dma_address = 0xffffffff;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
 	mach_beep = mac_mksound;
-- 
1.9.1
