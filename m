Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:28:09 +0200 (CEST)
Received: from mail-pf0-x230.google.com ([IPv6:2607:f8b0:400e:c00::230]:44996
        "EHLO mail-pf0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdJDX2AW0A7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:00 +0200
Received: by mail-pf0-x230.google.com with SMTP id t62so5849744pfd.1
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITVgLNE8i9rAfzq2Kc2r6lp0r3r+3s7RVwwO69tcgXU=;
        b=P6ZY++0x9wt6TdbCRt5x1tyhZRzZ6cGTL4gUmXQwU3fRmTkFzx6NZkJlrux+ulED4L
         KXh6ARQJBpqR50VHUA2VHcBtnjwSd6aGmCuLGi1VE25X0SP9TQH21uVNBs7uYZT74LfA
         jHIahkBirmsgmlsdLF4+U4yDBYDTQwfWb9TKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITVgLNE8i9rAfzq2Kc2r6lp0r3r+3s7RVwwO69tcgXU=;
        b=kUcwq6KIIqcBTK3QD34cBoP27Zkdraflsyi4su7x8fOoFggYXopIULpJcXvDhgShmi
         0sC+mwJb4YhEU81uXIm5EgGBpjFyJScMQkjYfKwiqdSZQrClb/1+/B26GzEEhZX7KkiV
         Lwo0qfBUuWbvQygjkJDg1AXrc8CTpRZYd1sQiVkVCGzSih+lpQ3IIf6+s6RfH6dw6SUs
         jJLZyVwfUEHUTE4HWJ7xCgrNa7ZIFOiBXqUjJLrDPVbPn11pQ3DXK3YPXH2yhcmBiJbl
         kUi91m/LnXkUO2rV5C1uTOFdg03FYyNYGxmeOuQ1FM7shE2xfPLbEQEZQnJeUVIkXu4v
         EA5A==
X-Gm-Message-State: AHPjjUi0ssARiizMUV8AcyWtjKoSyQQKxsTAb4TnejRWadVzCouELSGF
        BYkEYDzJRodZ4nneJwRFLRON0Q==
X-Google-Smtp-Source: AOwi7QDS9taT2iqNfNw4YiUZazaApwNZ3lsPhv8LNud5SnwE8aYCExF239pUvfz6UbV6TsSmYJpqpg==
X-Received: by 10.99.9.198 with SMTP id 189mr19278629pgj.395.1507159674359;
        Wed, 04 Oct 2017 16:27:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p77sm30484216pfa.92.2017.10.04.16.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] timer: Remove init_timer_pinned_deferrable() in favor of timer_setup()
Date:   Wed,  4 Oct 2017 16:26:56 -0700
Message-Id: <1507159627-127660-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60255
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

This refactors the only user of init_timer_pinned_deferrable() to use the
new timer_setup() and from_timer(). Adds a pointer back to the policy,
and drops the definition of init_timer_pinned_deferrable().

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 13 +++++++------
 include/linux/timer.h             |  2 --
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 3ff5160451b4..b6d7c4c98d0a 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -90,6 +90,7 @@ struct global_pstate_info {
 	int last_gpstate_idx;
 	spinlock_t gpstate_lock;
 	struct timer_list timer;
+	struct cpufreq_policy *policy;
 };
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
@@ -625,10 +626,10 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
  * according quadratic equation. Queues a new timer if it is still not equal
  * to local pstate
  */
-void gpstate_timer_handler(unsigned long data)
+void gpstate_timer_handler(struct timer_list *t)
 {
-	struct cpufreq_policy *policy = (struct cpufreq_policy *)data;
-	struct global_pstate_info *gpstates = policy->driver_data;
+	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
+	struct cpufreq_policy *policy = gpstates->policy;
 	int gpstate_idx, lpstate_idx;
 	unsigned long val;
 	unsigned int time_diff = jiffies_to_msecs(jiffies)
@@ -800,9 +801,9 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = gpstates;
 
 	/* initialize timer */
-	init_timer_pinned_deferrable(&gpstates->timer);
-	gpstates->timer.data = (unsigned long)policy;
-	gpstates->timer.function = gpstate_timer_handler;
+	gpstates->policy = policy;
+	timer_setup(&gpstates->timer, gpstate_timer_handler,
+		    TIMER_PINNED | TIMER_DEFERRABLE);
 	gpstates->timer.expires = jiffies +
 				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
 	spin_lock_init(&gpstates->gpstate_lock);
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 5ef5c9e41a09..d11e819a86e2 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -132,8 +132,6 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 	__init_timer((timer), TIMER_PINNED)
 #define init_timer_deferrable(timer)					\
 	__init_timer((timer), TIMER_DEFERRABLE)
-#define init_timer_pinned_deferrable(timer)				\
-	__init_timer((timer), TIMER_DEFERRABLE | TIMER_PINNED)
 #define init_timer_on_stack(timer)					\
 	__init_timer_on_stack((timer), 0)
 
-- 
2.7.4
