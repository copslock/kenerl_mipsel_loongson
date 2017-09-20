Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 06:48:02 +0200 (CEST)
Received: from omzsmtpe02.verizonbusiness.com ([199.249.25.209]:38490 "EHLO
        omzsmtpe02.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991599AbdITEqp7W7X9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Sep 2017 06:46:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882805; x=1537418805;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhzVB0oABY5tefuZtu3jUTzP9ynXGGPWZ7ltw3Qpvm0=;
  b=pZzx+1lKO0UEV5o3V8NPvIV/ub4IPigU50o2zeAB2h1YWOO1oI5WcCKW
   /BfczN4YOrthwiycYqTzCbN1N7EktX5OWg+4aWJLmH9Dpm58EyljmTAdT
   vkgCfa15h+bDu4u6LOutXu7HBLUy76SDl9DBQ3Iidt1gsSry0fSvV78VP
   s=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by omzsmtpe02.verizonbusiness.com with ESMTP; 20 Sep 2017 04:46:38 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Jason A . Donenfeld" <jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 04:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882757; x=1537418757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhzVB0oABY5tefuZtu3jUTzP9ynXGGPWZ7ltw3Qpvm0=;
  b=FO5gcqmlM5tu0mTGmjBpV3xVEp58BmhGSPuhOIs0jntoXX/HzGuKuYth
   8jlk4suL/KRWPVHblGbAEp2pJnA2YYhc7aPbkfJcw4CaR2P5hAcmfdRjr
   SyiWUCkg22J2B3zTVski+2enlbQYJv5Q8Nq7RtjL6zKJxYuaIdlPnSvSp
   0=;
Received: from ranger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.27])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 00:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882756; x=1537418756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhzVB0oABY5tefuZtu3jUTzP9ynXGGPWZ7ltw3Qpvm0=;
  b=tOCfb+tJ+Gf3sIIHC53ZRkK3rqlVuy01nqXygGhsQA402rhtypfTCgmw
   3uqUdo9NVCAzAwDZUmWPtzl8zfzpJzaZClGWSZAvyiwCURPFVrVCfJuaS
   pF+BAwKcK63J5vPuZt3WxDXRHuGhTq8mn38uTenetHWP1zyvTkeNxb8Kn
   A=;
X-Host: ranger.odc.vzwcorp.com
Received: from casac1exh003.uswin.ad.vzwcorp.com ([10.11.218.45])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 20 Sep 2017 04:45:55 +0000
Received: from scwexch11apd.uswin.ad.vzwcorp.com (153.114.130.30) by
 CASAC1EXH003.uswin.ad.vzwcorp.com (10.11.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Tue, 19 Sep 2017 21:45:54 -0700
Received: from OMZP1LUMXCA13.uswin.ad.vzwcorp.com (144.8.22.188) by
 scwexch11apd.uswin.ad.vzwcorp.com (153.114.130.30) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 21:45:53 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA13.uswin.ad.vzwcorp.com (144.8.22.188) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 23:45:52 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 23:45:52 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH review for 4.4 38/47] MIPS: IRQ Stack: Unwind IRQ stack onto
 task stack
Thread-Topic: [PATCH review for 4.4 38/47] MIPS: IRQ Stack: Unwind IRQ stack
 onto task stack
Thread-Index: AQHTMcs8hbAskbHnUUGqdcrOFbTqbg==
Date:   Wed, 20 Sep 2017 04:45:09 +0000
Message-ID: <20170920044445.7392-38-alexander.levin@verizon.com>
References: <20170920044445.7392-1-alexander.levin@verizon.com>
In-Reply-To: <20170920044445.7392-1-alexander.levin@verizon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@verizon.com
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

[ Upstream commit db8466c581cca1a08b505f1319c3ecd246f16fa8 ]

When the separate IRQ stack was introduced, stack unwinding only
proceeded as far as the top of the IRQ stack, leading to kernel
backtraces being less useful, lacking the trace of what was interrupted.

Fix this by providing a means for the kernel to unwind the IRQ stack
onto the interrupted task stack. The processor state is saved to the
kernel task stack on interrupt. The IRQ_STACK_START macro reserves an
unsigned long at the top of the IRQ stack where the interrupted task
stack pointer can be saved. After the active stack is switched to the
IRQ stack, save the interrupted tasks stack pointer to the reserved
location.

Fix the stack unwinding code to look for the frame being the top of the
IRQ stack and if so get the next frame from the saved location. The
existing test does not work with the separate stack since the ra is no
longer pointed at ret_from_{irq,exception}.

The test to stop unwinding the stack 32 bytes from the top of a stack
must be modified to allow unwinding to continue up to the location of
the saved task stack pointer when on the IRQ stack. The low / high marks
of the stack are set depending on whether the sp is on an irq stack or
not.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15788/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/include/asm/irq.h    | 15 +++++++++++
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/genex.S       |  8 ++++--
 arch/mips/kernel/process.c     | 56 ++++++++++++++++++++++++++++--------------
 4 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index ebb9efb02502..77edb22f855d 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -18,9 +18,24 @@
 #include <irq.h>
 
 #define IRQ_STACK_SIZE			THREAD_SIZE
