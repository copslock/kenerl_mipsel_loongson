Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 00:05:04 +0200 (CEST)
Received: from mail-pf0-x22b.google.com ([IPv6:2607:f8b0:400e:c00::22b]:55999
        "EHLO mail-pf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992864AbdJJWE4290A3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 00:04:56 +0200
Received: by mail-pf0-x22b.google.com with SMTP id 17so10334091pfn.12
        for <linux-mips@linux-mips.org>; Tue, 10 Oct 2017 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kfdPF8wkwN49XatIe4A9eRzXjRSutmTtq5OhltIZlJg=;
        b=g//WcoDLHG5IemGhH58KQxaIR7kDtOTAS0+eRPXevxNjFlt3WvJvtkOsK/VbHDCu40
         uhTnN6NXCao6YFLJ6U8hxNVSml3S12HP5T5PZxEKdvFG5OXUyQSfueEDXIskVtpSseIu
         0tPC0t1Nnb3/ziyxZ8tTA7uFNQEbPuK2bnu+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kfdPF8wkwN49XatIe4A9eRzXjRSutmTtq5OhltIZlJg=;
        b=kDczI5tBJk9alFHw5VwUY7UJO/PJ1fQZZ07u8oeCvBI004EVWfgsKt1nZ0xYBJcdS6
         6pVo94SkQc9bfBk9/oEBePcbmksI/xxttg0FQlRQcXwIdhrtx811ZuSiIb5I7BaUEKEf
         kpqWQRWNW/Kn8l8tJuRy+S9G4CrsazSNBTRemF8Vx9ZAOGbq3wXS7pAwYpxvZreRgnbG
         XJ0RHHgYTETCLliFtYI3BfTTp3eoi8vODtvBkNIASVQyjoVF/vT4Zi5eyXh2KaiADOns
         dR8IvI3jJOASpp6VRSFrxHSTRnC4gXldVq1oGiDX2vp5f25a+NShwoB1VToI2a9d6Qqu
         7iqA==
X-Gm-Message-State: AMCzsaVhA1CzyZbZLgvEVagzc7Zxa3Ja+XhBUhndaMmWrN8Bb92K+YWw
        RIFkIyTf0rn5q+WXEZJ+Uzya6A==
X-Google-Smtp-Source: AOwi7QAUT2/C0+81gbA2tN5inAe8CUhB8cFPbF5Q7Jv4uM6a7S5qSEN8JOUljO9i0XC8AijF240HFg==
X-Received: by 10.99.36.133 with SMTP id k127mr7907772pgk.171.1507673089821;
        Tue, 10 Oct 2017 15:04:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z8sm21942294pfg.23.2017.10.10.15.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 15:04:48 -0700 (PDT)
Date:   Tue, 10 Oct 2017 15:04:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: ip22/32: Convert timers to use timer_setup()
Message-ID: <20171010220446.GA97522@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Adds a static variable to hold timeout
value.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
After discussion with tglx, here is a new approach that can be merged
via maintainer trees instead of through the timer tree. Note that
this requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 arch/mips/sgi-ip22/ip22-reset.c | 26 ++++++++++++--------------
 arch/mips/sgi-ip32/ip32-reset.c | 21 ++++++++++-----------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 03a39ac5ead9..c374f3ceec38 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -38,6 +38,7 @@
 #define PANIC_FREQ		(HZ / 8)
 
 static struct timer_list power_timer, blink_timer, debounce_timer;
+static unsigned long blink_timer_timeout;
 
 #define MACHINE_PANICED		1
 #define MACHINE_SHUTTING_DOWN	2
@@ -81,21 +82,21 @@ static void __noreturn sgi_machine_halt(void)
 	ArcEnterInteractiveMode();
 }
 
-static void power_timeout(unsigned long data)
+static void power_timeout(struct timer_list *unused)
 {
 	sgi_machine_power_off();
 }
 
-static void blink_timeout(unsigned long data)
+static void blink_timeout(struct timer_list *unused)
 {
 	/* XXX fix this for fullhouse  */
 	sgi_ioc_reset ^= (SGIOC_RESET_LC0OFF|SGIOC_RESET_LC1OFF);
 	sgioc->reset = sgi_ioc_reset;
 
-	mod_timer(&blink_timer, jiffies + data);
+	mod_timer(&blink_timer, jiffies + blink_timer_timeout);
 }
 
