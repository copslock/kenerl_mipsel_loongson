Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7QMi3j07996
	for linux-mips-outgoing; Sun, 26 Aug 2001 15:44:03 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7QMhwd07992
	for <linux-mips@oss.sgi.com>; Sun, 26 Aug 2001 15:43:59 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA02272;
	Sun, 26 Aug 2001 15:43:51 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA21401;
	Sun, 26 Aug 2001 15:43:49 -0700 (PDT)
Message-ID: <005801c12e81$37cc9da0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>
Cc: <linux-mips@oss.sgi.com>
References: <00b701c1275f$0c38a5e0$0deca8c0@Ulysses> <20010821.123113.25481933.nemoto@toshiba-tops.co.jp>
Subject: Re: FP handling in signal.c and traps.c
Date: Mon, 27 Aug 2001 00:48:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >>>>> On Fri, 17 Aug 2001 22:56:02 +0200, "Kevin D. Kissell"
<kevink@mips.com> said:
> kevink> I attach a diff relative to the current OSS repository for a
> kevink> proposed patch to fix the signal holes discussed over the past
> kevink> few days.
>
> Thanks for your patch.  I tried this patch and it seems to work fine,
> but I think still there is a hole in it.
>
> After patching it, codes in restore_sigcontext becomes:
>
> if (owned_fp) {
> /* Can't tell if signal handler used FP, must restore */
> err |= restore_fp_context(sc);
> } else {
> if (current == last_task_used_math) {
> /* Signal handler acquired FPU - give it back */
> last_task_used_math = NULL;
> regs->cp0_status &= ~ST0_CU1;
> if (current->used_math) {
> /* Undo possible contamination of thread state */
> restore_thread_fp_context(sc);
> }
> }
> }
>
> But this should be:
>
> if (owned_fp) {
> /* Can't tell if signal handler used FP, must restore */
> err |= restore_fp_context(sc);
> } else {
> if (current == last_task_used_math) {
> /* Signal handler acquired FPU - give it back */
> last_task_used_math = NULL;
> regs->cp0_status &= ~ST0_CU1;
> }
> if (current->used_math) {
> /* Undo possible contamination of thread state */
> restore_thread_fp_context(sc);
> }
> }
>
> This change fix a hole in case that:
>
> - The signaled thread used the FPU but not owns it.
> - and context switch occur in the signal handler.
> - and other thread takes the FPU (the signal handler loses the FPU).
>
> In this case, last_task_used_math is not current at
> restore_sigcontext, but we must restore the saved fp context.

I believe you are correct.  The
"if(current->used_math)restore_thread_fp_context(sc)"
should be moved out one level of conditional.  I had hoped
to avoid some needless thread context restores, but it really
does need to be symmetric with the setup_sigcontext code.

            Kevin K.
