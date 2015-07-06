Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:16:24 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32963 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012858AbbGFLNfkEVIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:35 +0200
Received: by pdbdz6 with SMTP id dz6so9160988pdb.0
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+2MQuBWkwNjmu7va+EbLWI4Z+W2JBoR8sZD3sxfezhQ=;
        b=folmsJwk3DQ6LVtn71zYKVwF+KhTnKxyo9T0YtbiMrsIN3DnWDqgtPEkZ1OE2qotAD
         guS5Bh7VW2Z8iayfI+aKxD4ZWcD9049iT4dRtQpgfbC+quduf/Sq98W7nmFY2DT4tIEL
         Ls5oebQFAOFF5GiJDP4LDbCcTFoQEe5qfSglrilJttd5K/Y2/dA1z7mJMzFIPTfTyYxy
         yQ2kU5SZlYUZaaTk3iR65qdcQqECEJ3aCZsUmigAHFOCn0yRpZGTYdN1qn0N6/tIKm0S
         mQ0QYzxxLNw580BYLO64JYfLpEQY6fLTtJcYsX9F7IBLJTuICJwCNliFK2w74vPinOmW
         Nyxg==
X-Gm-Message-State: ALoCoQlyB5t0eJHUN21Y/oOu7uCqgl8bs0sDRSDfmcc5+3BA3i2lp5Hsndl9O1Kd6zPkFZU7cP/h
X-Received: by 10.70.42.37 with SMTP id k5mr105262097pdl.13.1436181209975;
        Mon, 06 Jul 2015 04:13:29 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id og1sm1192597pdb.58.2015.07.06.04.13.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 13/14] MIPS/sgi-ip27/timer: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:42:04 +0530
Message-Id: <dc6249764864e493d7d8c9912cd04fbf9ce01266.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48078
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

Migrate sgidriver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/sgi-ip27/ip27-timer.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index a6d10f607f34..42d6cb9f956e 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -64,12 +64,6 @@ static int rt_next_event(unsigned long delta, struct clock_event_device *evt)
 	return LOCAL_HUB_L(PI_RT_COUNT) >= cnt ? -ETIME : 0;
 }
 
-static void rt_set_mode(enum clock_event_mode mode,
-		struct clock_event_device *evt)
-{
-	/* Nothing to do ...  */
-}
-
 unsigned int rt_timer_irq;
 
 static DEFINE_PER_CPU(struct clock_event_device, hub_rt_clockevent);
@@ -124,7 +118,6 @@ void hub_rt_clock_event_init(void)
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= rt_next_event;
-	cd->set_mode		= rt_set_mode;
 	clockevents_register_device(cd);
 }
 
-- 
2.4.0
