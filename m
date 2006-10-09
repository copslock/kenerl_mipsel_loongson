Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 11:37:39 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:31194 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20037824AbWJIKhf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 11:37:35 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k99Ab2vn008798;
	Mon, 9 Oct 2006 03:37:02 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k99AbNne004800;
	Mon, 9 Oct 2006 03:37:24 -0700 (PDT)
Message-ID: <00f301c6eb8f$cd4b4270$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kevin D. Kissell" <KevinK@mips.com>, <linux-mips@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<ralf@linux-mips.org>
References: <20061009.012423.59032950.anemo@mba.ocn.ne.jp> <006501c6eb07$4fbf66c0$8003a8c0@Ulysses>
Subject: Re: [PATCH] ret_from_irq adjustment
Date:	Mon, 9 Oct 2006 12:43:46 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00F0_01C6EBA0.8FA9EA50"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00F0_01C6EBA0.8FA9EA50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I attach a text file (inline cut-and-paste produces Windows whitespace
which apparently is unacceptable) of a patch which (a) implements the
ret_from_irq optimization that Atsushi wanted to do to the SMTC code, 
only without breaking it.  I also reorganized and re-commented the code to
be easier to maintain in the future, and in an unrelated matter (b) fixes
a bug in arch/mips/kernel/smtc.c when there are 64 or more TLB
entry pairs on a 34K core.  This TLB patch has been in the internal
MIPS repository forever, but for some reason has never made it
out onto linux-mips.org.

The resulting kernel boots and runs (with a 64-entry TLB).

Note that these patches are relative to the 2.6.17 semi-stable
tree, and not the latest hackfest, so the renaming of ret_from_irq
to _ret_from_irq had not been done, and is not reflected in the patch.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Kevin D. Kissell" <KevinK@mips.com>
To: <linux-mips@linux-mips.org>; "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc: <ralf@linux-mips.org>
Sent: Sunday, October 08, 2006 8:26 PM
Subject: Re: [PATCH] ret_from_irq adjustment


> While setting up ra "by hand" and transferring control via the jr
> is a reasonable optimization, you're otherwise breaking things for SMTC.
> While the comments are misleading (they accurately described an earlier
> version of the code), the function being called here is ipi_decode(), which
>  needs a pt_regs * in the first argument (hence the copy of the sp), and 
> the pointer to the IPI message descriptor in the second.
> 
> Do you have access to a 34K to test changes to SMTC?  I'd have
> expected this one to have been pretty quickly fatal.
> 
>             Regards,
> 
>             Kevin K.
> 
> > diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
> > index 76cb31d..1cb9441 100644
> > --- a/arch/mips/kernel/smtc-asm.S
> > +++ b/arch/mips/kernel/smtc-asm.S
> > @@ -97,15 +97,12 @@ FEXPORT(__smtc_ipi_vector)
> >   SAVE_ALL
> >   CLI
> >   TRACE_IRQS_OFF
> > - move a0,sp
> >   /* Function to be invoked passed stack pad slot 5 */
> >   lw t0,PT_PADSLOT5(sp)
> >   /* Argument from sender passed in stack pad slot 4 */
> > - lw a1,PT_PADSLOT4(sp)
> > - jalr t0
> > - nop
> > - j ret_from_irq
> > - nop
> > + lw a0,PT_PADSLOT4(sp)
> > + PTR_LA ra, _ret_from_irq
> > + jr t0
> >  
> >  /*
> >   * Called from idle loop to provoke processing of queued IPIs
> > 
> > 
> 
> 
------=_NextPart_000_00F0_01C6EBA0.8FA9EA50
Content-Type: application/octet-stream;
	name="smtcpatch.gitdiff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="smtcpatch.gitdiff"

diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S=0A=
index 72c6d98..a1709de 100644=0A=
--- a/arch/mips/kernel/smtc-asm.S=0A=
+++ b/arch/mips/kernel/smtc-asm.S=0A=
@@ -96,15 +96,14 @@ FEXPORT(__smtc_ipi_vector)=0A=
 	/* Save all will redundantly recompute the SP, but use it for now */=0A=
 	SAVE_ALL=0A=
 	CLI=0A=
-	move	a0,sp=0A=
 	/* Function to be invoked passed stack pad slot 5 */=0A=
 	lw	t0,PT_PADSLOT5(sp)=0A=
-	/* Argument from sender passed in stack pad slot 4 */=0A=
+	/* First argument is pointer to pt_regs on kernel stack */=0A=
+	move	a0,sp=0A=
+	/* Additional argument from sender passed in stack pad slot 4 */=0A=
 	lw	a1,PT_PADSLOT4(sp)=0A=
-	jalr	t0=0A=
-	nop=0A=
-	j	ret_from_irq=0A=
-	nop=0A=
+	PTR_LA	ra,ret_from_irq=0A=
+	jr	t0=0A=
 =0A=
 /*=0A=
  * Called from idle loop to provoke processing of queued IPIs=0A=
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c=0A=
index 2e8e52c..1657d15 100644=0A=
--- a/arch/mips/kernel/smtc.c=0A=
+++ b/arch/mips/kernel/smtc.c=0A=
@@ -269,7 +269,8 @@ void smtc_configure_tlb(void)=0A=
 		 * of their initialization in smtc_cpu_setup().=0A=
 		 */=0A=
 =0A=
-		tlbsiz =3D tlbsiz & 0x3f;	/* MIPS32 limits TLB indices to 64 */=0A=
+		/* MIPS32 limits TLB indices to 64 */=0A=
+		if (tlbsiz > 64) tlbsiz =3D 64;=0A=
 		cpu_data[0].tlbsize =3D tlbsiz;=0A=
 		smtc_status |=3D SMTC_TLB_SHARED;=0A=
 =0A=

------=_NextPart_000_00F0_01C6EBA0.8FA9EA50--
