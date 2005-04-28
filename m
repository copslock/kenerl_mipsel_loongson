Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 15:03:47 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:15322
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225778AbVD1ODc>; Thu, 28 Apr 2005 15:03:32 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j3SE3MuN006477;
	Thu, 28 Apr 2005 07:03:22 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id j3SE3KQf011655;
	Thu, 28 Apr 2005 07:03:21 -0700 (PDT)
Message-ID: <002d01c54bfa$5b913f80$0deca8c0@Ulysses>
From:	"Kevin D. Kissell" <KevinK@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<linux-mips@linux-mips.org>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp> <20050428134118.GC1276@linux-mips.org>
Subject: Re: preempt safe fpu-emulator
Date:	Thu, 28 Apr 2005 06:58:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Scanned-By: MIMEDefang 2.39
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

When I first integrated the Algorithmics emulator with the Linux kernel
several years back, I tried doing something like this but ran into some
problem that I cannot recall exactly - there may have been some case
where the system expected threads to "inherit" FCSR changes.  I agree
that this is an obviously cleaner approach, but be careful.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Ralf Baechle" <ralf@linux-mips.org>
To: "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc: <linux-mips@linux-mips.org>
Sent: Thursday, April 28, 2005 6:41 AM
Subject: Re: preempt safe fpu-emulator


> On Wed, Apr 27, 2005 at 02:36:22PM +0900, Atsushi Nemoto wrote:
> 
> > Hi.  Here is a patch to make the fpu-emulator preempt-safe.  It would
> > be SMP-safe also.
> > 
> > The 'ieee754_csr' global variable is removed.  Now the 'ieee754_csr'
> > is an alias of current->thread.fpu.soft.fcr31.  While the fpu-emulator
> > uses different mapping for RM bits (FPU_CSR_Rm vs. IEEE754_Rm), RM
> > bits are converted before (and after) calling of cop1Emulate().  If we
> > adjusted IEEE754_Rm to match with FPU_CSR_Rm, we can remove ieee_rm[]
> > and mips_rm[].  Should we do it?
> > 
> > With this patch, whole fpu-emulator can be run without disabling
> > preempt.  I will post a patch to fix preemption issue soon.
> 
> I applied both your patches with some slight cleanup for the endianess
> stuff in arch/mips/math-emu/ieee754.h and non-Linux stuff.
> 
>   Ralf
> 
> 
