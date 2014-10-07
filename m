Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:40:09 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51928 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010698AbaJGFbjjpFFr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=08yvG6RUxyn5keR1ylHDkoqXg0J27xNC2kdG+fz9fJk=;
        b=mvKogzSxyL8keg/lZ3dCT2R058KLzzoOVpIzOU94Cc6hoBQc8BVkt190bTfQFathTJLnF6vHvC2KdhyJFFMZ5+4Q4vMS/+kuZH2FJubY8oUX0qeM3GLogisdFKhaeGu9q/p1L8QjXjXJtW/4mdkdZ2XaoJSNaR2K9l0yiWGzGAc=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMz-002msb-B5
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:33 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32914 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLA-002bVt-Uq; Tue, 07 Oct 2014 05:29:41 +0000
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
        Corey Minyard <minyard@acm.org>
Subject: [PATCH 19/44] ipmi: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:21 -0700
Message-Id: <1412659726-29957-20-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Suspect
X-CTCH-VOD: Unknown
X-CTCH-Flags: 512
X-CTCH-RefID: str=0001.0A020207.54337AB5.00D2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=512,sb=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1241
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 141
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
X-archive-position: 43027
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
directly. Register with a high priority value of 192 to reflect that
the original code overwrites pm_power_off unconditionally.

Register poweroff handler after the ipmi system is ready, and unregister
it prior to cleanup. This avoids having to check for the ready variable
in the poweroff callback.

Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/char/ipmi/ipmi_poweroff.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 9f2e3be..a942a41 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -36,6 +36,7 @@
 #include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/completion.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/kdev_t.h>
 #include <linux/ipmi.h>
@@ -63,9 +64,6 @@ static ipmi_user_t ipmi_user;
 static int ipmi_ifnum;
 static void (*specific_poweroff_func)(ipmi_user_t user);
 
-/* Holds the old poweroff function so we can restore it on removal. */
-static void (*old_poweroff_func)(void);
-
 static int set_param_ifnum(const char *val, struct kernel_param *kp)
 {
 	int rv = param_set_int(val, kp);
@@ -544,15 +542,20 @@ static struct poweroff_function poweroff_functions[] = {
 
 
 /* Called on a powerdown request. */
-static void ipmi_poweroff_function(void)
+static int ipmi_poweroff_function(struct notifier_block *this,
+				  unsigned long unused1, void *unused2)
 {
-	if (!ready)
-		return;
-
 	/* Use run-to-completion mode, since interrupts may be off. */
 	specific_poweroff_func(ipmi_user);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block ipmi_poweroff_nb = {
+	.notifier_call = ipmi_poweroff_function,
+	.priority = 192,
+};
+
 /* Wait for an IPMI interface to be installed, the first one installed
    will be grabbed by this code and used to perform the powerdown. */
 static void ipmi_po_new_smi(int if_num, struct device *device)
@@ -631,9 +634,12 @@ static void ipmi_po_new_smi(int if_num, struct device *device)
 	printk(KERN_INFO PFX "Found a %s style poweroff function\n",
 	       poweroff_functions[i].platform_type);
 	specific_poweroff_func = poweroff_functions[i].poweroff_func;
-	old_poweroff_func = pm_power_off;
-	pm_power_off = ipmi_poweroff_function;
+
 	ready = 1;
+
+	rv = register_poweroff_handler(&ipmi_poweroff_nb);
+	if (rv)
+		pr_err(PFX "failed to register poweroff handler\n");
 }
 
 static void ipmi_po_smi_gone(int if_num)
@@ -644,9 +650,10 @@ static void ipmi_po_smi_gone(int if_num)
 	if (ipmi_ifnum != if_num)
 		return;
 
+	unregister_poweroff_handler(&ipmi_poweroff_nb);
+
 	ready = 0;
 	ipmi_destroy_user(ipmi_user);
-	pm_power_off = old_poweroff_func;
 }
 
 static struct ipmi_smi_watcher smi_watcher = {
@@ -732,12 +739,13 @@ static void __exit ipmi_poweroff_cleanup(void)
 
 	ipmi_smi_watcher_unregister(&smi_watcher);
 
+	unregister_poweroff_handler(&ipmi_poweroff_nb);
+
 	if (ready) {
 		rv = ipmi_destroy_user(ipmi_user);
 		if (rv)
 			printk(KERN_ERR PFX "could not cleanup the IPMI"
 			       " user: 0x%x\n", rv);
-		pm_power_off = old_poweroff_func;
 	}
 }
 module_exit(ipmi_poweroff_cleanup);
-- 
1.9.1
