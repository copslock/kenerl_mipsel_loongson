Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 09:51:00 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:44137 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491169Ab0E3Hud (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 30 May 2010 09:50:33 +0200
Received: (qmail 19877 invoked from network); 30 May 2010 07:50:30 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 May 2010 07:50:30 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sun, 30 May 2010 00:50:30 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Date:   Sun, 30 May 2010 00:35:58 -0700
Subject: [PATCH 2/2] MIPS: Fix deferred console messages during CPU hotplug
Message-Id: <526fcbfa605500d9da9b04ac0f93ef2beddca6ed@localhost.localdomain>
In-Reply-To: <1b31306f28573a4bee56f164b1f74962fced9bc5@localhost.localdomain>
References: <1b31306f28573a4bee56f164b1f74962fced9bc5@localhost.localdomain>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

When a secondary CPU is booting up in start_secondary(), cpu_probe() and
calibrate_delay() are called while cpu_online(smp_processor_id()) == 0.
This means that can_use_console() will return 0 on many systems:

static inline int can_use_console(unsigned int cpu)
{
	return cpu_online(cpu) || have_callable_console();
}

If (can_use_console() == 0), printk() will spool its output to log_buf
and it will be visible in "dmesg", but that output will NOT be echoed to
the console until somebody calls release_console_sem() from a CPU that
is online.  Effectively this means that the cpu_probe() and
calibrate_delay() messages will sit in limbo, and will only get dumped
to the screen the next time printk() happens to get called.

At boot time, more printk() messages are invariably generated after SMP
initialization as the kernel boot proceeds, so this problem is unlikely
to be noticed.  But when using the CPU hotplug feature to reactivate a
dormant processor, the new CPU's boot messages could be stuck in limbo
for quite a while since nothing is necessarily printed to the kernel log
afterward.

The proposed workaround is to acquire and release console_sem from
__cpu_up(), so any queued messages can be flushed out to the console by
a CPU that is definitely known to be online.

This issue was seen on 2.6.34.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/smp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 6cdca19..bf8923f 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
+#include <linux/console.h>
 
 #include <asm/atomic.h>
 #include <asm/cpu.h>
@@ -219,6 +220,10 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	cpu_set(cpu, cpu_online_map);
 
+	/* Flush out any buffered log messages from the new CPU */
+	if (try_acquire_console_sem() == 0)
+		release_console_sem();
+
 	return 0;
 }
 
-- 
1.7.0.4
