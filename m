Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 18:25:59 +0100 (CET)
Received: from mail-ig0-f201.google.com ([209.85.213.201]:33733 "EHLO
        mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009902AbbCYRZ5e0nL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 18:25:57 +0100
Received: by igjz20 with SMTP id z20so2231924igj.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2015 10:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbvykFyJ9Nt3K8NZDtCSSPF07DxNXA4j32c9TWm2+ek=;
        b=f3LsfxQQK6/pnBUW55vszg1injRRoZVoqWsv60jyMULvuXjvFTV4QvmjgNXvOQMN3q
         Tz3FjjYgdgQJAyT+pHHmpa2j9rV/0Cp3snbTnbhO0nhdQbFI7cIX3TJkbau5kUs3ix/z
         D4IsIk0FhDVh+oAdJDWTB8PJ7k/G4zGgx3ZLBXGxOnRzXDjqIAx8EVjBgZJeKKdJ6Jww
         Niv43PRqtf1Hni1o+/68ink78JHQuVl4JZRL0Uwgu80adN9Nr4anMs40+HojJoE45tjz
         gs5z/DNNVF6iAPlVDRdwfiViJMHjm/G7cWlXBCZrz8eQE1rm+QASXDZAIoyBuYrTGS+U
         ceWQ==
X-Gm-Message-State: ALoCoQnx9a37eb/l8mIOCzJcPo44gV010nM4cVSkWwVf4PyYvRSgTCO1qhGzwA3TWJwE9W3ooQh4
X-Received: by 10.182.112.167 with SMTP id ir7mr12080139obb.29.1427304352589;
        Wed, 25 Mar 2015 10:25:52 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id pc4si387951pac.0.2015.03.25.10.25.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 10:25:52 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id QPVi2zac.1; Wed, 25 Mar 2015 10:25:52 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B522E2208C0; Wed, 25 Mar 2015 10:25:46 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH V2 2/2] MIPS: Provide fallback reboot/poweroff/halt implementations
Date:   Wed, 25 Mar 2015 10:25:44 -0700
Message-Id: <1427304344-24739-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1427304344-24739-1-git-send-email-abrestic@chromium.org>
References: <1427304344-24739-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46525
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
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
---
Changes from v1:
 - disable preemption before calling smp_send_stop()
 - add a 1s delay after do_kernel_restart()
---
 arch/mips/kernel/reset.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..7c746d3 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 #include <linux/types.h>
 #include <linux/reboot.h>
+#include <linux/delay.h>
 
 #include <asm/reboot.h>
 
@@ -29,16 +30,40 @@ void machine_restart(char *command)
 {
 	if (_machine_restart)
 		_machine_restart(command);
+
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
+	do_kernel_restart(command);
+	mdelay(1000);
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
+	preempt_disable();
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
+	preempt_disable();
+	smp_send_stop();
+#endif
+	local_irq_disable();
+	while (1);
 }
-- 
2.2.0.rc0.207.ga3a616c
