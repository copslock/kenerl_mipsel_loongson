Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2011 09:24:38 +0200 (CEST)
Received: from gandharva.secretlabs.de ([78.46.147.237]:26895 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491116Ab1HJHYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Aug 2011 09:24:34 +0200
Received: from [172.31.14.96] (unknown [222.128.194.2])
        by gandharva.secretlabs.de (Postfix) with ESMTPSA id A7C9C1B10C0F
        for <linux-mips@linux-mips.org>; Wed, 10 Aug 2011 07:35:29 +0000 (UTC)
Message-ID: <4E423228.2080309@freyther.de>
Date:   Wed, 10 Aug 2011 09:24:24 +0200
From:   Holger Hans Peter Freyther <holger@freyther.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [RFC][PATCH] Implement perf_callchain_user for o32 ABI (on mipsel)
X-Enigmail-Version: 1.1.1
Content-Type: multipart/mixed;
 boundary="------------060009060802060709030201"
X-archive-position: 30844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: holger@freyther.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7227

This is a multi-part message in MIME format.
--------------060009060802060709030201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I wanted to use perf to profile my userspace application on MIPS but I saw
that there is no solution for that. I have written some code to scan the
prologue of the function to identify the stack size and where in the stack the
return address is stored.

   0:	27bdffd8 	addiu	sp,sp,-40 <-- used to find prev. stack
   4:	afbf0024 	sw	ra,36(sp) <-- stored return addr.
   8:	afbe0020 	sw	s8,32(sp)
   c:	03a0f021 	move	s8,sp
  10:	3c1c0000 	lui	gp,0x0
  14:	279c0000 	addiu	gp,gp,0

The code appears to work in qemu-system-mipsel (not where I am going to do my
profiling) with my simple test application.

The code is missing a S-o-b because I would like to get feedback if something
like this would ever be accepted upstream. The other question is also about
security, other ABIs, 32/64 bit...

comments more than welcome
	holger

--------------060009060802060709030201
Content-Type: text/x-patch;
 name="0001-mips-Implement-perf_callchain_user-by-scanning-the-p.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mips-Implement-perf_callchain_user-by-scanning-the-p.pa";
 filename*1="tch"

>From 7a8b1fcf942dbbd1bebbf41facdc77c0d9552811 Mon Sep 17 00:00:00 2001
From: Holger Hans Peter Freyther <zecke@selfish.org>
Date: Wed, 10 Aug 2011 08:56:59 +0200
Subject: [PATCH] mips: Implement perf_callchain_user by scanning the prologue

Scan the prologue for two instructions. The first one is adjusting
the stack pointer for the current frame, the next one is storing
the return address to the stack. Try to find both of these
instructions to identify the caller of this function. It might be
that the RA has not been written yet, in that case we will use the
address from pt_regs.

For all other frames try to find the two instructions again, exit
when accessing the text or stack is failing, or too many
instructions have been searched.

http://elinux.org/images/6/68/ELC2008_-_Back-tracing_in_MIPS-based_Linux_Systems.pdf
has helped to understand the prologue and was used in userspace
for the first attempts.
---
 arch/mips/kernel/perf_event.c |   93 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index a824485..623d63a 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -536,12 +536,105 @@ handle_associated_event(struct cpu_hw_events *cpuc,
 /* Callchain handling code. */
 
 /*
+ * Userspace code
+ */
+
+/*
  * Leave userspace callchain empty for now. When we find a way to trace
  * the user stack callchains, we add here.
  */
 void perf_callchain_user(struct perf_callchain_entry *entry,
 		    struct pt_regs *regs)
 {
+#define ADDIU_SP_INSTR		0x27bd0000
+#define SW_RA_INSTR		0xafbf0000
+	/*
+	 * Find the first RA and FrameSize.
+	 */
+	unsigned long ra_addr = regs->regs[31];
+	unsigned long sp_addr = regs->regs[29];
+	unsigned long pc_addr = regs->cp0_epc;
+	unsigned long ra = 0;
+	unsigned int limit;
+	size_t stack_size = 0;
+	size_t ra_offset = 0;
+
+	/*
+	 * Try to find the initial stack size and the return address. It
+	 * is possible that the code is still in the prologue and the
+	 * return address might not have been stored to the stack yet
+	 */
+	for (limit = 0, pc_addr = regs->cp0_epc;
+	     limit < (PAGE_SIZE / 4) && (!ra_offset || !stack_size);
+	     --pc_addr, ++limit) {
+		int instr;
+		if (!access_ok(VERIFY_READ, pc_addr, sizeof(instr)))
+			return;
+		if (__copy_from_user_inatomic(&instr, (void *) pc_addr, sizeof(instr)))
+			return;
+		switch (instr & 0xffff0000) {
+		case ADDIU_SP_INSTR:
+			stack_size = abs((short)(instr & 0xffff));
+			goto __out_of_loop;
+			break;
+		case SW_RA_INSTR:
+			ra_offset = instr & 0xffff;
+			break;
+		}
+	}
+
+__out_of_loop:
+	if (stack_size == 0)
+		return;
+
+	if (ra_offset) {
+		ra_addr = sp_addr + ra_offset;
+		if (!access_ok(VERIFY_READ, ra_addr, sizeof(ra)))
+			return;
+		if (__copy_from_user_inatomic(&ra, (void *) ra_addr, sizeof(ra)))
+			return;
+	}
+
+	sp_addr = sp_addr + stack_size;
+
+
+	/* now try to walk from the return address we found */
+	limit = 0;
+	while (entry->nr < PERF_MAX_STACK_DEPTH && ra != 0) {
+		perf_callchain_store(entry, ra);
+		ra_offset = stack_size = 0;
+
+		for (pc_addr = ra;
+		     (!ra_offset || !stack_size) && limit < PAGE_SIZE/4/2;
+		     --pc_addr, ++limit) {
+			int instr;
+			if (!access_ok(VERIFY_READ, pc_addr, sizeof(instr)))
+				return;
+			if (__copy_from_user_inatomic(&instr, (void *) pc_addr, sizeof(instr)))
+				return;
+			switch (instr & 0xffff0000) {
+			case ADDIU_SP_INSTR:
+				stack_size = abs((short)(instr & 0xffff));
+				break;
+			case SW_RA_INSTR:
+				ra_offset = instr & 0xffff;
+				break;
+			}
+		}
+
+		/* must have hit a limit */
+		if (!ra_offset || !stack_size)
+			return;
+
+		ra_addr = sp_addr + ra_offset;
+		if (!access_ok(VERIFY_READ, ra_addr, sizeof(ra)))
+			return;
+		if (__copy_from_user_inatomic(&ra, (void *) ra_addr, sizeof(ra)))
+			return;
+		sp_addr = sp_addr + stack_size;
+	}
+
+	return;
 }
 
 static void save_raw_perf_callchain(struct perf_callchain_entry *entry,
-- 
1.7.4.1


--------------060009060802060709030201--