-static void debounce(unsigned long data)
+static void debounce(struct timer_list *unused)
 {
 	del_timer(&debounce_timer);
 	if (sgint->istat1 & SGINT_ISTAT1_PWR) {
@@ -128,11 +129,10 @@ static inline void power_button(void)
 	}
 
 	machine_state |= MACHINE_SHUTTING_DOWN;
-	blink_timer.data = POWERDOWN_FREQ;
-	blink_timeout(POWERDOWN_FREQ);
+	blink_timer_timeout = POWERDOWN_FREQ;
+	blink_timeout(&blink_timer);
 
-	init_timer(&power_timer);
-	power_timer.function = power_timeout;
+	timer_setup(&power_timer, power_timeout, 0);
 	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
 	add_timer(&power_timer);
 }
@@ -147,8 +147,7 @@ static irqreturn_t panel_int(int irq, void *dev_id)
 	if (sgint->istat1 & SGINT_ISTAT1_PWR) {
 		/* Wait until interrupt goes away */
 		disable_irq_nosync(SGI_PANEL_IRQ);
-		init_timer(&debounce_timer);
-		debounce_timer.function = debounce;
+		timer_setup(&debounce_timer, debounce, 0);
 		debounce_timer.expires = jiffies + 5;
 		add_timer(&debounce_timer);
 	}
@@ -171,8 +170,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
 		return NOTIFY_DONE;
 	machine_state |= MACHINE_PANICED;
 
-	blink_timer.data = PANIC_FREQ;
-	blink_timeout(PANIC_FREQ);
+	blink_timer_timeout = PANIC_FREQ;
+	blink_timeout(&blink_timer);
 
 	return NOTIFY_DONE;
 }
@@ -195,8 +194,7 @@ static int __init reboot_setup(void)
 		return res;
 	}
 
-	init_timer(&blink_timer);
-	blink_timer.function = blink_timeout;
+	timer_setup(&blink_timer, blink_timeout, 0);
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index b3b442def423..20d8637340be 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -38,6 +38,7 @@
 extern struct platform_device ip32_rtc_device;
 
 static struct timer_list power_timer, blink_timer;
+static unsigned long blink_timer_timeout;
 static int has_panicked, shutting_down;
 
 static __noreturn void ip32_poweroff(void *data)
@@ -71,11 +72,11 @@ static void ip32_machine_restart(char *cmd)
 	unreachable();
 }
 
-static void blink_timeout(unsigned long data)
+static void blink_timeout(struct timer_list *unused)
 {
 	unsigned long led = mace->perif.ctrl.misc ^ MACEISA_LED_RED;
 	mace->perif.ctrl.misc = led;
-	mod_timer(&blink_timer, jiffies + data);
+	mod_timer(&blink_timer, jiffies + blink_timer_timeout);
 }
 
 static void ip32_machine_halt(void)
@@ -83,7 +84,7 @@ static void ip32_machine_halt(void)
 	ip32_poweroff(&ip32_rtc_device);
 }
 
-static void power_timeout(unsigned long data)
+static void power_timeout(struct timer_list *unused)
 {
 	ip32_poweroff(&ip32_rtc_device);
 }
@@ -99,11 +100,10 @@ void ip32_prepare_poweroff(void)
 	}
 
 	shutting_down = 1;
-	blink_timer.data = POWERDOWN_FREQ;
-	blink_timeout(POWERDOWN_FREQ);
+	blink_timer_timeout = POWERDOWN_FREQ;
+	blink_timeout(&blink_timer);
 
-	init_timer(&power_timer);
-	power_timer.function = power_timeout;
+	timer_setup(&power_timer, power_timeout, 0);
 	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
 	add_timer(&power_timer);
 }
@@ -121,8 +121,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
 	led = mace->perif.ctrl.misc | MACEISA_LED_GREEN;
 	mace->perif.ctrl.misc = led;
 
-	blink_timer.data = PANIC_FREQ;
-	blink_timeout(PANIC_FREQ);
+	blink_timer_timeout = PANIC_FREQ;
+	blink_timeout(&blink_timer);
 
 	return NOTIFY_DONE;
 }
@@ -143,8 +143,7 @@ static __init int ip32_reboot_setup(void)
 	_machine_halt = ip32_machine_halt;
 	pm_power_off = ip32_machine_halt;
 
-	init_timer(&blink_timer);
-	blink_timer.function = blink_timeout;
+	timer_setup(&blink_timer, blink_timeout, 0);
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
