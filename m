Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 02:23:03 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:58031 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492856AbZFQAW4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 02:22:56 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5H0LfF8006482
	for <linux-mips@linux-mips.org>; Tue, 16 Jun 2009 17:21:41 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5H0LfXH006481
	for linux-mips@linux-mips.org; Tue, 16 Jun 2009 17:21:41 -0700
Date:	Tue, 16 Jun 2009 17:21:41 -0700
From:	tanderson@mvista.com
To:	linux-mips@linux-mips.org
Subject: PREEMPT BUG: using smp_processor_id() in preemptible
Message-ID: <20090617002141.GA6469@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf,

We saw the using smp_processor_id() in preemptible and thought
this my be a good correction.


--- arch/mips/include/asm/r4kcache.h_org	2009-06-09 22:25:19.000000000 +0400
+++ arch/mips/include/asm/r4kcache.h	2009-06-10 01:08:03.000000000 +0400
@@ -344,14 +344,17 @@
 static inline void blast_##pfx##cache##lsize(void)			\
 {									\
 	unsigned long start = INDEX_BASE;				\
-	unsigned long end = start + current_cpu_data.desc.waysize;	\
-	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
-	unsigned long ws_end = current_cpu_data.desc.ways <<		\
-	                       current_cpu_data.desc.waybit;		\
-	unsigned long ws, addr;						\
+	unsigned long end, ws_inc, ws_end, ws, addr;			\
 									\
 	__##pfx##flush_prologue						\
 									\
+	preempt_disable();						\
+	end = start + current_cpu_data.desc.waysize;			\
+	ws_inc = 1UL << current_cpu_data.desc.waybit;			\
+	ws_end = current_cpu_data.desc.ways <<				\
+			current_cpu_data.desc.waybit;			\
+	preempt_enable();						\
+									\
 	for (ws = 0; ws < ws_end; ws += ws_inc)				\
 		for (addr = start; addr < end; addr += lsize * 32)	\
 			cache##lsize##_unroll32(addr|ws, indexop);	\
@@ -376,16 +379,19 @@
 									\
 static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
 {									\
-	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
-	unsigned long start = INDEX_BASE + (page & indexmask);		\
-	unsigned long end = start + PAGE_SIZE;				\
-	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
-	unsigned long ws_end = current_cpu_data.desc.ways <<		\
-	                       current_cpu_data.desc.waybit;		\
-	unsigned long ws, addr;						\
+	unsigned long indexmask, ws_inc, ws_end, ws, addr, start, end;	\
 									\
 	__##pfx##flush_prologue						\
 									\
+	preempt_disable();						\
+	indexmask = current_cpu_data.desc.waysize - 1;			\
+	start = INDEX_BASE + (page & indexmask);			\
+	end = start + PAGE_SIZE;					\
+	ws_inc = 1UL << current_cpu_data.desc.waybit;			\
+	ws_end = current_cpu_data.desc.ways <<				\
+			current_cpu_data.desc.waybit;			\
+	preempt_enable();						\
+									\
 	for (ws = 0; ws < ws_end; ws += ws_inc)				\
 		for (addr = start; addr < end; addr += lsize * 32)	\
 			cache##lsize##_unroll32(addr|ws, indexop);	\
