Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HKpuO12529
	for linux-mips-outgoing; Fri, 17 Aug 2001 13:51:56 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HKpoj12526
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 13:51:50 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA17656
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 13:51:42 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA24823
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 13:51:39 -0700 (PDT)
Message-ID: <00b701c1275f$0c38a5e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: FP handling in signal.c and traps.c (was Re: FP Emulator Patch)
Date: Fri, 17 Aug 2001 22:56:02 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B4_01C1276F.CA0590A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_00B4_01C1276F.CA0590A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I attach a diff relative to the current OSS repository for a proposed
patch to fix the signal holes discussed over the past few days.
This *exact* patch has not been tested, since the sources are too
new to be compatible with any kernel that will read my accursed
hard drive, so you are taking your life in your hands with it, but
it is substantially similar to the version I posted yesterday that
worked perfectly - but had the conceptual hole if a signal
handler that acquired the FPU got switched out.   I've got
a plane to catch in the morning and can't spend any more
time on it, but it should at least give people something to
talk about - and something similar to it really should be
(IMHO) the correct approach.  It will slow down the signal
dispatch, without a doubt, but we should stop losing FP
state altogether.  I also fixed what looked to be a bug
in the handling of Hi and Lo in the sigcontext restore.
The code as written would certainly have worked in
big-endian code, but I believe that in little endian it could
have trashed both registers.

A note to Jun Sun about clearing the used_math flag
before launching a signal handler: consider what happens
to ptrace if the signal handler hits a breakpoint without
executing any FP instructions.  My code saves and
restores it with the sigcontext.  If the signal handler
acquires the FPU, but the application has not otherwise
used FP, it will be cleared as part of that restore.

I pass the torch, and hope for the best...

            Regards,

            Kevin K.


------=_NextPart_000_00B4_01C1276F.CA0590A0
Content-Type: application/octet-stream;
	name="cvsdiff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cvsdiff"

? cvsdiff=0A=
? arch/mips/kernel/signal.c.diff=0A=
Index: arch/mips/kernel/signal.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/kernel/signal.c,v=0A=
retrieving revision 1.36=0A=
diff -u -p -r1.36 signal.c=0A=
--- arch/mips/kernel/signal.c	2001/06/18 22:43:35	1.36=0A=
+++ arch/mips/kernel/signal.c	2001/08/17 20:22:55=0A=
@@ -187,6 +187,47 @@ sys_sigaltstack(struct pt_regs regs)=0A=
 	return do_sigaltstack(uss, uoss, usp);=0A=
 }=0A=
 =0A=
