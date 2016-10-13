Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 12:09:25 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:51091 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992143AbcJMKJSd4env convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2016 12:09:18 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E5DA67AC272C2;
        Thu, 13 Oct 2016 11:09:08 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL03.hh.imgtec.org (10.44.0.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 13 Oct 2016 11:09:11 +0100
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Thu, 13 Oct 2016 11:09:11 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>
CC:     Bhushan Attarde <Bhushan.Attarde@imgtec.com>,
        "gdb-patches@sourceware.org" <gdb-patches@sourceware.org>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
Thread-Topic: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
Thread-Index: AQHR0IMv0E6JGXg0xEK6eBXBecY686ClWleAgAAVK4CAACpsgIAAGriAgABCtwCAANVhcA==
Date:   Thu, 13 Oct 2016 10:09:10 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235380A70681@HHMAIL01.hh.imgtec.org>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com>
 <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com>
 <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk>
 <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk>
 <20161012180531.GV19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> On Wed, 12 Oct 2016, James Hogan wrote:
> 
> > >  Then I think it makes sense even more not to create this artificial
> > > API and use the CP1C.FRE/CP1C.NFRE registers instead which do
> > > correspond to what hardware presents to user software.
> >
> > well, barely. Linux at least doesn't enable Config5.UFE or
> > Config5.UFR, since FP mode changes must be done for all threads in the
> > process, so userland can't actually directly access those FCRs either.
> 
>  Hmm, I didn't know that -- what was the reason for this design
> decision?
> Offhand the limitation does not appear necessary to me, each thread has
> its own distinct register set, so it does not appear to me that its mode
> of operation has to be the same across them all.  The current setting
> would still of course be inherited from the parent by any new threads
> created with clone(2).
> 
>  Anyway in that case the presented CP1C registers will have to be read-
> only.

There is no need to support the CP1C.FRE/CP1C.NFRE CP1C.FR/CP1C.NFR
registers as they did not form part of the FR compatibility solution in the
end. They were added to the architecture as part of an earlier plan that
would have involved user-mode code switching mode on a per function basis.

They must not be enabled in Linux as use of them will lead to complete
chaos :-).

> > >  I don't think there is any value in it for GDB, I think all 64-bit
> > > FP registers ought to remain being presented as doubles and pairs of
> > > singles regardless of the mode selected (and also possibly
> > > fixed-point longs and pairs of fixed-point words).  We don't know
> > > what's emulated and what's not after all, and then the contents of
> > > FPRs are not interpreted by GDB itself anyhow except in
> > > user-supplied expressions or assignment requests, which for users'
> > > convenience I think should retain the maximum flexibility possible.
> >
> > Well it technically depends on
> > test_tsk_thread_flag(target, TIF_HYBRID_FPREGS)
> 
>  Sure, but the hardware representation is CP0.Config5.FRE/CP1C.FRE.

The FRE compatibility solution does require GDB to both know about and
modify the user-view of registers as the raw register data cannot be
interpreted by a user unassisted. My memory is a little rusty but I think
this already happens for FR=0 vs FR=1 in that GDB is provided with 32
64-bit registers and must present them as either:

FR=0
====
16 doubles by concatenating the low 32-bits of 2 consecutive registers
to form a double.
32* singles by showing the low 32-bits of each register (*odd registers
not being singles in mips V and below in FR=0.)

FR=1
====
32 doubles
32 singles
(32 128-bit)

FRE=1
=====
32 doubles
32 singles which are stored only in even numbered 64-bit registers with
the low 32-bit being an even numbered single and the high 32-bit being
an odd numbered single.
(32 128-bit)

GDB cannot show the FRE=1 state correctly without knowing which mode the
process is running in. I think this matches with comments from James
below.

> > So it allows gdb to detect Linux's Hybrid FPU mode, and present the fp
> > regs (e.g. f0 or f1) more like below to the user depending on the fp
> > mode, which is surely much more intuitive from an assembly debugging
> > point of view.
> >
> > Its also worth noting that "When software changes the value of this
> > bit [Status.FR], the contents of the floating-point registers are
> > UNPREDICTABLE". I.e. there is no architectural unifying register
> > layout between FR=0 / FR=1, only convention. Linux will I presume
> > intentionally save in old mode and restore in new mode on an fp mode
> > change according to its own convention (such that the valid mode
> > changes don't clobber register state).
> 
>  Well the contents might be unpredictable, but there sure will be some
> and GDB is supposed to present it.

The scheme we have guarantees that no FPU mode switch ever leaves the
register state in an unknown state which is another reason why users
cannot change mode directly. The kernel always performs the mode switch
and this happens with the FPU state in soft-context which is then
restored after the mode switch occurs.

> > (disclaimer: I haven't looked at this gdb patchset in detail as to
> > whether any of below has changed since I worked on it).
> >
> > (1) Even singles and doubles always overlap one another, as do odd
> > singles and doubles when FR=1 (and FRE=0):
> > 	/* (little endian) */
> > 	union __gdb_builtin_mips_fp64 {
> > 	  float  f32;
> > 	  double f64;
> > 	  int32  i32;
> > 	  int64  i64;
> > 	};
> >
> > (2) Odd singles when FR=0 (there are no odd doubles):
> > 	union __gdb_builtin_mips_fp32 {
> > 	  float f32;
> > 	  int32_t i32;
> > 	};
> >
> > (3) Odd singles and doubles when FR=1, FRE=1 don't overlap at all:
> > 	struct __gdb_builtin_mips_fp96 {
> > 		union {
> > 			double f64;
> > 			int64  i64;
> > 		};
> > 		union {
> > 			float  f32;
> > 			int32  i32;
> > 		};
> > 	};
> >
> > i.e.
> >
> > FR=0:
> >  (1) even
> >        double:	FEDCBA9876543210
> >        single:	        76543210
> >  (2) odd
> >        single:	FEDCBA98
> >
> > FR=1, FRE=0:
> >  (1) even
> >        double:	FEDCBA9876543210
> >        single:	        76543210
> >  (1) odd
> >        double:	                0123456789ABCDEF
> >        single:	                        89ABCDEF
> >
> > FR=1, FRE=1:
> >  (1) even
> >        double:	FEDCBA9876543210
> >        single:	        76543210   (Hybrid FPR emulation)
> >  (3) odd
> >        double:	                0123456789ABCDEF
> >        single:	FEDCBA98           (Hybrid FPR emulation)
> > )
> 
>  I haven't got to this part so far and either way will have to think
> about it yet.  For one as I noted we do want to present vector (paired-
> single) data with FR=1, FRE=0 in addition to what you quoted above.
> This was all implemented in an old MIPS UK patch originally written by
> Nigel Stephens and included with SDE, which I've never got to
> upstreaming; have you by any chance based your work on that?
> 
>  As to FR=1, FRE=1 your quoted representation of singles is a software
> convention only, so I'm not sure offhand how we might represent it in
> GDB to keep it reasonable; the 96-bit cooked FP register structure does
> not appeal to me at all TBH, but maybe it's the best we can do after
> all.

The whole FR compatibility scheme has some extremely intricate design
especially when it comes to FRE mode and I believe all tools have to play
along in order to get the end result to be seamless for users. If we
can do any simplification of GDB or the kernel interface then I'm open
to ideas.

A reference to the spec in case anyone doesn't know where it is:

https://dmz-portal.ba.imgtec.org/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking

Note that the spec does not include a definition of the ptrace extension
nor core dump extension (possibly not even designed yet).

While I remember the GDB patchset does need at least checking if not
extra work to cope with the way double precision type data is described
in dwarf for the various compile modes.

Matthew
