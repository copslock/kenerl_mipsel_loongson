Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:28:34 +0200 (CEST)
Received: from mail-pf0-x22d.google.com ([IPv6:2607:f8b0:400e:c00::22d]:45539
        "EHLO mail-pf0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990486AbdJDX2BOiScm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:01 +0200
Received: by mail-pf0-x22d.google.com with SMTP id z84so7040628pfi.2
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67lNcmTJD8eDcRFIcEYRPiQyX9e9vZL80l8VumkvgEE=;
        b=L1eOrapKBcJORksGEyUWyYFBS+3F8VUxXZm7yG+1yWIUKm5fcUwsYFP6uPqNPez4Ej
         Lj5Nt+phsunYNpRR4aMhIrIbs7TBo4B8W9Q2ZI8yLx/lM/N0gFzjrzTt5D61sDaLN6Et
         AQnbwOxULVfSggKNmwpnJHNzb4cdJSDxh12Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67lNcmTJD8eDcRFIcEYRPiQyX9e9vZL80l8VumkvgEE=;
        b=F0VZzbvsCvRGMElwftPSvOhBG8CNdu1094wqhfMPJ7gW9zOIiku1Q/yY1Z1RqVVfOt
         zv8rP8d2VTwHawYKsOcUPIg948VQAUDFaO95MI8/3EpCzEvpcgryxN8ua2EYuHEpi34l
         IplQPS4r0CMpVDsp3KWuipPNIsEjyNDv8K4plAqdCcmQsbUhTYS9J1nynJlkD3rtWuF6
         aKkCF0X8PJ9Hj8fxvqh/ZD27/jKfS5goi87+yoLTi8nSJ5PlbBK6AA5ajm4Ix2u770Pt
         gg8RuUtrNfItUa/jcshYBGY4hkD+TxES2XSgmmJwoGxU9Oqt08N6OojCMQDmg6NEDr1h
         Zj6w==
X-Gm-Message-State: AHPjjUgPlFOO5XxouAyNhneOZjdcKjIFqKsmyQCWCMpilheyGilHxHS8
        5Q+EhulyYrErOGGbbsZLvhI7rg==
X-Google-Smtp-Source: AOwi7QC9F+kEL/da8sr1x4sfLUOlhO7naWz+N7GbL2+b834jPamhjYfFp2VcRdQT+qeh+v7G+2yzmw==
X-Received: by 10.99.108.66 with SMTP id h63mr20000225pgc.211.1507159673590;
        Wed, 04 Oct 2017 16:27:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s9sm28691081pfk.20.2017.10.04.16.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] timer: Convert schedule_timeout() to use from_timer()
Date:   Wed,  4 Oct 2017 16:26:55 -0700
Message-Id: <1507159627-127660-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60256
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
all timer callbacks, switch to using the new from_timer() helper and passing
the timer pointer explicitly. Since this special timer is on the stack, it
needs to have a wrapper structure to carry state once .data is eliminated.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/timer.h |  8 ++++++++
 kernel/time/timer.c   | 26 +++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 6383c528b148..5ef5c9e41a09 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -179,6 +179,14 @@ static inline void timer_setup(struct timer_list *timer,
 		      (TIMER_DATA_TYPE)timer, flags);
 }
 
+static inline void timer_setup_on_stack(struct timer_list *timer,
+			       void (*callback)(struct timer_list *),
+			       unsigned int flags)
+{
+	__setup_timer_on_stack(timer, (TIMER_FUNC_TYPE)callback,
+			       (TIMER_DATA_TYPE)timer, flags);
+}
+
 #define from_timer(var, callback_timer, timer_fieldname) \
 	container_of(callback_timer, typeof(*var), timer_fieldname)
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f2674a056c26..38613ced2324 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1668,9 +1668,20 @@ void run_local_timers(void)
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
-static void process_timeout(unsigned long __data)
+/*
+ * Since schedule_timeout()'s timer is defined on the stack, it must store
+ * the target task on the stack as well.
+ */
+struct process_timer {
+	struct timer_list timer;
+	struct task_struct *task;
+};
+
+static void process_timeout(struct timer_list *t)
 {
-	wake_up_process((struct task_struct *)__data);
+	struct process_timer *timeout = from_timer(timeout, t, timer);
+
+	wake_up_process(timeout->task);
 }
 
 /**
@@ -1704,7 +1715,7 @@ static void process_timeout(unsigned long __data)
  */
 signed long __sched schedule_timeout(signed long timeout)
 {
-	struct timer_list timer;
+	struct process_timer timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -1738,13 +1749,14 @@ signed long __sched schedule_timeout(signed long timeout)
 
 	expire = timeout + jiffies;
 
-	setup_timer_on_stack(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire, false);
+	timer.task = current;
+	timer_setup_on_stack(&timer.timer, process_timeout, 0);
+	__mod_timer(&timer.timer, expire, false);
 	schedule();
-	del_singleshot_timer_sync(&timer);
+	del_singleshot_timer_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
-	destroy_timer_on_stack(&timer);
+	destroy_timer_on_stack(&timer.timer);
 
 	timeout = expire - jiffies;
 
-- 
2.7.4
