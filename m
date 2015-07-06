Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:12:49 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33559 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011152AbbGFLMhBJVTe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:12:37 +0200
Received: by pacws9 with SMTP id ws9so95451146pac.0
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FKIsDLBvJNNTgDK55j+9I7XJvBVOOEqFjzIhsXxXln8=;
        b=BtrArTjkVU2tjnI8rwYb1XWT/pBOn+z6ttd8diR1sfIpUtKemV/70ey+sWvxuLy3G3
         mCtGbKIYaVUkkA+4XgvMSy8D2bpUSkhys0yOX55G0OV/QLdmiVc8CMKlN5logQ36i9AG
         f1EC3HFVfbkNou9DZUPhyMB31sI2mRx6MmkXyx363s7dCZ6Y8/8MN9T7jqIChe2b/Ree
         U6R2JbVo9zrn3Ha4AESfBbO1tigKb1moTRsZDJGul08cm/bWR5WHzkVpdHQiLl76B2AT
         V1iDOdUdhMv3fIkfMDDCEMw2hq4R/xSk0AG1RQeNGP3VFvN0EIjJn1eGTSws+uttGs6x
         muGA==
X-Gm-Message-State: ALoCoQlzwU3Q80BupFMAwvHFqk5S/2KpKwFjBQLq5CiCu+d2MtphtPQZL0+VyaP8b8u++zRsEMY4
X-Received: by 10.70.41.78 with SMTP id d14mr105286587pdl.35.1436181151015;
        Mon, 06 Jul 2015 04:12:31 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id qo6sm17961570pab.23.2015.07.06.04.12.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 01/14] MIPS/alchemy/time: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:52 +0530
Message-Id: <7b140cad62ca40bc9dbe6678c34b6b5d42848a0d.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48066
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

Migrate alchemy driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/alchemy/common/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 50e17e13c18b..f99d3ec17a45 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -69,11 +69,6 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void au1x_rtcmatch2_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *cd)
-{
-}
-
 static irqreturn_t au1x_rtcmatch2_irq(int irq, void *dev_id)
 {
 	struct clock_event_device *cd = dev_id;
@@ -86,7 +81,6 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 1500,
 	.set_next_event = au1x_rtcmatch2_set_next_event,
-	.set_mode	= au1x_rtcmatch2_set_mode,
 	.cpumask	= cpu_all_mask,
 };
 
-- 
2.4.0