+static void=0A=
+restore_thread_fp_context(struct sigcontext *sc)=0A=
+{=0A=
+	int i;=0A=
+	/* Note: This assumes that fpu.soft/fpu.hard union is isomorphic */	=0A=
+	u64 *pfreg =3D &current->thread.fpu.soft.regs[0];=0A=
+=0A=
+	/* =0A=
+	 * Copy all 32 64-bit values, for two reasons.=0A=
+	 * First, the R3000 and R4000/MIPS32 kernels use=0A=
+	 * the thread FP register storage differently,=0A=
+	 * such that a full copy is essentially necessary=0A=
+	 * to support both.  Someone obsessed with performance =0A=
+	 * could turn this into distinct routines in each=0A=
+	 * of the _fpu.S files.=0A=
+	 * =0A=
+	 */=0A=
+=0A=
+	for (i =3D 0; i < 32; i++ ) {=0A=
+		__get_user(pfreg[i], &sc->sc_fpregs[i]);=0A=
+	}=0A=
+	__get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);=0A=
+}=0A=
+=0A=
+static void=0A=
+save_thread_fp_context(struct sigcontext *sc)=0A=
+{=0A=
+	int i;=0A=
+	/* Note: This assumes that fpu.soft/fpu.hard union is isomorphic */	=0A=
+	u64 *pfreg =3D &current->thread.fpu.soft.regs[0];=0A=
+=0A=
+	/* =0A=
+	 * See comment in restore_thread_fp_context()=0A=
+	 */=0A=
+=0A=
+	for (i =3D 0; i < 32; i++ ) {=0A=
+		__put_user(pfreg[i], &sc->sc_fpregs[i]);=0A=
+	}=0A=
+	__put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);=0A=
+}=0A=
+=0A=
 asmlinkage int=0A=
 restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)=0A=
 {=0A=
@@ -196,10 +237,8 @@ restore_sigcontext(struct pt_regs *regs,=0A=
 =0A=
 	err |=3D __get_user(regs->cp0_epc, &sc->sc_pc);=0A=
 =0A=
-	err |=3D __get_user(reg, &sc->sc_mdhi);=0A=
-	regs->hi =3D (int) reg;=0A=
-	err |=3D __get_user(reg, &sc->sc_mdlo);=0A=
-	regs->lo =3D (int) reg;=0A=
+	err |=3D __get_user(regs->hi, &sc->sc_mdhi);=0A=
+	err |=3D __get_user(regs->lo, &sc->sc_mdlo);=0A=
 =0A=
 #define restore_gp_reg(i) do {						\=0A=
 	err |=3D __get_user(reg, &sc->sc_regs[i]);			\=0A=
@@ -219,9 +258,20 @@ restore_sigcontext(struct pt_regs *regs,=0A=
 #undef restore_gp_reg=0A=
 =0A=
 	err |=3D __get_user(owned_fp, &sc->sc_ownedfp);=0A=
+	err |=3D __get_user(current->used_math, &sc->sc_used_math);=0A=
 	if (owned_fp) {=0A=
+		/* Can't tell if signal handler used FP, must restore */=0A=
 		err |=3D restore_fp_context(sc);=0A=
-		last_task_used_math =3D current;=0A=
+	} else {=0A=
+		if (current =3D=3D last_task_used_math) {=0A=
+		/* Signal handler acquired FPU - give it back */=0A=
+			last_task_used_math =3D NULL;=0A=
+			regs->cp0_status &=3D ~ST0_CU1;=0A=
+			if (current->used_math) {=0A=
+			/* Undo possible contamination of thread state */=0A=
+				restore_thread_fp_context(sc);=0A=
+			}=0A=
+		}=0A=
 	}=0A=
 =0A=
 	return err;=0A=
@@ -352,13 +402,20 @@ setup_sigcontext(struct pt_regs *regs, s=0A=
 =0A=
 	owned_fp =3D (current =3D=3D last_task_used_math);=0A=
 	err |=3D __put_user(owned_fp, &sc->sc_ownedfp);=0A=
+	err |=3D __put_user(current->used_math, &sc->sc_used_math);=0A=
 =0A=
-	if (current->used_math) {	/* fp is active.  */=0A=
-		set_cp0_status(ST0_CU1);=0A=
-		err |=3D save_fp_context(sc);=0A=
-		last_task_used_math =3D NULL;=0A=
-		regs->cp0_status &=3D ~ST0_CU1;=0A=
-		current->used_math =3D 0;=0A=
+	if (current->used_math) {=0A=
+	/* There exists FP thread state that may be trashed by signal */=0A=
+		if (owned_fp) {	=0A=
+		/* fp is active.  Save context from FPU */=0A=
+			err |=3D save_fp_context(sc);=0A=
+		} else {=0A=
+		/* =0A=
+		 * Someone else has FPU. =0A=
+		 * Copy Thread context into signal context =0A=
+		 */=0A=
+			save_thread_fp_context(sc);=0A=
+		}=0A=
 	}=0A=
 =0A=
 	return err;=0A=
@@ -374,6 +431,16 @@ get_sigframe(struct k_sigaction *ka, str=0A=
 =0A=
 	/* Default to using normal stack */=0A=
 	sp =3D regs->regs[29];=0A=
+=0A=
+#ifdef CONFIG_MIPS_FPU_EMULATOR=0A=
+	/*=0A=
+	 * FPU emulator may have it's own trampoline active just=0A=
+	 * above the user stack, 16-bytes before the next lowest=0A=
+	 * 16 byte boundary.  Try to avoid trashing it.=0A=
+	 */=0A=
+	sp -=3D 32;	/* 32 ought to be enough, but... */=0A=
+=0A=
+#endif /* CONFIG_MIPS_FPU_EMULATOR */=0A=
 =0A=
 	/* This is the X/Open sanctioned signal stack switching.  */=0A=
 	if ((ka->sa.sa_flags & SA_ONSTACK) && ! on_sig_stack(sp))=0A=
Index: arch/mips/kernel/traps.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/kernel/traps.c,v=0A=
retrieving revision 1.75=0A=
diff -u -p -r1.75 traps.c=0A=
--- arch/mips/kernel/traps.c	2001/08/02 21:58:46	1.75=0A=
+++ arch/mips/kernel/traps.c	2001/08/17 20:22:58=0A=
@@ -574,6 +574,7 @@ asmlinkage void do_cpu(struct pt_regs *r=0A=
 {=0A=
 	unsigned int cpid;=0A=
 	extern void lazy_fpu_switch(void *);=0A=
+	extern void save_fp(struct task_struct *);=0A=
 	extern void init_fpu(void);=0A=
 	void fpu_emulator_init_fpu(void);=0A=
 	int sig;=0A=
@@ -592,6 +593,7 @@ asmlinkage void do_cpu(struct pt_regs *r=0A=
 	if (current->used_math) {		/* Using the FPU again.  */=0A=
 		lazy_fpu_switch(last_task_used_math);=0A=
 	} else {				/* First time FPU user.  */=0A=
+		if (last_task_used_math !=3D NULL) save_fp(last_task_used_math);=0A=
 		init_fpu();=0A=
 		current->used_math =3D 1;=0A=
 	}=0A=
Index: include/asm-mips/sigcontext.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/include/asm-mips/sigcontext.h,v=0A=
retrieving revision 1.6=0A=
diff -u -p -r1.6 sigcontext.h=0A=
--- include/asm-mips/sigcontext.h	2000/03/27 23:02:57	1.6=0A=
+++ include/asm-mips/sigcontext.h	2001/08/17 20:23:00=0A=
@@ -18,10 +18,11 @@ struct sigcontext {=0A=
 	unsigned int       sc_status;=0A=
 	unsigned long long sc_pc;=0A=
 	unsigned long long sc_regs[32];=0A=
-	unsigned long long sc_fpregs[32];	/* Unused */=0A=
+	unsigned long long sc_fpregs[32];=0A=
 	unsigned int       sc_ownedfp;=0A=
-	unsigned int       sc_fpc_csr;		/* Unused */=0A=
+	unsigned int       sc_fpc_csr;=0A=
 	unsigned int       sc_fpc_eir;		/* Unused */=0A=
+	unsigned int       sc_used_math;=0A=
 	unsigned int       sc_ssflags;		/* Unused */=0A=
 	unsigned long long sc_mdhi;=0A=
 	unsigned long long sc_mdlo;=0A=

------=_NextPart_000_00B4_01C1276F.CA0590A0--
