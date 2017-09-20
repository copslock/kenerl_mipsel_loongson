Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 01:38:35 +0200 (CEST)
Received: from mail-pg0-x22f.google.com ([IPv6:2607:f8b0:400e:c05::22f]:53421
        "EHLO mail-pg0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994066AbdITXiEcOAwN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2017 01:38:04 +0200
Received: by mail-pg0-x22f.google.com with SMTP id j70so2536624pgc.10
        for <linux-mips@linux-mips.org>; Wed, 20 Sep 2017 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G76QYbXz5J4jDqK4h8cxzGawqSZWs1U5/wIvrFd7Clc=;
        b=grLifq30bSVWrkIzVWVSMR9T4xPGBSFbMuYVFjnjNDbbqvkMJi8vb73m3S5Se0drQy
         cZpLYIC5VIQ4xXGcXbKRKLaWGPK8c4wfd33UHs/sFn+k8hO553Bi3zRFnj3iYCOo4EqF
         3tJm0Smrt8vjYN9kQzJD/IeE9BLAh3hG0VgnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G76QYbXz5J4jDqK4h8cxzGawqSZWs1U5/wIvrFd7Clc=;
        b=oU4s3smqCq8OmNWDPwn6s8aMEHZzjbavTsLLKNU9BK4pn34xfAgrpXCc4CM5unl2v8
         y+zEXukP6hY5qjg0f0CHPUc/p3XaX4vS+zVQ30AoIwo96VHHFXnJeLWitsv2r+/UoAxq
         6hSsxpx4JDWlQaybv+H86zZUOQrvM6Z0DsNUXjwHrAFL0rDHjQjqAroCrdNYCaRT5Kep
         nqY7PZAJZ6uAbDLZfa0id0AJIFjGCah/8FafQbOluitnA+utuGHHKGE8Wo/IvARh8UZ2
         6zJby0n5cLCmA1h1dGOjybnXOk8XDrVCDzrrC52Na2QGYcYurPu5PPwaL1NK+gFbWUNU
         rnOg==
X-Gm-Message-State: AHPjjUgcylPPwDnEVqOsE7NoG4r/zVumLhiOduAcT8Fl+Z+IieA+rYhK
        ijMZ83B2Wx8BPbEC4y6zc9iazA==
X-Google-Smtp-Source: AOwi7QDBUu4C2h4MAqI5HridF6uK8+Aj0PN22t5PYAZGwL2jZ5LWv+4dZmormor8Dod+NnMP7YUgDw==
X-Received: by 10.99.95.145 with SMTP id t139mr3780455pgb.153.1505950677225;
        Wed, 20 Sep 2017 16:37:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v71sm82204pfa.45.2017.09.20.16.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 16:37:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/31] mips/sgi-ip32: Use separate static data field with with static timer
Date:   Wed, 20 Sep 2017 16:27:47 -0700
Message-Id: <1505950075-50223-24-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1505950075-50223-1-git-send-email-keescook@chromium.org>
References: <1505950075-50223-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60099
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

In preparation for changing the timer callback argument to the timer
pointer, move to a separate static data variable.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/sgi-ip32/ip32-reset.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index 4e263fd4deff..6636a9c686cd 100644
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
+static void blink_timeout(unsigned long unused)
 {
 	unsigned long led = mace->perif.ctrl.misc ^ MACEISA_LED_RED;
 	mace->perif.ctrl.misc = led;
-	mod_timer(&blink_timer, jiffies + data);
+	mod_timer(&blink_timer, jiffies + blink_timer_timeout);
 }
 
 static void ip32_machine_halt(void)
@@ -99,8 +100,8 @@ void ip32_prepare_poweroff(void)
 	}
 
 	shutting_down = 1;
-	blink_timer.data = POWERDOWN_FREQ;
-	blink_timeout(POWERDOWN_FREQ);
+	blink_timer_timeout = POWERDOWN_FREQ;
+	blink_timeout(0);
 
 	setup_timer(&power_timer, power_timeout, 0UL);
 	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
@@ -120,8 +121,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
 	led = mace->perif.ctrl.misc | MACEISA_LED_GREEN;
 	mace->perif.ctrl.misc = led;
 
-	blink_timer.data = PANIC_FREQ;
-	blink_timeout(PANIC_FREQ);
+	blink_timer_timeout = PANIC_FREQ;
+	blink_timeout(0);
 
 	return NOTIFY_DONE;
 }
@@ -142,8 +143,7 @@ static __init int ip32_reboot_setup(void)
 	_machine_halt = ip32_machine_halt;
 	pm_power_off = ip32_machine_halt;
 
-	init_timer(&blink_timer);
-	blink_timer.function = blink_timeout;
+	setup_timer(&blink_timer, blink_timeout, 0);
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
-- 
2.7.4
