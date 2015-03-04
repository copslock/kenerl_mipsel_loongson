Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 00:59:32 +0100 (CET)
Received: from mail-yh0-f74.google.com ([209.85.213.74]:33848 "EHLO
        mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007079AbbCDX7bisnr3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 00:59:31 +0100
Received: by yhab6 with SMTP id b6so6949463yha.1
        for <linux-mips@linux-mips.org>; Wed, 04 Mar 2015 15:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I0lPuRNhF3+Glrj1Ad/Ic3T8XCL+ZCcioPx1OJKtO+I=;
        b=iUWIgvAY7Cs2BpdYkm2bryxgOLrRvybrRDX96Hr/mSfRlADX2OnjYqFlT8uJoAoFH+
         0qLggFZtmL15Um458GVFXh0/hkCtjiG/cca3r6qC2hW6CuTQDxz6TdiMaC1AtRv8Ro5X
         7NBdD8+70VWmF1tyYcjhP8/JR54DdhKYhr4bAOxDKz/fj+vIWpxkGkJ5p/pyqllPiN7n
         +OxbUtPlHx2S8yHcD49SVm9g7/3BKKqxxiyNclqJvT0/RWGfR25ogANZ+rv8/R3iemp1
         XqtGf8d0hHS5b2++3qhVQKjgQt4XygD8Twyt7aBS5PQ42egNrxD+Edty1r1O9yrzprkP
         HAKw==
X-Gm-Message-State: ALoCoQljpLywNnYpDfdCP6cG1//gDTrYA07+4ldfbMnKACFIpgBJqgZobpCYMjT2GGIJ7oYbfowE
X-Received: by 10.236.140.199 with SMTP id e47mr7238670yhj.50.1425513566319;
        Wed, 04 Mar 2015 15:59:26 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id z16si326913yhz.5.2015.03.04.15.59.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 15:59:26 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id bMOHL6lj.1; Wed, 04 Mar 2015 15:59:26 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 685CB220874; Wed,  4 Mar 2015 15:59:25 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] MIPS: Provide fallback reboot/poweroff/halt implementations
Date:   Wed,  4 Mar 2015 15:59:23 -0800
Message-Id: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

If a machine-specific hook is not implemented for restart, poweroff,
or halt, fall back to halting secondary CPUs, disabling interrupts,
and spinning.  In the case of restart, attempt to restart the system
via do_kernel_restart() (which will call any registered restart
handlers) before halting.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/reset.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..87b1f08 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -29,16 +29,36 @@ void machine_restart(char *command)
 {
 	if (_machine_restart)
 		_machine_restart(command);
+
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+	do_kernel_restart(command);
+	pr_emerg("Reboot failed -- System halted\n");
+	local_irq_disable();
+	while (1);
 }
 
 void machine_halt(void)
 {
 	if (_machine_halt)
 		_machine_halt();
+
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+	local_irq_disable();
+	while (1);
 }
 
 void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+	local_irq_disable();
+	while (1);
 }
-- 
2.2.0.rc0.207.ga3a616c
