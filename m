Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 01:26:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63989 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225234AbTA2B0n>;
	Wed, 29 Jan 2003 01:26:43 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0T1QV028031;
	Tue, 28 Jan 2003 17:26:31 -0800
Date: Tue, 28 Jan 2003 17:26:31 -0800
From: Jun Sun <jsun@mvista.com>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH 2.5] FPU
Message-ID: <20030128172631.E11633@mvista.com>
References: <Pine.LNX.4.21.0301260251300.15950-100000@melkor> <20030127102929.N11633@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030127102929.N11633@mvista.com>; from jsun@mvista.com on Mon, Jan 27, 2003 at 10:29:29AM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Jan 27, 2003 at 10:29:29AM -0800, Jun Sun wrote:
> On Sun, Jan 26, 2003 at 02:58:09AM +0100, Vivien Chappelier wrote:
> > Hi,
> > 
> > 	At various places in the 2.5 kernel, the fpu is accessed in
> > kernel mode with CU1 not set, causing an unexpected exception. This patch
> > makes sure FPU can be accessed by the kernel, though it may only
> > be a workaround. Any comment from someone with a better understanding of
> > the FPU access/context switching code?
> > 
> > Vivien.
> > 
> > --- include/asm-mips64/fpu.h	2002-12-11 20:44:20.000000000 +0100
> > +++ include/asm-mips64/fpu.h	2002-12-11 21:51:44.000000000 +0100
> > @@ -109,6 +109,7 @@
> >  
> >  static inline void save_fp(struct task_struct *tsk)
> >  {
> > +	enable_fpu();
> >  	if (mips_cpu.options & MIPS_CPU_FPU) 
> >  		_save_fp(tsk);
> >  }
> > --- include/asm-mips/fpu.h	2002-12-11 20:44:20.000000000 +0100
> > +++ include/asm-mips/fpu.h	2002-12-11 21:51:44.000000000 +0100
> > @@ -109,6 +109,7 @@
> >  
> >  static inline void save_fp(struct task_struct *tsk)
> >  {
> > +	enable_fpu();
> >  	if (mips_cpu.options & MIPS_CPU_FPU) 
> >  		_save_fp(tsk);
> >  }
> 
> The above two hunks seem to be right.
>

There are two places which call save_fp().  Just verified that in
both places current process should be fpu owner and therefore
FPU *should* be enabled.

Basically whenever current process is fpu owner, the FPU should be
enabled.  Apparently something in 2.5 breaks that fundamental assumption.
Will look into it later.

Jun
