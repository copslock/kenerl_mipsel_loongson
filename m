Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 01:30:26 +0200 (CEST)
Received: from mail-pf0-x22e.google.com ([IPv6:2607:f8b0:400e:c00::22e]:35274
        "EHLO mail-pf0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994877AbdHaXaNzYh8M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 01:30:13 +0200
Received: by mail-pf0-x22e.google.com with SMTP id g13so3117461pfm.2
        for <linux-mips@linux-mips.org>; Thu, 31 Aug 2017 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55hA2axv18zpzl7Rx36J4rkSK3kBLOybzDH8hY+3dis=;
        b=carfF9OPIOh2+35W+HEKBw77jUr4oc1q4MnNOOUgRK3qsfEosUxGlx12W7wbZIzEEr
         mwY8lOUvDp34YE9QwD9UsJnwyUYP3oLWuhCG7hkf7aazgH0ByJzhDHuk9+FA8ndAhVFl
         49w3jlzF1Ay2M9BTPt3Uu0zrRdaC0xcVKnd4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55hA2axv18zpzl7Rx36J4rkSK3kBLOybzDH8hY+3dis=;
        b=nPxvpjCr+iKNeZmF6eemlD3+XO7uDRPMxv6tWxONgIPVDzDOywEggwH1+4GKGp1d+W
         f5YROMltEuJIafD8ch2qV2AkX0DFQIyDxxFwW3uTUMeJ5lXJFgj4HkCuU4LKbjGz/SW1
         8ldsqxmH3rHFlhzmjzUJR3KYw9RemthvFegNsqU99AEGgqN+kDVrIiR+rzSzPHsTRR5C
         n0+cvfl9VSFGTu1uokbTw0dYucBIAEi1QPpk/7RCbdKw3IkNtyzLFUrEOx2p0u8u5BDG
         IhRT6ZnmcYlqoAJM/TLCVS6sTg+V2S3Ja1W7nBOvdhKDa18SB3hA1RQYXM1O2CCT6C6x
         vBQA==
X-Gm-Message-State: AHPjjUhKHy5eMHgBLvAWq7d5txzaCWO4PqGKBXCP3tdWyuWXzi3ZPC7n
        C4DYEBtoqhZ9FnEx
X-Google-Smtp-Source: ADKCNb5mC6RqhxpJ9aehjDrrRwDhrFTDrhIFryY6qtGlEr1OSSoQ4XtOx4dAYhwB7se64JV8/oVuYg==
X-Received: by 10.99.115.85 with SMTP id d21mr148354pgn.348.1504222207678;
        Thu, 31 Aug 2017 16:30:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q9sm878362pgs.45.2017.08.31.16.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2017 16:30:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/31] mips/sgi-ip22: Use separate static data field with with static timer
Date:   Thu, 31 Aug 2017 16:29:36 -0700
Message-Id: <1504222183-61202-25-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504222183-61202-1-git-send-email-keescook@chromium.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59900
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
