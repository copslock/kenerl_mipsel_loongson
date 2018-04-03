Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 13:41:14 +0200 (CEST)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39538
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993588AbeDCLlDYZ8iq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 13:41:03 +0200
Received: by mail-pl0-x242.google.com with SMTP id s24-v6so8389178plq.6
        for <linux-mips@linux-mips.org>; Tue, 03 Apr 2018 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=i77eHd51yuhESTtdLWsVkbKiOJjLo4b0fil/6fcDHxc=;
        b=IRfP46+Rwg1tb7RkMHj5yG8JVL9lGlJLDZrW8gq0EmfUfdKKPIg9e+5Tb3oBAvZHF6
         nwo6ztYRMevEt5UM+eOLkQnGJaVm+9KjbG66SDTiHmnqi6yPfSBJMgjszTVt/4u+lDNU
         wPGk1PomME/eEWwp2WBhQ2wwVCmXTKdZj2CcHE6GA020OF5NREsNrD72sF/tCfv9zwCG
         9G2AcXJbfTkaVUME2EfJqsKr+6z48i/QdQky6WMssW2XZfJ4Jz14kLvyh9+LsKp8h+Bg
         57A/iz0Itn8muKlwTnsS1/dyZNsHDE1wun+CvLlJUyrp0ChaSTbw+1+3Xd4F9ZRtZ1aq
         fWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i77eHd51yuhESTtdLWsVkbKiOJjLo4b0fil/6fcDHxc=;
        b=KuL4KHHBCITRwGhaenmBnGjU7zu+vF0+dZaXOseqEpvb9kwr2torHee3gImfy3t2iO
         wXbmyg4lvOH6+T4Pt+z85umdkJduZrLEfjmVA/Xe9FLYzKAko+eHjXBtMtNa1IBORbJU
         ZQjbFBnGWljYmHyt8yTvc5C8+UvHJsV+6+WqXp/kQuWCLGksCR/VWUAsiidmdilSu1AH
         L+9frxul+TCFPI6FFg/s1vE6Tn9Mv+PuhZvF+ZhtYeil5h8qaS6C0D7/1jLx/nH+t8Re
         Pb6Rwrl5bCrYKHG5+cSeuAA7xc59A4mN4u8zn1mSVpwYwT000NVy8Vr1an3+kOFH5k4V
         jIhw==
X-Gm-Message-State: AElRT7EjXmXur7awQh1PRowQfiNxpiT+wJI1NOKW1WWrP6waUStjmB4c
        4wr0rewafyBFXcQFO4tWp4WCPDfYUQY=
X-Google-Smtp-Source: AIpwx49tIFIJRtfQ5dLHwsmdxchhAJIKkzRoT62BQD2OroYi86NtR95Y7127Z9irDVrLPl3alxlOMQ==
X-Received: by 10.101.69.1 with SMTP id n1mr9013115pgq.12.1522755656727;
        Tue, 03 Apr 2018 04:40:56 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id k7sm4244310pgt.41.2018.04.03.04.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 04:40:54 -0700 (PDT)
From:   r@hev.cc
To:     linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org
Cc:     Heiher <r@hev.cc>
Subject: [PATCH v2] MIPS: Avoid to cause watchpoint exception in kernel mode
Date:   Tue,  3 Apr 2018 19:40:38 +0800
Message-Id: <20180403114038.10646-1-r@hev.cc>
X-Mailer: git-send-email 2.16.3
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r@hev.cc
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

From: Heiher <r@hev.cc>

I found an operation can trigger a kernel hang, when we write an user-space
address to hardward watchpoints before access this address in kernel mode.

Looks the problem is the current thread can't return to user mode because memory
accesses blocked by hardward watchpoints. so SIGTRAP not handled and the debugger
can't receive watchpoints event.

Execution flow:
1. write address to cp0 watchpoints.
2. access this address in kernel mode, then an exception triggered by watchpoints.
3. goto do_watch() to handle exception.
4. Force a SIGTRAP to current thread.
5. exception return, goto step 2.

If we clear the watchpoints in do_watch() for exceptions from kernel mode,
and re-install watchpoints on thread return to user mode, it'll works fine.

Test case:
	#include <stdio.h>
	#include <unistd.h>
	#include <signal.h>

	int
	main (int argc, char *argv[])
	{
		char buf[16];

		printf ("%p\n", buf);
		raise (SIGINT);

		write (1, buf, 16);

		return 0;
	}

	# gcc -O0 -o t t.c
	# gdb ./t
	(gdb) r
	(gdb) watch *<printed buf address>
	(gdb) c

Signed-off-by: Heiher <r@hev.cc>
---
 arch/mips/kernel/entry.S | 23 +++++++++++++++++++++++
 arch/mips/kernel/traps.c |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 38a302919e6b..6094844fc63f 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -49,6 +49,13 @@ resume_userspace:
 					# interrupt setting need_resched
 					# between sampling and return
 	LONG_L	a2, TI_FLAGS($28)	# current->work
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2
+	beqz	t0, 1f
+	move	a0, $28
+	jal	mips_install_watch_registers
+	LONG_L	a2, TI_FLAGS($28)	# current->work
+1:
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
 	bnez	t0, work_pending
 	j	restore_all
@@ -82,7 +89,15 @@ FEXPORT(syscall_exit)
 	local_irq_disable		# make sure need_resched and
 					# signals dont change between
 					# sampling and return
+
+	LONG_L	a2, TI_FLAGS($28)	# current->work
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2
+	beqz	t0, 1f
+	move	a0, $28
+	jal	mips_install_watch_registers
 	LONG_L	a2, TI_FLAGS($28)	# current->work
+1:
 	li	t0, _TIF_ALLWORK_MASK
 	and	t0, a2, t0
 	bnez	t0, syscall_exit_work
@@ -143,7 +158,15 @@ work_notifysig:				# deal with pending signals and
 FEXPORT(syscall_exit_partial)
 	local_irq_disable		# make sure need_resched doesn't
 					# change between and return
+
+	LONG_L	a2, TI_FLAGS($28)	# current->work
+	li	t0, _TIF_LOAD_WATCH
+	and	t0, a2
+	beqz	t0, 1f
+	move	a0, $28
+	jal	mips_install_watch_registers
 	LONG_L	a2, TI_FLAGS($28)	# current->work
+1:
 	li	t0, _TIF_ALLWORK_MASK
 	and	t0, a2
 	beqz	t0, restore_partial
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 967e9e4e795e..22f671263b27 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1525,7 +1525,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	 * their values and send SIGTRAP.  Otherwise another thread
 	 * left the registers set, clear them and continue.
 	 */
-	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
+	if (user_mode(regs) && test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
 		force_sig_info(SIGTRAP, &info, current);
-- 
2.16.3
