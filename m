Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 21:17:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32971 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992437AbcJUTQ72u7tp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 21:16:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E47507FCF7F6D;
        Fri, 21 Oct 2016 20:16:43 +0100 (IST)
Received: from [10.20.78.168] (10.20.78.168) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 21 Oct 2016
 20:16:46 +0100
Date:   Fri, 21 Oct 2016 20:16:32 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     James Hogan <James.Hogan@imgtec.com>,
        Bhushan Attarde <Bhushan.Attarde@imgtec.com>,
        "gdb-patches@sourceware.org" <gdb-patches@sourceware.org>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235380A70681@HHMAIL01.hh.imgtec.org>
Message-ID: <alpine.DEB.2.00.1610131614180.31859@tp.orcam.me.uk>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com> <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com> <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk> <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk> <20161012180531.GV19354@jhogan-linux.le.imgtec.org> <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380A70681@HHMAIL01.hh.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.168]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55546
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

On Thu, 13 Oct 2016, Matthew Fortune wrote:

> >  Hmm, I didn't know that -- what was the reason for this design
> > decision?
> > Offhand the limitation does not appear necessary to me, each thread has
> > its own distinct register set, so it does not appear to me that its mode
> > of operation has to be the same across them all.  The current setting
> > would still of course be inherited from the parent by any new threads
> > created with clone(2).
> > 
> >  Anyway in that case the presented CP1C registers will have to be read-
> > only.
> 
> There is no need to support the CP1C.FRE/CP1C.NFRE CP1C.FR/CP1C.NFR
> registers as they did not form part of the FR compatibility solution in the
> end. They were added to the architecture as part of an earlier plan that
> would have involved user-mode code switching mode on a per function basis.

 I wonder in that case whether we shouldn't simply have a virtual $fre 
register represented.  It could be 1-bit, but I suspect this may not play 
well with the RSP, so we can make it wider at the raw level and only 
truncate it at the cooked level, just as we do with some other registers 
including in particular my recent $fcsr/$fir change.

 If we had such a dedicated virtual $fre, and we decided sometime to let 
the user actually write to it and switch the mode process-wide, then we 
could simply invoke the right prctl(2) call in response to the user's 
ptrace(2) request.

 NB the x86-64 target has such support with PTRACE_ARCH_PRCTL already and 
PTRACE_POKEUSR writes to $fs/$gs also invoke prctl(2).  So perhaps we just 
ought to go ahead and do the same.

> They must not be enabled in Linux as use of them will lead to complete
> chaos :-).

 Hmm, that's a bit too vague for me I am afraid to accept as an argument 
in a technical discussion, but James's note about mode switches needed 
process-wide at DSO load time has convinced me, so unless you want 
something to add beyond that, feel free not to expand here.

> > > Well it technically depends on
> > > test_tsk_thread_flag(target, TIF_HYBRID_FPREGS)
> > 
> >  Sure, but the hardware representation is CP0.Config5.FRE/CP1C.FRE.
> 
> The FRE compatibility solution does require GDB to both know about and
> modify the user-view of registers as the raw register data cannot be
> interpreted by a user unassisted. My memory is a little rusty but I think
> this already happens for FR=0 vs FR=1 in that GDB is provided with 32
> 64-bit registers and must present them as either:

 The change between FR=0 and FR=1 is different as there the raw register 
format changes (and consequently the cooked as well).  Whereas for FRE=0 
vs FRE=1 only the cooked format changes.  Strictly speaking we could 
ignore cooked format changes and only pass through the raw register 
contents, however I agree in that providing the user with the available 
numeric formats the contents of an FPR or an FPR pair can be interpreted 
as is appropriate.

