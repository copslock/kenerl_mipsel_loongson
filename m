Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:40:58 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51985 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010701AbaJGFbsktEVY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=nzfgGbpF9AJ52/AKTblagoIgMTkJbORI3DpsN3yY8Yk=;
        b=jTpe7zFk/tHgPjDMYKknpiNAoOdOmOyUZJUQKkCS7tywdyFs1+6SllVFbk/AY47/6bIFwLn0mfox/9RwHEqo2q38LD+0bNpWOaIDmVUtB37UKuyzO0jasXgteEmgdiFxdM9LKgQcXoyw/krwNpM88KJer1xYlV3qF3OaIDADXwk=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNN8-002njQ-Cj
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:42 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32927 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLN-002cBN-55; Tue, 07 Oct 2014 05:29:53 +0000
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 24/44] power/reset: msm-powroff: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:26 -0700
Message-Id: <1412659726-29957-25-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020207.54337ABE.00CA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1289
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 163
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
X-archive-position: 43030
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
directly. Select proprity 0 since the code does not really poweroff
the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/msm-poweroff.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 774f9a3..189bcd3 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/reboot.h>
 
 #include <asm/system_misc.h>
@@ -31,12 +32,19 @@ static void do_msm_restart(enum reboot_mode reboot_mode, const char *cmd)
 	mdelay(10000);
 }
 
-static void do_msm_poweroff(void)
+static int do_msm_poweroff(struct notifier_block *this,
+			   unsigned long unused1, void *unused2)
 {
 	/* TODO: Add poweroff capability */
 	do_msm_restart(REBOOT_HARD, NULL);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block msm_powroff_nb = {
+	.notifier_call = do_msm_poweroff,
+};
+
 static int msm_restart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -47,7 +55,8 @@ static int msm_restart_probe(struct platform_device *pdev)
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-	pm_power_off = do_msm_poweroff;
+	if (register_poweroff_handler(&msm_powroff_nb))
+		dev_err(&pdev->dev, "Failed to register poweroff handler\n");
 	arm_pm_restart = do_msm_restart;
 	return 0;
 }
-- 
1.9.1
