Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Apr 2016 05:48:00 +0200 (CEST)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36520 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006513AbcDWDr6nCS09 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Apr 2016 05:47:58 +0200
Received: by mail-pf0-f171.google.com with SMTP id c189so3124713pfb.3
        for <linux-mips@linux-mips.org>; Fri, 22 Apr 2016 20:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O7PAd1hOrL6Z1DpfYdDUCxDjTouW1Bw+s49eUnolFwE=;
        b=sQGtsdinYRBT4VGphAWwDtlTygbujmnrsizotEiV6tRvkbbw7dK8tOeQSfn4zxqUEd
         BOZarAOUYEP6VWI3gCBiJ4/QuxzqikiRTdxFVzKFt4LaNJx59TBp4znUCThtXOioA0b6
         8HXRyeGFVtdbXvMdvcMR0rL73x0jBn0ScBLeTuqAp/UKLVJ4+1Xu3lQOUVtZ35V60Gzm
         yHXi2CoAUofnBoAkl+v1+XSo1xGW6xIMD72zZctBXLu1WiJZ9adpwtNWMBkQVan+XL99
         RpQRPtcYh1rvyQxC8QBwdr//FWA/Dxw5bPZ+olz2VIGOQo75saXvaIRATuBzEbDrDO0j
         AvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O7PAd1hOrL6Z1DpfYdDUCxDjTouW1Bw+s49eUnolFwE=;
        b=Io4v9UdCS/5+/Cd2eYpVxmMD5ZRtNh7a7KLsF5Nqs9if8cvTWS4resvHMr3u9PJkh5
         LodA84DwyktognVziNyfpDTrs5DaOxtXLS8CgTdjiTD1sMXzyaZp26FH6YArm5auqbyh
         xte7LHylJwnmfE/tjTemTUcOc5L0dc8m/DiGSr/0Eo0fobUuf3Oac1JJF3xJVijN3fsC
         //yBBNRXsZx+P7hOYvzvT6FndCiv6Rii4GYtiBCZVGH7XmxpbVOUC6W20FKJAhzzriCa
         PNjdZ85ApXHoP8IiCS/uaPITvsohYICOGYR7SfD+2nzUiZUBhYmpS4IG3+ddvw7Pdyas
         FM3w==
X-Gm-Message-State: AOPr4FXnaYkDfMh78h742w0xss4MdB6R2kj2T0DbwMvflD/1L4cD0nEjVaHRpxRZsUHW/g==
X-Received: by 10.98.64.132 with SMTP id f4mr33712158pfd.146.1461383272594;
        Fri, 22 Apr 2016 20:47:52 -0700 (PDT)
Received: from localhost ([110.70.15.194])
        by smtp.gmail.com with ESMTPSA id qb1sm12586397pac.44.2016.04.22.20.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 20:47:51 -0700 (PDT)
Date:   Sat, 23 Apr 2016 12:49:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160423034924.GA535@swordfish>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461239325-22779-5-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergey.senozhatsky.work@gmail.com
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

Hello Petr,

On (04/21/16 13:48), Petr Mladek wrote:
>  extern void printk_nmi_flush(void);
> +extern void printk_nmi_flush_on_panic(void);
>  #else
>  static inline void printk_nmi_flush(void) { }
> +static inline void printk_nmi_flush_on_panic(void) { }
[..]
> +void printk_nmi_flush_on_panic(void)
> +{
> +	/*
> +	 * Make sure that we could access the main ring buffer.
> +	 * Do not risk a double release when more CPUs are up.
> +	 */
> +	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
> +		if (num_online_cpus() > 1)
> +			return;
> +
> +		debug_locks_off();
> +		raw_spin_lock_init(&logbuf_lock);
> +	}
> +
> +	printk_nmi_flush();
> +}
[..]
> -static DEFINE_RAW_SPINLOCK(logbuf_lock);
> +DEFINE_RAW_SPINLOCK(logbuf_lock);

just an idea,

how about doing it a bit differently?


move printk_nmi_flush_on_panic() to printk.c, and place it next to
printk_flush_on_panic() (so we will have two printk "flush-on-panic"
functions sitting together). /* printk_nmi_flush() is in printk.h,
so it's visible to printk anyway */

it also will let us keep logbuf_lock static, it's a bit too internal
to printk to expose it, I think.


IOW, something like this?

---

 kernel/printk/internal.h |  2 --
 kernel/printk/nmi.c      | 27 ---------------------------
 kernel/printk/printk.c   | 29 ++++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7fd2838..341bedc 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -22,8 +22,6 @@ int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
 
 #ifdef CONFIG_PRINTK_NMI
 
-extern raw_spinlock_t logbuf_lock;
-
 /*
  * printk() could not take logbuf_lock in NMI context. Instead,
  * it temporary stores the strings into a per-CPU buffer.
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index b69eb8a..b68a9864 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -204,33 +204,6 @@ void printk_nmi_flush(void)
 		__printk_nmi_flush(&per_cpu(nmi_print_seq, cpu).work);
 }
 
-/**
- * printk_nmi_flush_on_panic - flush all per-cpu nmi buffers when the system
- *	goes down.
- *
- * Similar to printk_nmi_flush() but it can be called even in NMI context when
- * the system goes down. It does the best effort to get NMI messages into
- * the main ring buffer.
- *
- * Note that it could try harder when there is only one CPU online.
- */
-void printk_nmi_flush_on_panic(void)
-{
-	/*
-	 * Make sure that we could access the main ring buffer.
-	 * Do not risk a double release when more CPUs are up.
-	 */
-	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
-
-		debug_locks_off();
-		raw_spin_lock_init(&logbuf_lock);
-	}
-
-	printk_nmi_flush();
-}
-
 void __init printk_nmi_init(void)
 {
 	int cpu;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0a0e789..1509baa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -245,7 +245,7 @@ __packed __aligned(4)
  * within the scheduler's rq lock. It must be released before calling
  * console_unlock() or anything else that might wake up a process.
  */
-DEFINE_RAW_SPINLOCK(logbuf_lock);
+static DEFINE_RAW_SPINLOCK(logbuf_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -2447,6 +2447,33 @@ void console_unblank(void)
 }
 
 /**
+ * printk_nmi_flush_on_panic - flush all per-cpu nmi buffers when the system
+ *	goes down.
+ *
+ * Similar to printk_nmi_flush() but it can be called even in NMI context when
+ * the system goes down. It does the best effort to get NMI messages into
+ * the main ring buffer.
+ *
+ * Note that it could try harder when there is only one CPU online.
+ */
+void printk_nmi_flush_on_panic(void)
+{
+	/*
+	 * Make sure that we could access the main ring buffer.
+	 * Do not risk a double release when more CPUs are up.
+	 */
+	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
+		if (num_online_cpus() > 1)
+			return;
+
+		debug_locks_off();
+		raw_spin_lock_init(&logbuf_lock);
+	}
+
+	printk_nmi_flush();
+}
+
+/**
  * console_flush_on_panic - flush console content on panic
  *
  * Immediately output all pending messages no matter what.
