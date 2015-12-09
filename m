Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:22:46 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:56189 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013548AbbLINVhvyhFA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Dec 2015 14:21:37 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FACEAD74;
        Wed,  9 Dec 2015 13:21:37 +0000 (UTC)
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
Subject: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Date:   Wed,  9 Dec 2015 14:21:05 +0100
Message-Id: <1449667265-17525-5-git-send-email-pmladek@suse.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1449667265-17525-1-git-send-email-pmladek@suse.com>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50466
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

Testing has shown that the backtrace sometimes does not fit
into the 4kB temporary buffer that is used in NMI context.
The warnings are gone when I double the temporary buffer size.

This patch doubles the buffer size and makes it configurable.

Note that this problem existed even in the x86-specific
implementation that was added by the commit a9edc8809328
("x86/nmi: Perform a safe NMI stack trace on all CPUs").
Nobody noticed it because it did not print any warnings.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 init/Kconfig        | 22 ++++++++++++++++++++++
 kernel/printk/nmi.c |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index c1c0b6a2d712..efcff25a112d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU
 
+config NMI_LOG_BUF_SHIFT
+	int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
+	range 10 21
+	default 13
+	depends on PRINTK && HAVE_NMI
+	help
+	  Select the size of a per-CPU buffer where NMI messages are temporary
+	  stored. They are copied to the main log buffer in a safe context
+	  to avoid a deadlock. The value defines the size as a power of 2.
+
+	  NMI messages are rare and limited. The largest one is when
+	  a backtrace is printed. It usually fits into 4KB. Select
+	  8KB if you want to be on the safe side.
+
+	  Examples:
+		     17 => 128 KB for each CPU
+		     16 =>  64 KB for each CPU
+		     15 =>  32 KB for each CPU
+		     14 =>  16 KB for each CPU
+		     13 =>   8 KB for each CPU
+		     12 =>   4 KB for each CPU
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 5465230b75ec..78c07d441b4e 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -41,7 +41,8 @@ DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
 static int printk_nmi_irq_ready;
 atomic_t nmi_message_lost;
 
-#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
+#define NMI_LOG_BUF_LEN ((1 << CONFIG_NMI_LOG_BUF_SHIFT) -		\
+			 sizeof(atomic_t) - sizeof(struct irq_work))
 
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
-- 
1.8.5.6
