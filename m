Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GIJGi03769
	for linux-mips-outgoing; Thu, 16 Aug 2001 11:19:16 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GIJBj03765
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 11:19:11 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA04168
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 11:19:00 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA24514
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 11:19:04 -0700 (PDT)
Message-ID: <018201c12680$8f13e680$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
Date: Thu, 16 Aug 2001 20:23:32 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_017F_01C12691.51701D60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_017F_01C12691.51701D60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

As I wrote last night, it looks to me as if FPU context
management in signals was broken in all versions and
proposed patches that I've seen.  The way I see it is this:

If the current thread "owns" the FPU, we need to save the
FPU state in the sigcontext and restore it on return.  If
the signal handler uses floating point, it already has the
FPU, and can do what it wants with it.  If it doesn't use
the FPU, then we'll save and restore FPU state for
nothing, but better safe than sorry.  In either case,
the current thread retains ownership of the FPU.
There is no reason to muck with the ownership data
or the Cp0.Status.CU1 enables, apart from the
questionable bit of enabling it before the FP context
save in case it wasn't enabled.  I think that should go
away, but I don't have time to test exhastively.  In
any case, CU1 should have it's pre-signal state
going into the signal handler.

If the current thread does *not* own the FPU, we don't
need to save the thread FP state. If the signal handler
does no FP, so much the better, there's nothing to
be done.   If the signal handler uses FP, it will acquire 
the FPU by normal means. The FP context will be saved 
into the thread context of the previous owner, the signalling 
thread will acquire the FPU, and the signal handler will do 
it's FP. On return from the signal, we *must* de-allocate the
FPU and clear the CU1 bit.  If that's done, and the
thread (which had not *owned* the FPU prior to the
signal) starts doing FP again, normal mechanisms
will cause it's FP context to be restored.  If we don't,
it will start exectuing with a bogus FP context.

The code I sketched last night is essentially correct,
though it used a macro that doesn't exist.  I attach a
patch relative to the current OSS repository's signal.c.
The patch includes the stack frame tweak for the FPU
emulator that was part of previous patches, but which
is orthogonal to the problem under discussion.  I have
built a kernel using this code and run 20 simultaneous
copies of the MontaVista "stressor" program with no
problems (though I also had the "v1.5" FPU emulator
code).

            Regards,

            Kevin K. 

------=_NextPart_000_017F_01C12691.51701D60
Content-Type: application/octet-stream;
	name="signal.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="signal.c.patch"

Index: signal.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/linux/arch/mips/kernel/signal.c,v=0A=
retrieving revision 1.36=0A=
diff -u -p -r1.36 signal.c=0A=
--- signal.c	2001/06/18 22:43:35	1.36=0A=
+++ signal.c	2001/08/16 18:01:58=0A=
@@ -221,7 +221,13 @@ restore_sigcontext(struct pt_regs *regs,=0A=
 	err |=3D __get_user(owned_fp, &sc->sc_ownedfp);=0A=
 	if (owned_fp) {=0A=
 		err |=3D restore_fp_context(sc);=0A=
-		last_task_used_math =3D current;=0A=
+	} else {=0A=
+		if (current =3D=3D last_task_used_math) {=0A=
+		/* Signal handler acquired FPU - give it back */=0A=
+			last_task_used_math =3D NULL;=0A=
+			current->used_math =3D 0;=0A=
+			regs->cp0_status &=3D ~ST0_CU1;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	return err;=0A=
@@ -326,6 +332,7 @@ setup_sigcontext(struct pt_regs *regs, s=0A=
 	int owned_fp;=0A=
 	int err =3D 0;=0A=
 	u64 reg;=0A=
+	u32 tstat;=0A=
 =0A=
 	err |=3D __put_user(regs->cp0_epc, &sc->sc_pc);=0A=
 	err |=3D __put_user(regs->cp0_status, &sc->sc_status);=0A=
@@ -353,12 +360,12 @@ setup_sigcontext(struct pt_regs *regs, s=0A=
 	owned_fp =3D (current =3D=3D last_task_used_math);=0A=
 	err |=3D __put_user(owned_fp, &sc->sc_ownedfp);=0A=
 =0A=
-	if (current->used_math) {	/* fp is active.  */=0A=
+	if (owned_fp) {	/* fp is active.  */=0A=
+		tstat =3D regs->cp0_status;=0A=
+		/* This enable should not really be necessary */=0A=
 		set_cp0_status(ST0_CU1);=0A=
 		err |=3D save_fp_context(sc);=0A=
-		last_task_used_math =3D NULL;=0A=
-		regs->cp0_status &=3D ~ST0_CU1;=0A=
-		current->used_math =3D 0;=0A=
+		regs->cp0_status =3D tstat;=0A=
 	}=0A=
 =0A=
 	return err;=0A=
@@ -374,6 +381,16 @@ get_sigframe(struct k_sigaction *ka, str=0A=
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

------=_NextPart_000_017F_01C12691.51701D60--
