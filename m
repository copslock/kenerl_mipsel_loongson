Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBK24WE15764
	for linux-mips-outgoing; Wed, 19 Dec 2001 18:04:32 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBK24HX15761
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 18:04:17 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBK144B28212;
	Wed, 19 Dec 2001 17:04:04 -0800
Message-ID: <3C21390A.FA23978D@mvista.com>
Date: Wed, 19 Dec 2001 17:04:10 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: an old FPU context corruption problem when signal happens
Content-Type: multipart/mixed;
 boundary="------------2D908E10DCEF328FE6FC7F90"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------2D908E10DCEF328FE6FC7F90
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is an incomplete patch, attempting to fix an old fix FPU context
corruption problem with signal happens.

The following scenario would cause many problems with current code:

1. process A runs and uses FPU
2. Process A is switched out; Process B runs and uses FPU
3. Process A runs again, but have not used FPU this time around
4. Process A receives a signal.
5. Process A's signal handler runs and uses FPU
6. Process B runs again and uses FPU.

At step 4, we have last_task_used_fpu being B, current->used_math being 1.
The current code would save B's FPU context to A's sc structure, but
does not mark owned_fp bits.

At step 5, when A's sig handler first time uses FPU, FPU is enabled again.

At step 6, when B tries to use FPU again, a lazy fpu switch happens.  The
current FPU regs are stored into A's thread strucutre, effectively eraseing
previously stored A's FPU context before the sig handler starts.

In addition, B finds its FPU reg values totally bogus when they are loaded
from B's thread structure, because the FPU regs were saved there.  (See
step 4).

This patch is meant for concept debugging.  But it should be easy
to complete it:

1. support the two copy_fpu_context function.  (note, need to differentiate
between CPU_HAS_FPU and !CPU_HAS_FPU cases)
2. perhaps change ->sc_ownedfp to ->sc_used_fpu, which is really what
this flag means now.

Any comments?

Jun
--------------2D908E10DCEF328FE6FC7F90
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


This is an incomplete patch, attempting to fix an old fix FPU context 
corruption problem with signal happens.

The following scenario would cause many problems with current code:

1. process A runs and uses FPU
2. Process A is switched out; Process B runs and uses FPU
3. Process A runs again, but have not used FPU this time around
4. Process A receives a signal.
5. Process A's signal handler runs and uses FPU
6. Process B runs again and uses FPU.

At step 4, we have last_task_used_fpu being B, current->used_math being 1.
The current code would save B's FPU context to A's sc structure, but 
does not mark owned_fp bits.

At step 5, when A's sig handler first time uses FPU, FPU is enabled again.

At step 6, when B tries to use FPU again, a lazy fpu switch happens.  The
current FPU regs are stored into A's thread strucutre, effectively eraseing
previously stored A's FPU context before the sig handler starts.

In addition, B finds its FPU reg values totally bogus when they are loaded
from B's thread structure, because the FPU regs were saved there.  (See
step 4).

This patch is meant for concept debugging.  But it should be easy
to complete it:

1. support the two copy_fpu_context function.  (note, need to differentiate
between CPU_HAS_FPU and !CPU_HAS_FPU cases)
2. perhaps change ->sc_ownedfp to ->sc_used_fpu, which is really what
this flag means now.

Any comments?

Jun


diff -Nru linux.link/arch/mips/kernel/signal.c.orig linux.link/arch/mips/kernel/signal.c
--- linux.link/arch/mips/kernel/signal.c.orig	Tue Nov 27 11:03:02 2001
+++ linux.link/arch/mips/kernel/signal.c	Wed Dec 19 16:28:08 2001
@@ -222,8 +222,20 @@
 
 	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		last_task_used_math = current;
+		if ((last_task_used_match == NULL) || (last_task_used_math == current)) {
+			/* if nobody owns FPU, or sig handler owns it,
+			 * we just restore FPU regs from sc to hardware */
+			err |= restore_fp_context(sc);
+			last_task_used_math = current;
+			enable_fpu();
+		} else {
+			/* we copy FPU values from sc to task structure */
+			err |= copy_fpu_context_from_sigcontext(current, sc);
+			disable_fpu();
+		}
+
+		/* in either case, we need to set the used flag */
+		current->used_math = 1;
 	}
 
 	return err;
@@ -352,13 +364,25 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = (current == last_task_used_math);
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
+	/* if we ever used FPU, we need to get FPU regs to sc */
+	if (current->used_math) {
+
+		if (current == last_task_used_math) {
+			/* if we own FPU now, just save fpu to sc directly */
+			enable_fpu();
+			err |= save_fp_context(sc);
+		} else {
+			/* otherwise, we need copy fpu regs from current task
+			 * structure to sc structre.
+			 */
+			err |= copy_fpu_context_to_sigcontext(current, sc);
+		}
+
+		/* put remember that we have valid FPU regs in sc */
+		err |= __put_user(current->used_math, &sc->sc_ownedfp);
 
-	if (current->used_math) {	/* fp is active.  */
-		enable_fpu();
-		err |= save_fp_context(sc);
-		last_task_used_math = NULL;
+		/* we now pretend we have never used FPU before we start sig
+		 * handler */
 		regs->cp0_status &= ~ST0_CU1;
 		current->used_math = 0;
 	}

--------------2D908E10DCEF328FE6FC7F90--
