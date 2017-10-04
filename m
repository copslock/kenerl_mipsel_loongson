Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:32:23 +0200 (CEST)
Received: from mail-pf0-x236.google.com ([IPv6:2607:f8b0:400e:c00::236]:48372
        "EHLO mail-pf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdJDX2MQcXAm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:12 +0200
Received: by mail-pf0-x236.google.com with SMTP id n24so7034862pfk.5
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ENoC6ceifCX0aOcJ/MBZnbVT7Ow+d6T0KoRqs154IpM=;
        b=RJDwzFvC3XzHNc1if9/OmmIMqzdICOA3f7GwHgVf/4e+nXu5ucgQQbhjJ3+5xRM9YN
         9r9AsRXA8B031z4hvBG+op089l3TPeHT23FLke4989GJEOcRM5klGEo18bzQRu8ZR1l1
         njihfsIgR9W5jX+sg5m2zgB2ooZaB7ruWCT7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ENoC6ceifCX0aOcJ/MBZnbVT7Ow+d6T0KoRqs154IpM=;
        b=A1sxIbOxsKPli+DByzfkG9yRxiNbf7iBN2SzLRQuDdyX+cB6KNHTcYcpeVM13XNigu
         3oOziwWfbId4Z9nWxc803yNzw/n5hwktIUw0vKodVzRkxp0Esgqtw5I25+mkI/J06hJy
         7vms3+ottv9+riU/waq5CvDPlzdb2MXvp2tRAw2D4MWH0DfEKg0Wxo3JM1Q6WJNUTj0K
         54Oqi7h4X0niXj6MFix/Gccu87wR1A3sQ3wFfSzEqOvqvobuVXWcw5fcunY4XhRur+RZ
         rLJr9AHr+up6XjZiwYit+i+aGIAKVDYl9tM+J8llzKUgoVWZVyVI9U+JBd2vkKgab+oe
         QXwA==
X-Gm-Message-State: AMCzsaWDk6uwm1M5plBoll4UMbbbmxFSvYSt0PeozwiJjWgcnLBvmFvR
        WsiCcrXjScxvbQVBnW6u2ZaJLw==
X-Google-Smtp-Source: AOwi7QBw9ZOREqnyQ2O07eO0nOhUfhqDxs0QNbBU/ONe8h2Q5tIoFc6n4flCDb43kQUxTAearc5LOg==
X-Received: by 10.84.217.13 with SMTP id o13mr9567439pli.280.1507159686263;
        Wed, 04 Oct 2017 16:28:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y63sm16443482pgd.3.2017.10.04.16.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:28:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
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
        Stephen Boyd <sboyd@codeaurora.org>,
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
Subject: [PATCH 11/13] timer: Remove expires argument from __TIMER_INITIALIZER()
Date:   Wed,  4 Oct 2017 16:27:05 -0700
Message-Id: <1507159627-127660-12-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60266
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

The expires field is normally initialized during the first mod_timer()
call. It was unused by all callers, so remove it from the macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kthread.h   | 2 +-
 include/linux/timer.h     | 5 ++---
 include/linux/workqueue.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 82e197eeac91..0d622b350d3f 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -117,7 +117,7 @@ struct kthread_delayed_work {
 #define KTHREAD_DELAYED_WORK_INIT(dwork, fn) {				\
 	.work = KTHREAD_WORK_INIT((dwork).work, (fn)),			\
 	.timer = __TIMER_INITIALIZER(kthread_delayed_work_timer_fn,	\
-				     0, (unsigned long)&(dwork),	\
+				     (unsigned long)&(dwork),		\
 				     TIMER_IRQSAFE),			\
 	}
 
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 91e5a2cc81b5..10685c33e679 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -63,10 +63,9 @@ struct timer_list {
 
 #define TIMER_TRACE_FLAGMASK	(TIMER_MIGRATING | TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
 
-#define __TIMER_INITIALIZER(_function, _expires, _data, _flags) { \
+#define __TIMER_INITIALIZER(_function, _data, _flags) {		\
 		.entry = { .next = TIMER_ENTRY_STATIC },	\
 		.function = (_function),			\
-		.expires = (_expires),				\
 		.data = (_data),				\
 		.flags = (_flags),				\
 		__TIMER_LOCKDEP_MAP_INITIALIZER(		\
@@ -75,7 +74,7 @@ struct timer_list {
 
 #define DEFINE_TIMER(_name, _function)				\
 	struct timer_list _name =				\
-		__TIMER_INITIALIZER(_function, 0, 0, 0)
+		__TIMER_INITIALIZER(_function, 0, 0)
 
 void init_timer_key(struct timer_list *timer, unsigned int flags,
 		    const char *name, struct lock_class_key *key);
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1c49431f3121..f4960260feaf 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -176,7 +176,7 @@ struct execute_work {
 #define __DELAYED_WORK_INITIALIZER(n, f, tflags) {			\
 	.work = __WORK_INITIALIZER((n).work, (f)),			\
 	.timer = __TIMER_INITIALIZER(delayed_work_timer_fn,		\
-				     0, (unsigned long)&(n),		\
+				     (unsigned long)&(n),		\
 				     (tflags) | TIMER_IRQSAFE),		\
 	}
 
-- 
2.7.4