> FR=0
> ====
> 16 doubles by concatenating the low 32-bits of 2 consecutive registers
> to form a double.
> 32* singles by showing the low 32-bits of each register (*odd registers
> not being singles in mips V and below in FR=0.)
> 
> FR=1
> ====
> 32 doubles
> 32 singles
> (32 128-bit)
> 
> FRE=1
> =====
> 32 doubles
> 32 singles which are stored only in even numbered 64-bit registers with
> the low 32-bit being an even numbered single and the high 32-bit being
> an odd numbered single.
> (32 128-bit)
> 
> GDB cannot show the FRE=1 state correctly without knowing which mode the
> process is running in. I think this matches with comments from James
> below.

 Fair enough although arguably the native and FRE=1 states could be 
presented both at a time for the user to pick whichever he founds more 
convenient.  For example we present FR=0 singles for both even and odd FPR 
indices even on hardware which does not support single arithmetics on FPRs 
at odd indices, i.e. all legacy ISAs, up to MIPS IV inclusive.

> >  Well the contents might be unpredictable, but there sure will be some
> > and GDB is supposed to present it.
> 
> The scheme we have guarantees that no FPU mode switch ever leaves the
> register state in an unknown state which is another reason why users
> cannot change mode directly. The kernel always performs the mode switch
> and this happens with the FPU state in soft-context which is then
> restored after the mode switch occurs.

 Noted, though GDB does not actually care -- it serves as a pass-through 
really, or at least that's the intent.

> >  I haven't got to this part so far and either way will have to think
> > about it yet.  For one as I noted we do want to present vector (paired-
> > single) data with FR=1, FRE=0 in addition to what you quoted above.
> > This was all implemented in an old MIPS UK patch originally written by
> > Nigel Stephens and included with SDE, which I've never got to
> > upstreaming; have you by any chance based your work on that?
> > 
> >  As to FR=1, FRE=1 your quoted representation of singles is a software
> > convention only, so I'm not sure offhand how we might represent it in
> > GDB to keep it reasonable; the 96-bit cooked FP register structure does
> > not appeal to me at all TBH, but maybe it's the best we can do after
> > all.
> 
> The whole FR compatibility scheme has some extremely intricate design
> especially when it comes to FRE mode and I believe all tools have to play
> along in order to get the end result to be seamless for users. If we
> can do any simplification of GDB or the kernel interface then I'm open
> to ideas.

 I'll give it some thought yet and encourage everyone interested to do so 
as well.

> A reference to the spec in case anyone doesn't know where it is:
> 
> https://dmz-portal.ba.imgtec.org/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking
> 
> Note that the spec does not include a definition of the ptrace extension
> nor core dump extension (possibly not even designed yet).

 Thanks for the clarification.

> While I remember the GDB patchset does need at least checking if not
> extra work to cope with the way double precision type data is described
> in dwarf for the various compile modes.

 Noted, though with the cooked register view as outlined above it looks 
to me like register references are supposed to match with no extra effort.

 I'll see if it's worthwhile to push the original MIPS UK work first 
though.  It's been in use for over 10 years now, with our own SDE and then 
CodeSourcery toolchains, although regrettably serving non-XML-described 
targets only:

(gdb) show mips abi
The MIPS ABI is set automatically (currently "n64").
(gdb) show endian
The target endianness is set automatically (currently big endian)
(gdb) ptype $f0
type = union __gdb_builtin_type_mips_double_float_reg {
    double d;
    int64_t l;
    float s __attribute__ ((vector_size(2)));
    int32_t w __attribute__ ((vector_size(2)));
}
(gdb) info registers $f0
f0:  0xffffffffffffffff flt: -nan              dbl: -nan
(gdb) print $f0
$2 = {d = -nan(0xfffffffffffff), l = -1, s = {-nan(0x7fffff), -nan(0x7fffff)},
  w = {-1, -1}}
(gdb) set $f0.s[1] = -1
(gdb) info registers $f0
f0:  0xffffffffbf800000 flt: -1                dbl: -nan
(gdb) print $f0
$5 = {d = -nan(0xfffffbf800000), l = -1082130432, s = {-nan(0x7fffff), -1},
  w = {-1, -1082130432}}
(gdb) 

 Questions or comments?

  Maciej
