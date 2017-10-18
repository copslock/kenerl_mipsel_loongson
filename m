Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 17:44:56 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.232]:47421 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992361AbdJRPotuE--h convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Oct 2017 17:44:49 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 18 Oct 2017 15:44:35 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 18 Oct 2017 08:39:19 -0700
From:   Matthew Fortune <Matthew.Fortune@mips.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Joseph Myers <joseph@codesourcery.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "binutils@sourceware.org" <binutils@sourceware.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: RE: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Thread-Topic: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Thread-Index: AQHRrgOUwaHVYqP+hUemv+Dv8MXdNJ+7lSHwgFu3JACAvC92gIHC9IeAgFZvbgA=
Date:   Wed, 18 Oct 2017 15:39:18 +0000
Message-ID: <22DC0315F97E854EABE5B749527587D502DE4722@MIPSMAIL01.mipstec.com>
References: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org>
 <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B0235380AC3E7A@HHMAIL01.hh.imgtec.org>
 <alpine.DEB.2.00.1708231619520.17596@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1708231619520.17596@tp.orcam.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.173]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1508341474-321458-19848-79389-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186089
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matthew.Fortune@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@mips.com
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

Hi Maciej,

Slow thread, sorry for dragging it out further...

Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> On Fri, 11 Nov 2016, Matthew Fortune wrote:
> 
> > This means that a user consciously creating an object that 'needs'
> ieee
> > compliance via use of -fieee=strict or -mieee=strict is thwarted by
> the
> > next user who builds the executable. This kind of scenario can occur
> with
> > a static library prepared by an expert in floating point and then
> someone
> > casually including that into a bigger application. Obviously a similar
> > issue is present with the rules around executable and shared libraries
> > where the executable's compliance mode can override a shared library
> > but at this level we are not losing any information and the executable
> > has either very specifically been set to 'relaxed' mode or the kernel
> > has set legacy to mean relaxed. The latter can at least be fixed by
> > changing the kernel. Losing information in a static link cannot be
> > fixed.
> 
>  I think I can see your point and I admit I may have oversimplified the
> model, losing a piece of crucial information and consequently control.
> 
>  What I can propose is a changed model which requires three states at
> compilation/assembly, and then four states at link/load time
> automatically
> determined by the input objects, with a possible influence of linker
> command-line options to prevent certain transitions.  These are (names
> up
> to discussion):
> 
> 1. Strict -- known to require the NaN encodings to match,
> 
> 2. Unknown -- may or may not require the NaN encodings to match,
> 
> 3. Unneeded -- known not to require the NaN encodings to match

Am I right in thinking unneeded is not the same as no-float, it has
floating point in it but explicitly does not care about NaN encodings
because it was built with an option that said so?

> -- at compilation/assembly and:
> 
> A. Strict -- enforcing matching NaN encodings -- built from strict,
>    unknown and unneeded objects of the matching NaN encoding,

Must have at least one strict object?

> 
> B. Unknown -- matching the NaN encodings, but not enforcing it -- built
>    from unknown and unneeded objects of the matching NaN encoding,
> 
> C. Unneeded -- not requiring the NaN encodings to match -- built from
> only
>    unneeded objects of the matching NaN encoding,
> 
> D. Relaxed -- known not to match either NaN encoding -- built from
> unknown
>    and unneeded objects of which at least one does not match the NaN
>    encoding of the remaining objects, or from at least one relaxed
> object.
> 
> -- at link/load time.  Any other object combinations would result in a
> link/load failure, e.g. you could not mix A with a D object, or any
> object
> not matching the NaN encoding.
> 
>  The difference between B and C is at the run time -- the treatment of B
> is controlled by the "ieee754=" kernel option, whereas C always ignores
> NaN compatibility of the hardware.  The difference between C and D is at
> the link/load time -- C can be upgraded to A or B, but D is inherently
> lost and remains at D.  At the ELF binary level B objects correspond to
> what I previously referred to as legacy objects, i.e. no extra
> annotation
> beyond the EF_MIPS_NAN2008 bit.  There could be a linker command-line
> option to prevent a transition from B to D from happening if not
> desired,
> causing a link failure.
> 
>  The states would be maintained at run-time, when a DSO is dlopen(3)ed.
> A would accept A, B or C if matching the NaN encoding, and stay at A.  B
> would accept B or C if matching the NaN encoding, and stay at B.  With
> the
> relaxed kernel configuration B would also accept B or C using the
> opposite
> NaN encoding or D, and switch to D.  C would accept C if matching the
> NaN
> encoding, and stay at C.  C would accept B if matching the NaN encoding,
> and switch to B.  C would accept B or C using the opposite NaN encoding
> or
> D, and switch to D.  Any other combinations would cause a dlopen(3)
> failure.

I'm not entirely sure why 3 or C should care about nan encoding at all
because they should be totally independent of the concept. I.e. link
any combination, choose a NaN encoding for the resulting object at
random but disregard the NaN encoding coming from an unneeded object
when combining with others.

>  In this model only the initial state is determined by the main
> executable
> and further transitions are possible as dynamic objects are added,
> making
> the use of prctl(3) to switch states more prominent.  One unfortunate
> consequence is that dlopen(3)ing an A DSO from a B or C executable
> switches its state to A permanently making it impossible to subsequently
> dlopen(3) a D DSO even though it would have be allowed beforehand.
> Perhaps it would be possible to track state transitions and restore the
> B
> or C state as appropriate when the A DSO is dlclose(3)d.  Likewise with
> B
> or C to D and C to B state transitions.

The dynamic linker already does a scan of all loaded objects for the
purpose of FPXX mode calculations so I doubt it would cost much to
recalculate each time a module is loaded. You only need to handle it at
load time though not unload.
 
>  In this model I think I would recommend distributions to have the
> compiler configured for 2 by default, so that user-built software comes
> out as B (with a link-time transition to D disallowed by default),

Seems fine.

> however
> distributed software compiled as 3 and consequently linked as C, with

Not sure about this. Knowing that something does not care about NaN
encodings is just as hard as knowing something does care. Getting the
different build settings used for default user-builds and distribution
packages is also likely to be painful. I think you could safely get away
with just building as 2 for everything unless it is known to need
matching NaNs, i.e. strict.

> any
> pieces identified as doing proper math compiled as 1 and consequently
> linked as A, for both NaN encodings if required.  The reason is I think
> we
> need to draw a line somewhere and conclude that while we can try to
> minimise the damage caused by the hardware peculiarities created by the
> architecture maintainers we cannot prevent all cases of bad software
> builds caused by gross incompetence.
> 
>  Does this model match your expectations?  If so, then I'll work on a
> specification update and a corresponding user interface change, and post
> the results.

The new set of states look good. I think unneeded is the least likely to
be used in reality but it would form a basis for nofloat.

Thanks,
Matthew

>   Maciej
