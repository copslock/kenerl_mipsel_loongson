Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 01:38:08 +0200 (CEST)
Received: from mail-pf0-x232.google.com ([IPv6:2607:f8b0:400e:c00::232]:49620
        "EHLO mail-pf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993938AbdITXh5fbwfN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2017 01:37:57 +0200
Received: by mail-pf0-x232.google.com with SMTP id l188so2303506pfc.6
        for <linux-mips@linux-mips.org>; Wed, 20 Sep 2017 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E977DBXbxPrcRjT8A2Q9qzDCtqEkejcYagzI4Lc6AYw=;
        b=WbX+zNXTktIm4RFMCXFY5VAS4oO+GJAtXZPieB6BOBKC0eXGR93gXgiO4PFQAnMLKM
         zuRy8yERSj6ZJINbAGLsSihxRAQa6rzddCd8qSCWs86HPoq1EC0IiQ44JQRsYASPRcVZ
         opgfYu6xn2jnOUmeCZtbtcLWVOfJG7vNHXT/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E977DBXbxPrcRjT8A2Q9qzDCtqEkejcYagzI4Lc6AYw=;
        b=ilvc9RPWeuRm77VxTAJVBWiQQyT/lhvCTtudQyIT7APBX7O+aJvQvsp4At+s/wHrwy
         PesvQZ1Wx232bHdkAdApIYs3bmxIH9Cz1PrfTh7NZwq219pSN/7OkDjApj7xcs+9vvs7
         p0C4+ZgcD95jlqKwKZKqfEBYPo7DzKFb70dw/J30TVdReS+VvZ0QMihVbic8ulJp0CHP
         5+SOLEIooOMngPQ0RKk3gY1PE0l2I83Dc6lNcBhNT1ANywxQUs80f84EOsg+cwUBwLmh
         Y5D9Auxm9wzrxwiOUnSjjgZ66LnlYS9KT6jGm2VgE2JmV3yQXpoYqZ50qKq4usxx/rvZ
         byRw==
X-Gm-Message-State: AHPjjUj1nJ2rpGMhYwA5CeqwB2jE/8g5Ms/7/nvMWSTcVw9YFUrxyqQ6
        cHL6e2/nsH4bCqCoFsHYh3CCTg==
X-Google-Smtp-Source: AOwi7QAgilwJyHGB+D+8I94Nb9lueNzZ5foVIZ3knL4Tg9T8+ZEdZ+5OCq4srolRU9xC6s8xs5k0+A==
X-Received: by 10.84.132.33 with SMTP id 30mr3631598ple.372.1505950670756;
        Wed, 20 Sep 2017 16:37:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s17sm92853pgq.25.2017.09.20.16.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 16:37:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/31] mips/sgi-ip22: Use separate static data field with with static timer
Date:   Wed, 20 Sep 2017 16:27:48 -0700
Message-Id: <1505950075-50223-25-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1505950075-50223-1-git-send-email-keescook@chromium.org>
References: <1505950075-50223-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60098
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
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/sgi-ip22/ip22-reset.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 196b041866ac..5cc32610e6d3 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -38,6 +38,7 @@
 #define PANIC_FREQ		(HZ / 8)
 
 static struct timer_list power_timer, blink_timer, debounce_timer;
+static unsigned long blink_timer_timeout;
 
 #define MACHINE_PANICED		1
 #define MACHINE_SHUTTING_DOWN	2
@@ -86,13 +87,13 @@ static void power_timeout(unsigned long data)
 	sgi_machine_power_off();
 }
 
-static void blink_timeout(unsigned long data)
+static void blink_timeout(unsigned long unused)
 {
 	/* XXX fix this for fullhouse  */
 	sgi_ioc_reset ^= (SGIOC_RESET_LC0OFF|SGIOC_RESET_LC1OFF);
 	sgioc->reset = sgi_ioc_reset;
 
-	mod_timer(&blink_timer, jiffies + data);
+	mod_timer(&blink_timer, jiffies + blink_timer_timeout);
 }
 
 static void debounce(unsigned long data)
@@ -128,8 +129,8 @@ static inline void power_button(void)
 	}
 
 	machine_state |= MACHINE_SHUTTING_DOWN;
-	blink_timer.data = POWERDOWN_FREQ;
-	blink_timeout(POWERDOWN_FREQ);
+	blink_timer_timeout = POWERDOWN_FREQ;
+	blink_timeout(0);
 
 	setup_timer(&power_timer, power_timeout, 0UL);
 	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
@@ -169,8 +170,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
 		return NOTIFY_DONE;
 	machine_state |= MACHINE_PANICED;
 
-	blink_timer.data = PANIC_FREQ;
-	blink_timeout(PANIC_FREQ);
+	blink_timer_timeout = PANIC_FREQ;
+	blink_timeout(0);
 
 	return NOTIFY_DONE;
 }
@@ -193,8 +194,7 @@ static int __init reboot_setup(void)
 		return res;
 	}
 
-	init_timer(&blink_timer);
-	blink_timer.function = blink_timeout;
+	setup_timer(&blink_timer, blink_timeout, 0);
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	return 0;
-- 
2.7.4
