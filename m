Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 12:02:37 +0200 (CEST)
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19872 "EHLO
	ms-smtp-01.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133516AbWEQKBo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 May 2006 12:01:44 +0200
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-01.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id k4H9wSgT010379;
	Wed, 17 May 2006 05:58:28 -0400 (EDT)
Date:	Wed, 17 May 2006 05:58:28 -0400 (EDT)
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
Subject: [RFC PATCH 04/09] robust VM per_cpu main startup
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170557580.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

This patch disables the generic setup if __ARCH_HAS_VM_PERCPU defined.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/init/main.c
===================================================================
--- linux-2.6.16-test.orig/init/main.c	2006-05-17 04:32:28.000000000 -0400
+++ linux-2.6.16-test/init/main.c	2006-05-17 04:57:45.000000000 -0400
@@ -324,7 +324,7 @@ static inline void smp_prepare_cpus(unsi

 #else

-#ifdef __GENERIC_PER_CPU
+#if defined(__GENERIC_PER_CPU) && !defined(__ARCH_HAS_VM_PERCPU)
 unsigned long __per_cpu_offset[NR_CPUS];

 EXPORT_SYMBOL(__per_cpu_offset);
