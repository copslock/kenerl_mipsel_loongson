Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 01:39:38 +0200 (CEST)
Received: from mail-pg0-x236.google.com ([IPv6:2607:f8b0:400e:c05::236]:38584
        "EHLO mail-pg0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995072AbdHaXjatTbiM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 01:39:30 +0200
Received: by mail-pg0-x236.google.com with SMTP id b8so3117162pgn.5
        for <linux-mips@linux-mips.org>; Thu, 31 Aug 2017 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jtd3HS6i2jCKtJkAG/UdZ6KcjDfMdLj1jOPK3Pv/H7w=;
        b=k+sTyXwZaGbi2B64Zkgzh4goGc3xYv8UoTzMvJ58Qu3yLSmkj68kO3FqWm60xs/hkt
         pXFWMkvPoPEtbyCl538+rYQiskBoUIMKPyzp2+nI5/2R0R/GhEJmhwVvJLAiZgTWfe1X
         onkFZ3rmbCFI6MXjM7y9qZ5GNCkKRGXaNYvTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jtd3HS6i2jCKtJkAG/UdZ6KcjDfMdLj1jOPK3Pv/H7w=;
        b=g5m4ezcFeSgcTbLI1md6SsSGEwuXUQjpuanFpmlLD5q1U4rD5Mse8UL0hhsz/OTap5
         ilwH10m6IoygRddelux5Kc5iUxVLkNekjVWnpFxdQeuDVH4LQGgkg/eMUnRFdD+HC5S7
         se+b7wdMz87vL2id+/YL9AhAtSInPWiUSk1cpyRX/WquZOgKJQu1Gh/MtE31uPxx8YfE
         zAtwIWui2ToJ/uri5uGpdXqC52ELSF09u3qZc4NuGJmQsZzxAUd89cXJSaEXdaP8354t
         2b19rDozD6KQXjUaLTlUK8dsOPWPaO7pju8ZnJVVWhQXFbGo+6tKiva+YeO/OFMcNcGf
         U3PA==
X-Gm-Message-State: AHPjjUi1vbmJ5+RX8Uw2OCUXFQf9Zu0LOexYpJb/NIZ07yCtfV1Os9ZD
        qZPVPq5PcSME8its
X-Google-Smtp-Source: ADKCNb5df2cupjmS9xA0pC1SN3xqp9wCGRgM8j1S4knwz4Pr+XVxmrh4IViRt+fq7s32hVLpFwwZKA==
X-Received: by 10.98.31.12 with SMTP id f12mr172909pff.72.1504222765101;
        Thu, 31 Aug 2017 16:39:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s23sm876632pgn.56.2017.08.31.16.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2017 16:39:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/31] mips/sgi-ip32: Use separate static data field with with static timer
Date:   Thu, 31 Aug 2017 16:29:35 -0700
Message-Id: <1504222183-61202-24-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504222183-61202-1-git-send-email-keescook@chromium.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59901
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
