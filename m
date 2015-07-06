Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:14:33 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32807 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010581AbbGFLNGiVpDe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:06 +0200
Received: by pacws9 with SMTP id ws9so95457428pac.0
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=a0yR2nJJ5cveD5tTi8DzaB3qS7bCHOXXFE/AoCbWCbg=;
        b=Uu/PhmjBsJqlPODbEK6MdOeWNqgmnaCJ3jyEZtSpOo0iW96uHzmI3bvFVTF+nklZQN
         djOvLOtC9Ak/7ABWXzaR1UaNI8wK7rvVAg348SS1lHppTyPmz1K9qijVSYmkY3gc3onE
         h9a5XtiYkR6hdrPZpRqIXcCk3wu2CUuzJ7rbbb9B7J2i2zKramxszK0sPy1XxN9d7WMK
         XENhs7t0vqt/UfW7QEUripLlKCWM0+usRlT4eCfVHjJR3OZ0Z3iGd+n898jTj+R2z7O5
         /sySegRE1L93t3bXi5OBL8GY2W9/QB3aiagRz8RHOChRcdmJUFu8OUeeEDPoHUiSB75U
         Eq+A==
X-Gm-Message-State: ALoCoQmQNVV+G12XUyxCKwnISASdOcSekUOtt0LAAdobKtr9/7+kpUNIhbzSTY5beUVOAe3HQIxZ
X-Received: by 10.66.123.81 with SMTP id ly17mr105665740pab.31.1436181180969;
        Mon, 06 Jul 2015 04:13:00 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id s1sm17903496pda.54.2015.07.06.04.12.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: [PATCH 07/14] MIPS/cevt-r4k: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:58 +0530
Message-Id: <cc71e2a4cdc16660a59919f22358d159f4bd2ccf.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48072
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

Migrate cevt-4k driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/include/asm/cevt-r4k.h | 1 -
 arch/mips/kernel/cevt-r4k.c      | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/mips/include/asm/cevt-r4k.h b/arch/mips/include/asm/cevt-r4k.h
index f0edf6fcd002..2e13a038d260 100644
--- a/arch/mips/include/asm/cevt-r4k.h
+++ b/arch/mips/include/asm/cevt-r4k.h
@@ -21,7 +21,6 @@ DECLARE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 
 void mips_event_handler(struct clock_event_device *dev);
 int c0_compare_int_usable(void);
-void mips_set_clock_mode(enum clock_event_mode, struct clock_event_device *);
 irqreturn_t c0_compare_interrupt(int, void *);
 
 extern struct irqaction c0_compare_irqaction;
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index d70c4d893219..dd41d797e39f 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -28,12 +28,6 @@ static int mips_next_event(unsigned long delta,
 	return res;
 }
 
-void mips_set_clock_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
-{
-	/* Nothing to do ...  */
-}
-
 DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 int cp0_timer_irq_installed;
 
@@ -212,7 +206,6 @@ int r4k_clockevent_init(void)
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= mips_next_event;
-	cd->set_mode		= mips_set_clock_mode;
 	cd->event_handler	= mips_event_handler;
 
 	clockevents_register_device(cd);
-- 
2.4.0
