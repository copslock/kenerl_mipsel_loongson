Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7L3Qjc06446
	for linux-mips-outgoing; Mon, 20 Aug 2001 20:26:45 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7L3Qf906442
	for <linux-mips@oss.sgi.com>; Mon, 20 Aug 2001 20:26:41 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Aug 2001 03:26:41 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 21E4D54C0E; Tue, 21 Aug 2001 12:26:39 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA83905; Tue, 21 Aug 2001 12:26:38 +0900 (JST)
Date: Tue, 21 Aug 2001 12:31:13 +0900 (JST)
Message-Id: <20010821.123113.25481933.nemoto@toshiba-tops.co.jp>
To: kevink@mips.com
Cc: linux-mips@oss.sgi.com
Subject: Re: FP handling in signal.c and traps.c
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <00b701c1275f$0c38a5e0$0deca8c0@Ulysses>
References: <00b701c1275f$0c38a5e0$0deca8c0@Ulysses>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Fri, 17 Aug 2001 22:56:02 +0200, "Kevin D. Kissell" <kevink@mips.com> said:
kevink> I attach a diff relative to the current OSS repository for a
kevink> proposed patch to fix the signal holes discussed over the past
kevink> few days.

Thanks for your patch.  I tried this patch and it seems to work fine,
but I think still there is a hole in it.

After patching it, codes in restore_sigcontext becomes:

	if (owned_fp) {
		/* Can't tell if signal handler used FP, must restore */
		err |= restore_fp_context(sc);
	} else {
		if (current == last_task_used_math) {
		/* Signal handler acquired FPU - give it back */
			last_task_used_math = NULL;
			regs->cp0_status &= ~ST0_CU1;
			if (current->used_math) {
			/* Undo possible contamination of thread state */
				restore_thread_fp_context(sc);
			}
		}
	}

But this should be:

	if (owned_fp) {
		/* Can't tell if signal handler used FP, must restore */
		err |= restore_fp_context(sc);
	} else {
		if (current == last_task_used_math) {
		/* Signal handler acquired FPU - give it back */
			last_task_used_math = NULL;
			regs->cp0_status &= ~ST0_CU1;
		}
		if (current->used_math) {
			/* Undo possible contamination of thread state */
			restore_thread_fp_context(sc);
		}
	}

This change fix a hole in case that:

- The signaled thread used the FPU but not owns it.
- and context switch occur in the signal handler.
- and other thread takes the FPU (the signal handler loses the FPU).

In this case, last_task_used_math is not current at
restore_sigcontext, but we must restore the saved fp context.

---
Atsushi Nemoto