+#define IRQ_STACK_START			(IRQ_STACK_SIZE - sizeof(unsigned long))
 
 extern void *irq_stack[NR_CPUS];
 
+/*
+ * The highest address on the IRQ stack contains a dummy frame put down in
+ * genex.S (handle_int & except_vec_vi_handler) which is structured as follows:
+ *
+ *   top ------------
+ *       | task sp  | <- irq_stack[cpu] + IRQ_STACK_START
+ *       ------------
+ *       |          | <- First frame of IRQ context
+ *       ------------
+ *
+ * task sp holds a copy of the task stack pointer where the struct pt_regs
+ * from exception entry can be found.
+ */
+
 static inline bool on_irq_stack(int cpu, unsigned long sp)
 {
 	unsigned long low = (unsigned long)irq_stack[cpu];
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ec053ce7bb38..7ab8004c1659 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ void output_thread_info_defines(void)
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
+	DEFINE(_IRQ_STACK_START, IRQ_STACK_START);
 	BLANK();
 }
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 619e30e2c4f0..bb72f3ce7e29 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -216,9 +216,11 @@ NESTED(handle_int, PT_SIZE, sp)
 	beq	t0, t1, 2f
 
 	/* Switch to IRQ stack */
-	li	t1, _IRQ_STACK_SIZE
+	li	t1, _IRQ_STACK_START
 	PTR_ADD sp, t0, t1
 
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S	s1, 0(sp)
 2:
 	jal	plat_irq_dispatch
 
@@ -326,9 +328,11 @@ NESTED(except_vec_vi_handler, 0, sp)
 	beq	t0, t1, 2f
 
 	/* Switch to IRQ stack */
-	li	t1, _IRQ_STACK_SIZE
+	li	t1, _IRQ_STACK_START
 	PTR_ADD sp, t0, t1
 
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S	s1, 0(sp)
 2:
 	jalr	v0
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8c26ecac930d..477ba026c3e5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -483,31 +483,52 @@ unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
 					      unsigned long pc,
 					      unsigned long *ra)
 {
+	unsigned long low, high, irq_stack_high;
 	struct mips_frame_info info;
 	unsigned long size, ofs;
+	struct pt_regs *regs;
 	int leaf;
-	extern void ret_from_irq(void);
-	extern void ret_from_exception(void);
 
 	if (!stack_page)
 		return 0;
 
 	/*
-	 * If we reached the bottom of interrupt context,
-	 * return saved pc in pt_regs.
+	 * IRQ stacks start at IRQ_STACK_START
+	 * task stacks at THREAD_SIZE - 32
 	 */
-	if (pc == (unsigned long)ret_from_irq ||
-	    pc == (unsigned long)ret_from_exception) {
-		struct pt_regs *regs;
-		if (*sp >= stack_page &&
-		    *sp + sizeof(*regs) <= stack_page + THREAD_SIZE - 32) {
-			regs = (struct pt_regs *)*sp;
-			pc = regs->cp0_epc;
-			if (!user_mode(regs) && __kernel_text_address(pc)) {
-				*sp = regs->regs[29];
-				*ra = regs->regs[31];
-				return pc;
-			}
+	low = stack_page;
+	if (!preemptible() && on_irq_stack(raw_smp_processor_id(), *sp)) {
+		high = stack_page + IRQ_STACK_START;
+		irq_stack_high = high;
+	} else {
+		high = stack_page + THREAD_SIZE - 32;
+		irq_stack_high = 0;
+	}
+
+	/*
+	 * If we reached the top of the interrupt stack, start unwinding
+	 * the interrupted task stack.
+	 */
+	if (unlikely(*sp == irq_stack_high)) {
+		unsigned long task_sp = *(unsigned long *)*sp;
+
+		/*
+		 * Check that the pointer saved in the IRQ stack head points to
+		 * something within the stack of the current task
+		 */
+		if (!object_is_on_stack((void *)task_sp))
+			return 0;
+
+		/*
+		 * Follow pointer to tasks kernel stack frame where interrupted
+		 * state was saved.
+		 */
+		regs = (struct pt_regs *)task_sp;
+		pc = regs->cp0_epc;
+		if (!user_mode(regs) && __kernel_text_address(pc)) {
+			*sp = regs->regs[29];
+			*ra = regs->regs[31];
+			return pc;
 		}
 		return 0;
 	}
@@ -528,8 +549,7 @@ unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
 	if (leaf < 0)
 		return 0;
 
-	if (*sp < stack_page ||
-	    *sp + info.frame_size > stack_page + THREAD_SIZE - 32)
+	if (*sp < low || *sp + info.frame_size > high)
 		return 0;
 
 	if (leaf)
-- 
2.11.0
