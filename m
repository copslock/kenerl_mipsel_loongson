Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2002 00:16:40 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:41717 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1121743AbSJ1XQj>;
	Tue, 29 Oct 2002 00:16:39 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g9SNGTM09262;
	Mon, 28 Oct 2002 15:16:29 -0800
Date: Mon, 28 Oct 2002 15:16:28 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] typo in mmu_context.h
Message-ID: <20021028151628.E24266@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rather obviously ....

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru link/include/asm-mips/mmu_context.h.orig link/include/asm-mips/mmu_context.h
--- link/include/asm-mips/mmu_context.h.orig	Mon Oct 28 11:55:29 2002
+++ link/include/asm-mips/mmu_context.h	Mon Oct 28 13:34:49 2002
@@ -83,7 +83,7 @@
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 #ifdef CONFIG_SMP
-	mm->context = malloc(smp_num_cpus * sizeof(unsigned long), GFP_KERNEL);
+	mm->context = kmalloc(smp_num_cpus * sizeof(unsigned long), GFP_KERNEL);
 	/*
  	 * Init the "context" values so that a tlbpid allocation
 	 * happens on the first switch.

--tKW2IUtsqtDRztdT--
