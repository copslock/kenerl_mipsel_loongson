Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 12:11:15 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:47624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011291AbbK0LJyGE8G2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2015 12:09:54 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F710AD87;
        Fri, 27 Nov 2015 11:08:14 +0000 (UTC)
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
Subject: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary buffer
Date:   Fri, 27 Nov 2015 12:09:32 +0100
Message-Id: <1448622572-16900-6-git-send-email-pmladek@suse.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1448622572-16900-1-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50150
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

Note that this problem existed even in the x86-specific
implementation that was added by the commit a9edc8809328
("x86/nmi: Perform a safe NMI stack trace on all CPUs").
Nobody noticed it because it did not print any warnings.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 8af1e4016719..6111644d5f01 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
 	struct irq_work		work;	/* IRQ work that flushes the buffer */
-	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
+	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
 				       sizeof(struct irq_work)];
 };
 static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
-- 
1.8.5.6
