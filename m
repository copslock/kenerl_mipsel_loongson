Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 12:10:59 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:47601 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011441AbbK0LJwDKBN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2015 12:09:52 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E6F1AD86;
        Fri, 27 Nov 2015 11:08:12 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/5] printk/nmi: Warn when some message has been lost in NMI context
Date:   Fri, 27 Nov 2015 12:09:31 +0100
Message-Id: <1448622572-16900-5-git-send-email-pmladek@suse.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1448622572-16900-1-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

We could not resize the temporary buffer in NMI context. Let's warn
if a message is lost.

This is rather theoretical. printk() should not be used in NMI.
The only sensible use is when we want to print backtrace from all
CPUs. The current buffer should be enough for this purpose.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nmi.c    |  5 ++++-
 kernel/printk/printk.c | 10 ++++++++++
 kernel/printk/printk.h | 11 +++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 34ba760ae794..8af1e4016719 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -37,6 +37,7 @@
  */
 DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
 static int printk_nmi_irq_ready;
+atomic_t nmi_message_lost;
 
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
@@ -60,8 +61,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
 again:
 	len = atomic_read(&s->len);
 
-	if (len >=  sizeof(s->buffer))
+	if (len >=  sizeof(s->buffer)) {
+		atomic_inc(&nmi_message_lost);
 		return 0;
+	}
 
 	/*
 	 * Make sure that all old data have been read before the buffer was
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e970b623ae26..e924c6ac2e6d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1669,6 +1669,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	unsigned long flags;
 	int this_cpu;
 	int printed_len = 0;
+	int nmi_message_lost;
 	bool in_sched = false;
 	/* cpu currently holding logbuf_lock in this function */
 	static unsigned int logbuf_cpu = UINT_MAX;
@@ -1726,6 +1727,15 @@ asmlinkage int vprintk_emit(int facility, int level,
 					 strlen(recursion_msg));
 	}
 
+	nmi_message_lost = get_nmi_message_lost();
+	if (unlikely(nmi_message_lost)) {
+		text_len = scnprintf(textbuf, sizeof(textbuf),
+				     "BAD LUCK: lost %d message(s) from NMI context!",
+				     nmi_message_lost);
+		printed_len += log_store(0, 2, LOG_PREFIX|LOG_NEWLINE, 0,
+					 NULL, 0, textbuf, text_len);
+	}
+
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
diff --git a/kernel/printk/printk.h b/kernel/printk/printk.h
index 3492f5def4ef..834830c93aad 100644
--- a/kernel/printk/printk.h
+++ b/kernel/printk/printk.h
@@ -34,6 +34,12 @@ static inline __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 	return this_cpu_read(printk_func)(fmt, args);
 }
 
+extern atomic_t nmi_message_lost;
+static inline int get_nmi_message_lost(void)
+{
+	return atomic_xchg(&nmi_message_lost, 0);
+}
+
 #else /* CONFIG_PRINTK_NMI */
 
 static inline __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
@@ -41,4 +47,9 @@ static inline __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 	return vprintk_default(fmt, args);
 }
 
+static inline int get_nmi_message_lost(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_PRINTK_NMI */
-- 
1.8.5.6
