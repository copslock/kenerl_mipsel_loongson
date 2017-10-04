Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:32:50 +0200 (CEST)
Received: from mail-pf0-x236.google.com ([IPv6:2607:f8b0:400e:c00::236]:47536
        "EHLO mail-pf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdJDX2NQv1pm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:13 +0200
Received: by mail-pf0-x236.google.com with SMTP id u12so7045000pfl.4
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DT4cSE8CrReZntu4jHNGhn7m+qOKVCaJI6Hr85gR040=;
        b=PZH4ATsXg52DJOJBqiBbSv+Jckrl9j2ea2iz1J4oLKOOa0b+k2RViAkh7sGOwAzoj9
         /iqceILnwT8/nr0TOH+VzgKuFO+GQsyNz2m+bDy15rjwnBlDSE6ANOnDDWJmtQhAIoX8
         wfqiARND5kC4aKKjTbkU0A93QDa4jiKo1OjRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DT4cSE8CrReZntu4jHNGhn7m+qOKVCaJI6Hr85gR040=;
        b=icKs1KbH+4aCRWCGjLXpjDqOQDKemcFUDQfiNYpwWA1hvrG+igVwY3H05MTg0i/NX0
         +TWT0Uegd4I+PKqWuChCn3bgxPWnIx3hY7JO6bCWEqw2wrZn6Tw9vOhC6FcxOfUn8ulR
         FhIzBmdtA6g0nlcAhfygRJYk5Pf0kvJXcRMCLrRCdeubyFn3SUYVL/2lulll5HzUY8Ji
         yqwpIx0J/ZZyW26j1RIl8nbFSDfAC5Upk6uQz5ZxRZ8A3j51ojVdlZaJZ8FKaN3WENYM
         TjuVnlJWbcfhu/yB10qrlS4cuUOGK6SpDTWcxT4eOlKejQ+NaBCObZ+Hd1imfQCeFl0X
         Nmaw==
X-Gm-Message-State: AHPjjUgDGqYnJ2LoSFLO7HGRzJAmnhLI3Gi3sC/A1YRkJOQ9qxJnZ2U6
        SKjHjGjGXfsrKF7zx8zqPU+ogg==
X-Google-Smtp-Source: AOwi7QB9FqJmxHiOwuV2vB5TfENqHLFIYclzbhARdf33WFIVWjrY7Lol2zIjFj0VYKIs0uK8JfSjQA==
X-Received: by 10.84.160.6 with SMTP id n6mr21387467pla.393.1507159687244;
        Wed, 04 Oct 2017 16:28:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x4sm27395101pfb.101.2017.10.04.16.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:28:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
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
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] workqueue: Convert callback to use from_timer()
Date:   Wed,  4 Oct 2017 16:27:07 -0700
Message-Id: <1507159627-127660-14-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60267
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

In preparation for unconditionally passing the struct timer_list pointer
to all timer callbacks, switch workqueue to use from_timer() and pass the
timer pointer explicitly.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/workqueue.h | 15 ++++++++-------
 kernel/workqueue.c        |  7 +++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index f4960260feaf..f3c47a05fd06 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -17,7 +17,7 @@ struct workqueue_struct;
 
 struct work_struct;
 typedef void (*work_func_t)(struct work_struct *work);
-void delayed_work_timer_fn(unsigned long __data);
+void delayed_work_timer_fn(struct timer_list *t);
 
 /*
  * The first word is the work queue pointer and the flags rolled into
@@ -175,8 +175,8 @@ struct execute_work {
 
 #define __DELAYED_WORK_INITIALIZER(n, f, tflags) {			\
 	.work = __WORK_INITIALIZER((n).work, (f)),			\
-	.timer = __TIMER_INITIALIZER(delayed_work_timer_fn,		\
-				     (unsigned long)&(n),		\
+	.timer = __TIMER_INITIALIZER((TIMER_FUNC_TYPE)delayed_work_timer_fn,\
+				     (TIMER_DATA_TYPE)&(n.timer),	\
 				     (tflags) | TIMER_IRQSAFE),		\
 	}
 
@@ -241,8 +241,9 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
-		__setup_timer(&(_work)->timer, delayed_work_timer_fn,	\
-			      (unsigned long)(_work),			\
+		__setup_timer(&(_work)->timer,				\
+			      (TIMER_FUNC_TYPE)delayed_work_timer_fn,	\
+			      (TIMER_DATA_TYPE)&(_work)->timer,		\
 			      (_tflags) | TIMER_IRQSAFE);		\
 	} while (0)
 
@@ -250,8 +251,8 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 	do {								\
 		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
 		__setup_timer_on_stack(&(_work)->timer,			\
-				       delayed_work_timer_fn,		\
-				       (unsigned long)(_work),		\
+				       (TIMER_FUNC_TYPE)delayed_work_timer_fn,\
+				       (TIMER_DATA_TYPE)&(_work)->timer,\
 				       (_tflags) | TIMER_IRQSAFE);	\
 	} while (0)
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a5361fc6215d..c77fdf6bf24f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1492,9 +1492,9 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 }
 EXPORT_SYMBOL(queue_work_on);
 
-void delayed_work_timer_fn(unsigned long __data)
+void delayed_work_timer_fn(struct timer_list *t)
 {
-	struct delayed_work *dwork = (struct delayed_work *)__data;
+	struct delayed_work *dwork = from_timer(dwork, t, timer);
 
 	/* should have been called from irqsafe timer with irq already off */
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
@@ -1508,8 +1508,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn ||
-		     timer->data != (unsigned long)dwork);
+	WARN_ON_ONCE(timer->function != (TIMER_FUNC_TYPE)delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.7.4
