Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2016 16:10:47 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33143 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026377AbcDKOKozeGnx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2016 16:10:44 +0200
Received: by mail-pa0-f65.google.com with SMTP id vv3so1802977pab.0
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eOLQ56KJzYTgDGymguu4xPVdLvncUQafQy4Sukg3GPw=;
        b=AxyjpmFcEE2Evb6CYd0rd8WkvBZUvwa6rDn/5EeqWEhCuFI2sDkHtvvcBgf7Cgp8u4
         a9h45C1CTPm39jsM6ZkWNffVAuWhVGqlzagkF5kBmXXJgCEIXCF1cqFHY1fZmnTzkLKO
         dcri6AjvUySpFQwPbInAocRF+R9lQc51ew7dH+6vALMKwiUACY8kgnVSKGOYO5a2hyvB
         VDRzUDf9FJpRidmL3iDB9fkZiaJHQInDBl7++P3U4u45kXqduST2d5twgqsJI+bAFGsw
         bLLzkhbuT/bn0HK/ZYgWKNA2oWTcCPVagb216VU+3P9sPEzqDo/+bRad8mRLp9Kuz78m
         /9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=eOLQ56KJzYTgDGymguu4xPVdLvncUQafQy4Sukg3GPw=;
        b=EH+y4an2qejJ5NtI8rMxfaYj9wyJwsK0Yel3rUVu8uqtH4F9acESezxidBDgs9AAOG
         nT5HP+YoN7BM6QNtazzedF9v5PTera8SfH0z7k7yuzq+5vKrMIUyM1N7lCpNPStjegnQ
         bsTyw0qKZpjQ7XQAO3idX+AcPujEZEN4B4IPIXHAz3cKRS3QhmLqWb3D0hunvIm3bPYQ
         69KO40St3Vo/TdOAHyJLv86rdiOCjhL+JV4T6tVbk5ztad3Fkge/HBWqYLbzYe0+Tdqa
         ex/2zxB7ilmISrYDmzfqqWk84he/s5SnzScqONX6I0jkRY1SNW26/XKgM+yQ/RkeVHvq
         W2Aw==
X-Gm-Message-State: AD7BkJK2u6g2TgmaeiFaNTLwXRJW31aIT4kB4HnaJNVN6crtFzDYicW3euF5+XSitCfHPA==
X-Received: by 10.66.79.162 with SMTP id k2mr31809505pax.121.1460383838574;
        Mon, 11 Apr 2016 07:10:38 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 9sm36664557pft.44.2016.04.11.07.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 07:10:37 -0700 (PDT)
Received: from t430.minyard.net (unknown [IPv6:2001:470:b8f6:1b:59a1:bf28:3109:e55d])
        by serve.minyard.net (Postfix) with ESMTPA id 33F316CF;
        Mon, 11 Apr 2016 09:10:36 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id BF2E7300039; Mon, 11 Apr 2016 09:10:35 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] mips: Fix crash registers on non-crashing CPUs
Date:   Mon, 11 Apr 2016 09:10:19 -0500
Message-Id: <1460383819-5213-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.5.0
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

From: Corey Minyard <cminyard@mvista.com>

As part of handling a crash on an SMP system, an IPI is send to
all other CPUs to save their current registers and stop.  It was
using task_pt_regs(current) to get the registers, but that will
only be accurate if the CPU was interrupted running in userland.
Instead allow the architecture to pass in the registers (all
pass NULL now, but allow for the future) and then use get_irq_regs()
which should be accurate as we are in an interrupt.  Fall back to
task_pt_regs(current) if nothing else is available.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/kernel/crash.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d434d5d..610f0f3 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -14,12 +14,22 @@ static int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
 #ifdef CONFIG_SMP
-static void crash_shutdown_secondary(void *ignore)
+static void crash_shutdown_secondary(void *passed_regs)
 {
-	struct pt_regs *regs;
+	struct pt_regs *regs = passed_regs;
 	int cpu = smp_processor_id();
 
-	regs = task_pt_regs(current);
+	/*
+	 * If we are passed registers, use those.  Otherwise get the
+	 * regs from the last interrupt, which should be correct, as
+	 * we are in an interrupt.  But if the regs are not there,
+	 * pull them from the top of the stack.  They are probably
+	 * wrong, but we need something to keep from crashing again.
+	 */
+	if (!regs)
+		regs = get_irq_regs();
+	if (!regs)
+		regs = task_pt_regs(current);
 
 	if (!cpu_online(cpu))
 		return;
-- 
2.5.0
