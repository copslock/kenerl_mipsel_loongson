Received:  by oss.sgi.com id <S42267AbQISFxg>;
	Mon, 18 Sep 2000 22:53:36 -0700
Received: from fwgate.toshiba-tops.co.jp ([202.230.225.20]:43273 "HELO
        fwgate.toshiba-tops.co.jp") by oss.sgi.com with SMTP
	id <S42234AbQISFxX>; Mon, 18 Sep 2000 22:53:23 -0700
Received: from [172.16.4.3] by fwgate.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.190]) with SMTP; 19 Sep 2000 05:53:21 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (8.9.3/3.7W-MailExchenger) with ESMTP id OAA55237;
	Tue, 19 Sep 2000 14:52:09 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id OAA42998; Tue, 19 Sep 2000 14:52:09 +0900 (JST)
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: FPU context management problem
From:   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 1.94.1 on Emacs 20.5 / Mule 4.0 (HANANOEN)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000919145207Q.nemoto@toshiba-tops.co.jp>
Date:   Tue, 19 Sep 2000 14:52:07 +0900
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm running kernel 2.2.14 (based on linux-2.2.14-000715.tar.gz) and
found a floating point calculation sometimes results an incorrect
value.

I think the problem is last 'if' statement in setup_sigcontext().

	owned_fp = (current == last_task_used_math);
	err |= __put_user(owned_fp, &sc->sc_ownedfp);

	if (current->used_math) {	/* fp is active.  */
		set_cp0_status(ST0_CU1, ST0_CU1);
		err |= save_fp_context(sc);
		last_task_used_math = NULL;
		regs->cp0_status &= ~ST0_CU1;
		current->used_math = 0;
	}

This code can discard other task's FPU context in certain situations.
The scenario is:

(-2) Task_A executes FP insns.
(-1) Task_B executes FP insns.
(0) Task_C executes FP insns.
# save Task_B's FPU context.
# init Task_C's FPU context.
(1) Context switch (Task_C to Task_A).
(2) Task_A catch a signal.
    setup_sigcontext() and restore_sigcontext() is called.
# Task_A's used_math was 1 and owned_fp was 0,
# so last_task_used_math becomes NULL.
(3) Context switch (Task_A to Task_B).
(4) Task_B executes FP insns.
# restore Task_B's FPU context. (discard Task_C's FPU context)
(5) Context switch (Task_B to Task_C).
(6) Task_C execute FP insns.  (with Task_B's FPU context!)


I modified the 'if' statement as follows and the problem seems to be
fixed.

	if (owned_fp) {	/* fp is active.  */
		...
	}

Is this the right fix?

---
Atsushi Nemoto
