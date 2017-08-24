Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2017 17:35:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15557 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994729AbdHXPfNLsTGJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Aug 2017 17:35:13 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DE53846C049A5;
        Thu, 24 Aug 2017 16:35:01 +0100 (IST)
Received: from [10.20.78.111] (10.20.78.111) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 24 Aug 2017
 16:35:02 +0100
Date:   Thu, 24 Aug 2017 16:34:51 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Joseph Myers <joseph@codesourcery.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "binutils@sourceware.org" <binutils@sourceware.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: RE: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235380AC3E7A@HHMAIL01.hh.imgtec.org>
Message-ID: <alpine.DEB.2.00.1708231619520.17596@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org> <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380AC3E7A@HHMAIL01.hh.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.111]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59793
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

Hi Matthew,

On Fri, 11 Nov 2016, Matthew Fortune wrote:

> This means that a user consciously creating an object that 'needs' ieee
> compliance via use of -fieee=strict or -mieee=strict is thwarted by the
> next user who builds the executable. This kind of scenario can occur with
> a static library prepared by an expert in floating point and then someone
> casually including that into a bigger application. Obviously a similar
> issue is present with the rules around executable and shared libraries
> where the executable's compliance mode can override a shared library
> but at this level we are not losing any information and the executable
> has either very specifically been set to 'relaxed' mode or the kernel
> has set legacy to mean relaxed. The latter can at least be fixed by
> changing the kernel. Losing information in a static link cannot be
> fixed.

 I think I can see your point and I admit I may have oversimplified the 
model, losing a piece of crucial information and consequently control.

 What I can propose is a changed model which requires three states at 
compilation/assembly, and then four states at link/load time automatically 
determined by the input objects, with a possible influence of linker 
command-line options to prevent certain transitions.  These are (names up 
to discussion):

1. Strict -- known to require the NaN encodings to match,

2. Unknown -- may or may not require the NaN encodings to match,

3. Unneeded -- known not to require the NaN encodings to match

-- at compilation/assembly and:

A. Strict -- enforcing matching NaN encodings -- built from strict, 
   unknown and unneeded objects of the matching NaN encoding,

B. Unknown -- matching the NaN encodings, but not enforcing it -- built 
   from unknown and unneeded objects of the matching NaN encoding,

C. Unneeded -- not requiring the NaN encodings to match -- built from only
   unneeded objects of the matching NaN encoding,

D. Relaxed -- known not to match either NaN encoding -- built from unknown 
   and unneeded objects of which at least one does not match the NaN 
   encoding of the remaining objects, or from at least one relaxed object.

-- at link/load time.  Any other object combinations would result in a 
link/load failure, e.g. you could not mix A with a D object, or any object 
not matching the NaN encoding.

 The difference between B and C is at the run time -- the treatment of B 
is controlled by the "ieee754=" kernel option, whereas C always ignores 
NaN compatibility of the hardware.  The difference between C and D is at 
the link/load time -- C can be upgraded to A or B, but D is inherently 
lost and remains at D.  At the ELF binary level B objects correspond to 
what I previously referred to as legacy objects, i.e. no extra annotation 
beyond the EF_MIPS_NAN2008 bit.  There could be a linker command-line 
option to prevent a transition from B to D from happening if not desired, 
causing a link failure.

 The states would be maintained at run-time, when a DSO is dlopen(3)ed.  
A would accept A, B or C if matching the NaN encoding, and stay at A.  B 
would accept B or C if matching the NaN encoding, and stay at B.  With the 
relaxed kernel configuration B would also accept B or C using the opposite 
NaN encoding or D, and switch to D.  C would accept C if matching the NaN 
encoding, and stay at C.  C would accept B if matching the NaN encoding, 
and switch to B.  C would accept B or C using the opposite NaN encoding or 
D, and switch to D.  Any other combinations would cause a dlopen(3) 
failure.

 In this model only the initial state is determined by the main executable 
and further transitions are possible as dynamic objects are added, making 
the use of prctl(3) to switch states more prominent.  One unfortunate 
consequence is that dlopen(3)ing an A DSO from a B or C executable 
switches its state to A permanently making it impossible to subsequently 
dlopen(3) a D DSO even though it would have be allowed beforehand.  
Perhaps it would be possible to track state transitions and restore the B 
or C state as appropriate when the A DSO is dlclose(3)d.  Likewise with B 
or C to D and C to B state transitions.

 In this model I think I would recommend distributions to have the 
compiler configured for 2 by default, so that user-built software comes 
out as B (with a link-time transition to D disallowed by default), however 
distributed software compiled as 3 and consequently linked as C, with any 
pieces identified as doing proper math compiled as 1 and consequently 
linked as A, for both NaN encodings if required.  The reason is I think we 
need to draw a line somewhere and conclude that while we can try to 
minimise the damage caused by the hardware peculiarities created by the 
architecture maintainers we cannot prevent all cases of bad software 
builds caused by gross incompetence.

 Does this model match your expectations?  If so, then I'll work on a 
specification update and a corresponding user interface change, and post 
the results.

  Maciej
