Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 12:04:51 +0200 (CEST)
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:25290 "EHLO
	ms-smtp-02.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133832AbWEQKDT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 May 2006 12:03:19 +0200
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-02.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id k4HA1RkD006693;
	Wed, 17 May 2006 06:01:27 -0400 (EDT)
Date:	Wed, 17 May 2006 06:01:26 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	LKML <linux-kernel@vger.kernel.org>
cc:	Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@samba.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, benedict.gaster@superh.com,
	lethal@linux-sh.org, Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@tensilica.com>,
	Joe Taylor <joe@tensilica.com>,
	David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
	spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, grundler@parisc-linux.org,
	parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
	kenneth.w.chen@intel.com, sam@ravnborg.org, clameter@sgi.com,
	kiran@scalex86.org
Subject: [RFC PATCH 08/09] robust VM per_cpu i386 header
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170601090.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

This patch adds the __ARCH_HAS_VM_PERCPU to i386 and defines
the PERCPU_START macro.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/include/asm-i386/percpu.h
===================================================================
--- linux-2.6.16-test.orig/include/asm-i386/percpu.h	2006-05-17 04:32:27.000000000 -0400
+++ linux-2.6.16-test/include/asm-i386/percpu.h	2006-05-17 05:00:00.000000000 -0400
@@ -1,6 +1,16 @@
 #ifndef __ARCH_I386_PERCPU__
 #define __ARCH_I386_PERCPU__

+#ifdef CONFIG_HAS_VM_PERCPU
+#define  __ARCH_HAS_VM_PERCPU
+#include <asm/fixmap.h>
+
+/*
+ * Virtual address space for the percpu area.
+ */
+#define PERCPU_START (__fix_to_virt(FIX_PERCPU_END))
+#endif /* CONFIG_HAS_VM_PERCPU */
+
 #include <asm-generic/percpu.h>

 #endif /* __ARCH_I386_PERCPU__ */
