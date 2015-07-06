Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:13:07 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34843 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbbGFLMmLVlWe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:12:42 +0200
Received: by pdbci14 with SMTP id ci14so104381257pdb.2
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8Xjh2SEuS5ZK09vz1PcJlWQEN3Inizln5OG3iOR4u88=;
        b=A5wC+LHJfiUZ9j5TwpIZAxfm9q3LdZX0s7fLG+uNXybvbkLkBH27hvMVJZS2lPPO8U
         Y7t+jsy7CVwevtg0macEjzDwwl2lLFnc4/h4WLenOnV2qV/3H2pakSIAlL30NhsrroM4
         lhwu6OveNA19QzSTp+x9C3rbkAfK1/KFyMeGjpPfp+wWoSckZaOmHBGKl3ifk78RXtOY
         auHHeGD8LFZeLvuaEsF3yTbrugVdBINZ6HHGOgEVwjyVPIagFoduAF6wcNYgNluNH/6j
         B5KyYmAA5WC5y7gaczrsfK72ezv/Ntd29cepTSGVSuOq5zZdSxBNn1N3eHQBpf4iZhYT
         XtBQ==
X-Gm-Message-State: ALoCoQlZV5TH7x/aE5XjYfuqDPP33kZfuDvIOZZEOiAPq1zFUF3HcjDzqZZQ7kCcVhrY4IG9fWKA
X-Received: by 10.69.26.4 with SMTP id iu4mr103170014pbd.140.1436181156378;
        Mon, 06 Jul 2015 04:12:36 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id de2sm17913801pdb.15.2015.07.06.04.12.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/14] MIPS/jazz/timer: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:53 +0530
Message-Id: <9392073bddac9adc4f08eb9fbd61f332b1b449f5.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48067
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

Migrate jazz driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/jazz/irq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index e1ea4f625f7a..5d6828b2a750 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -110,18 +110,11 @@ asmlinkage void plat_irq_dispatch(void)
 	}
 }
 
-static void r4030_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *evt)
-{
-	/* Nothing to do ...  */
-}
-
 struct clock_event_device r4030_clockevent = {
 	.name		= "r4030",
 	.features	= CLOCK_EVT_FEAT_PERIODIC,
 	.rating		= 300,
 	.irq		= JAZZ_TIMER_IRQ,
-	.set_mode	= r4030_set_mode,
 };
 
 static irqreturn_t r4030_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
