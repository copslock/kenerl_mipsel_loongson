Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:34:45 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51622 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010007AbaJGFbLDMwO9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=7885dG5LLp99My+6lCAdke30YwGg7jrufORxgutM6Gc=;
        b=bgQehv+10JRtLStIUbTZp3Q6zjjQG/3WjU8RjzDyQPiio0MEJouXTk8kjTYX8M2tAzs5hx6GBmvHnF3sJUOQG5k3IFuYtxWpeCdfr2CRLTswYMRTKCs6NjjU+jj3/cIoo5iXU+IoUTR41JLFDyiadgEp7H4cpTkQ47V/PEHr/NY=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMW-002k54-Q7
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:04 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32930 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLT-002cdx-7L; Tue, 07 Oct 2014 05:29:59 +0000
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 27/44] x86: apm: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:29 -0700
Message-Id: <1412659726-29957-28-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020204.54337A99.0022,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1007
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 30
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
X-archive-position: 43008
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

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with high priority value of 192 to reflect that
the original code overwrites existing poweroff handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/kernel/apm_32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 5848744..84566a6 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -219,6 +219,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/capability.h>
 #include <linux/device.h>
@@ -981,7 +982,8 @@ recalc:
  *	on their first cpu.
  */
 
-static void apm_power_off(void)
+static int apm_power_off(struct notifier_block *this, unsigned long unused1,
+			 void *unused2)
 {
 	/* Some bioses don't like being called from CPU != 0 */
 	if (apm_info.realmode_power_off) {
@@ -990,8 +992,14 @@ static void apm_power_off(void)
 	} else {
 		(void)set_system_power_state(APM_STATE_OFF);
 	}
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block apm_poweroff_nb = {
+	.notifier_call = apm_power_off,
+	.priority = 192,
+};
+
 #ifdef CONFIG_APM_DO_ENABLE
 
 /**
@@ -1847,8 +1855,11 @@ static int apm(void *unused)
 	}
 
 	/* Install our power off handler.. */
-	if (power_off)
-		pm_power_off = apm_power_off;
+	if (power_off) {
+		error = register_poweroff_handler(&apm_poweroff_nb);
+		if (error)
+			pr_err("apm: Failed to register poweroff handler\n");
+	}
 
 	if (num_online_cpus() == 1 || smp) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -2408,9 +2419,8 @@ static void __exit apm_exit(void)
 			apm_error("disengage power management", error);
 	}
 	misc_deregister(&apm_device);
+	unregister_poweroff_handler(&apm_poweroff_nb);
 	remove_proc_entry("apm", NULL);
-	if (power_off)
-		pm_power_off = NULL;
 	if (kapmd_task) {
 		kthread_stop(kapmd_task);
 		kapmd_task = NULL;
-- 
1.9.1
