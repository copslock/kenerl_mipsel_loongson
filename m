Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:33:12 +0200 (CEST)
Received: from mail-pf0-x231.google.com ([IPv6:2607:f8b0:400e:c00::231]:50195
        "EHLO mail-pf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993877AbdJDX2OShz7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:14 +0200
Received: by mail-pf0-x231.google.com with SMTP id m63so7039254pfk.7
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qWhl+ozP//rPItOLapomnr7Om6Pai3qir5alpg2/EHM=;
        b=QUMbvx1hGUXobjOS1WgmwIapI6wOIaJpxEQaHKIQobF1/QoZmlCsOVLZv2n2CdmbI2
         pARZtZkCh7FN2/EpyuyoeLUzWKxRmTvlqIJO4wTY5dol2KemT0XoPvMjW12E22uvsqu/
         5WyEBGqbEfo5v5Q5qk1U52atawqW3zisFGJ8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qWhl+ozP//rPItOLapomnr7Om6Pai3qir5alpg2/EHM=;
        b=RWIBjhCBX+vaCyDY9zw2J9d4zzudFCW+mG6jI5d0hNwzJpriZKjhEEVCRyHbLUiEZP
         MI878R12vZCdtj8MaZbsH84U4hkWLaHN7ZHKYSSbRxmKuMWS2H1HFQa5W9GiUpnEDvS2
         Q2J37qpERwmOnA67scnES9B/uiOJODUcjRYycIoO83d9M5z8JeASKFhdMgenz6C9ZWRg
         LfsRY3WasLFpSU2cj8OcQEMzKvt/AvUdm1/+Oir+10lg36JhN3WwERGn0X7FKm5kzB4C
         8K2S7XY0Vf9xws8PMrxQGe+51NcD7BFRMCepg389+3qRi8w8Q2pPAsvZPBaENblRVFON
         8hBw==
X-Gm-Message-State: AMCzsaVtSQhmbVOYIM4AzzHZxEkzW/fbr2WlP2sldqOwGF/j+Pj8HX0c
        vTj2evtfdtv8mN6by6R565orzg==
X-Google-Smtp-Source: AOwi7QC6op5nWi557zfz9/okY8sC6FtmjMT+EmeAkiPxndf7CtwOa+OXXa6ALCSMhnAvo87ZleV+kQ==
X-Received: by 10.98.60.14 with SMTP id j14mr4223879pfa.234.1507159688265;
        Wed, 04 Oct 2017 16:28:08 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d12sm14438153pfl.140.2017.10.04.16.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:28:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
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
Subject: [PATCH 12/13] kthread: Convert callback to use from_timer()
Date:   Wed,  4 Oct 2017 16:27:06 -0700
Message-Id: <1507159627-127660-13-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60268
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
to all timer callbacks, switch kthread to use from_timer() and pass the
timer pointer explicitly.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kthread.h | 10 +++++-----
 kernel/kthread.c        | 10 ++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 0d622b350d3f..35cbe3b0ce5b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -75,7 +75,7 @@ extern int tsk_fork_get_node(struct task_struct *tsk);
  */
 struct kthread_work;
 typedef void (*kthread_work_func_t)(struct kthread_work *work);
-void kthread_delayed_work_timer_fn(unsigned long __data);
+void kthread_delayed_work_timer_fn(struct timer_list *t);
 
 enum {
 	KTW_FREEZABLE		= 1 << 0,	/* freeze during suspend */
@@ -116,8 +116,8 @@ struct kthread_delayed_work {
 
 #define KTHREAD_DELAYED_WORK_INIT(dwork, fn) {				\
 	.work = KTHREAD_WORK_INIT((dwork).work, (fn)),			\
-	.timer = __TIMER_INITIALIZER(kthread_delayed_work_timer_fn,	\
-				     (unsigned long)&(dwork),		\
+	.timer = __TIMER_INITIALIZER((TIMER_FUNC_TYPE)kthread_delayed_work_timer_fn,\
+				     (TIMER_DATA_TYPE)&(dwork.timer),	\
 				     TIMER_IRQSAFE),			\
 	}
 
@@ -164,8 +164,8 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 	do {								\
 		kthread_init_work(&(dwork)->work, (fn));		\
 		__setup_timer(&(dwork)->timer,				\
-			      kthread_delayed_work_timer_fn,		\
-			      (unsigned long)(dwork),			\
+			      (TIMER_FUNC_TYPE)kthread_delayed_work_timer_fn,\
+			      (TIMER_DATA_TYPE)&(dwork)->timer,		\
 			      TIMER_IRQSAFE);				\
 	} while (0)
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1c19edf82427..ba3992c8c375 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -798,15 +798,14 @@ EXPORT_SYMBOL_GPL(kthread_queue_work);
 /**
  * kthread_delayed_work_timer_fn - callback that queues the associated kthread
  *	delayed work when the timer expires.
- * @__data: pointer to the data associated with the timer
+ * @t: pointer to the expired timer
  *
  * The format of the function is defined by struct timer_list.
  * It should have been called from irqsafe timer with irq already off.
  */
-void kthread_delayed_work_timer_fn(unsigned long __data)
+void kthread_delayed_work_timer_fn(struct timer_list *t)
 {
-	struct kthread_delayed_work *dwork =
-		(struct kthread_delayed_work *)__data;
+	struct kthread_delayed_work *dwork = from_timer(dwork, t, timer);
 	struct kthread_work *work = &dwork->work;
 	struct kthread_worker *worker = work->worker;
 
@@ -837,8 +836,7 @@ void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn ||
-		     timer->data != (unsigned long)dwork);
+	WARN_ON_ONCE(timer->function != (TIMER_FUNC_TYPE)kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
2.7.4
