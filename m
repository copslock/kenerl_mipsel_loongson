Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 00:04:43 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:20229 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992781AbcJLWEg3GX5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 00:04:36 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id A8F8236B11D72;
        Wed, 12 Oct 2016 23:04:24 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 12 Oct 2016
 23:04:29 +0100
Received: from [10.20.78.104] (10.20.78.104) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 12 Oct 2016
 23:04:28 +0100
Date:   Wed, 12 Oct 2016 23:04:18 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Bhushan Attarde <bhushan.attarde@imgtec.com>,
        <gdb-patches@sourceware.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
In-Reply-To: <20161012180531.GV19354@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com> <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com> <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk> <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk> <20161012180531.GV19354@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.104]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 12 Oct 2016, James Hogan wrote:

> >  Then I think it makes sense even more not to create this artificial API 
> > and use the CP1C.FRE/CP1C.NFRE registers instead which do correspond to 
> > what hardware presents to user software.
> 
> well, barely. Linux at least doesn't enable Config5.UFE or Config5.UFR,
> since FP mode changes must be done for all threads in the process, so
> userland can't actually directly access those FCRs either.

 Hmm, I didn't know that -- what was the reason for this design decision?  
Offhand the limitation does not appear necessary to me, each thread has 
its own distinct register set, so it does not appear to me that its mode 
of operation has to be the same across them all.  The current setting 
would still of course be inherited from the parent by any new threads 
created with clone(2).

 Anyway in that case the presented CP1C registers will have to be 
read-only.

> >  I don't think there is any value in it for GDB, I think all 64-bit FP 
> > registers ought to remain being presented as doubles and pairs of singles 
> > regardless of the mode selected (and also possibly fixed-point longs and 
> > pairs of fixed-point words).  We don't know what's emulated and what's not 
> > after all, and then the contents of FPRs are not interpreted by GDB itself 
> > anyhow except in user-supplied expressions or assignment requests, which 
> > for users' convenience I think should retain the maximum flexibility 
> > possible.
> 
> Well it technically depends on
> test_tsk_thread_flag(target, TIF_HYBRID_FPREGS)

 Sure, but the hardware representation is CP0.Config5.FRE/CP1C.FRE.

> So it allows gdb to detect Linux's Hybrid FPU mode, and present the fp
> regs (e.g. f0 or f1) more like below to the user depending on the fp
> mode, which is surely much more intuitive from an assembly debugging
> point of view.
> 
> Its also worth noting that "When software changes the value of this bit
> [Status.FR], the contents of the floating-point registers are
> UNPREDICTABLE". I.e. there is no architectural unifying register layout
> between FR=0 / FR=1, only convention. Linux will I presume intentionally
> save in old mode and restore in new mode on an fp mode change according
> to its own convention (such that the valid mode changes don't clobber
> register state).

 Well the contents might be unpredictable, but there sure will be some and 
GDB is supposed to present it.

> (disclaimer: I haven't looked at this gdb patchset in detail as to
> whether any of below has changed since I worked on it).
> 
> (1) Even singles and doubles always overlap one another, as do odd
> singles and doubles when FR=1 (and FRE=0):
> 	/* (little endian) */
> 	union __gdb_builtin_mips_fp64 {
> 	  float  f32;
> 	  double f64;
> 	  int32  i32;
> 	  int64  i64;
> 	};
> 
> (2) Odd singles when FR=0 (there are no odd doubles):
> 	union __gdb_builtin_mips_fp32 {
> 	  float f32;
> 	  int32_t i32;
> 	};
> 
> (3) Odd singles and doubles when FR=1, FRE=1 don't overlap at all:
> 	struct __gdb_builtin_mips_fp96 {
> 		union {
> 			double f64;
> 			int64  i64;
> 		};
> 		union {
> 			float  f32;
> 			int32  i32;
> 		};
> 	};
> 
> i.e.
> 
> FR=0:
>  (1) even
>        double:	FEDCBA9876543210
>        single:	        76543210
>  (2) odd
>        single:	FEDCBA98
> 
> FR=1, FRE=0:
>  (1) even
>        double:	FEDCBA9876543210
>        single:	        76543210
>  (1) odd
>        double:	                0123456789ABCDEF
>        single:	                        89ABCDEF
> 
> FR=1, FRE=1:
>  (1) even
>        double:	FEDCBA9876543210
>        single:	        76543210   (Hybrid FPR emulation)
>  (3) odd
>        double:	                0123456789ABCDEF
>        single:	FEDCBA98           (Hybrid FPR emulation)
> )

 I haven't got to this part so far and either way will have to think about 
it yet.  For one as I noted we do want to present vector (paired-single) 
data with FR=1, FRE=0 in addition to what you quoted above.  This was all 
implemented in an old MIPS UK patch originally written by Nigel Stephens 
and included with SDE, which I've never got to upstreaming; have you by 
any chance based your work on that?

 As to FR=1, FRE=1 your quoted representation of singles is a software 
convention only, so I'm not sure offhand how we might represent it in GDB 
to keep it reasonable; the 96-bit cooked FP register structure does not 
appeal to me at all TBH, but maybe it's the best we can do after all.

  Maciej
