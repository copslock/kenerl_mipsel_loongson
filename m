Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 18:21:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12290 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012261AbaJWQV1F3bJx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 18:21:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E84514677EABF;
        Thu, 23 Oct 2014 17:21:16 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 23 Oct
 2014 17:21:19 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Oct 2014 17:21:19 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0195.001; Thu, 23 Oct 2014 17:21:15 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: RE: [RFC PATCH v3] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH v3] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHP7tTlY+v35gXcskOJOMYg117xgJw909MA
Date:   Thu, 23 Oct 2014 16:21:14 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F31A9C@LEMAIL01.le.imgtec.org>
References: <1413022164-317664-1-git-send-email-manuel.lauss@gmail.com>
 <54491CC4.2060304@imgtec.com>
In-Reply-To: <54491CC4.2060304@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43539
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

Markos Chandras <Markos.Chandras@imgtec.com> writes:
> (top posting so Matthew can see the entire patch)
> 
> +CC Matthew Fortune who has some comments on the patch.
> 
> On 10/11/2014 11:09 AM, Manuel Lauss wrote:
> > diff --git a/arch/mips/include/asm/asmmacro-32.h
> b/arch/mips/include/asm/asmmacro-32.h
> > index e38c281..a97ce53 100644
> > --- a/arch/mips/include/asm/asmmacro-32.h
> > +++ b/arch/mips/include/asm/asmmacro-32.h
> > @@ -12,6 +12,9 @@
> >  #include <asm/fpregdef.h>
> >  #include <asm/mipsregs.h>
> >
> > +	.set push
> > +	SET_HARDFLOAT
> > +
> >  	.macro	fpu_save_single thread tmp=t0
> >  	cfc1	\tmp,  fcr31
> >  	swc1	$f0,  THREAD_FPR0_LS64(\thread)
> > @@ -86,6 +89,8 @@
> >  	ctc1	\tmp, fcr31
> >  	.endm
> >
> > +	.set pop
> > +

Any reason for putting the push/pop outside of the macro here but
inside the macros elsewhere?

> > diff --git a/arch/mips/include/asm/mipsregs.h
> b/arch/mips/include/asm/mipsregs.h
> > index cf3b580..889c012 100644
> > --- a/arch/mips/include/asm/mipsregs.h
> > +++ b/arch/mips/include/asm/mipsregs.h
> > @@ -1324,6 +1324,7 @@ do {
> 	\
> >  /*
> >   * Macros to access the floating point coprocessor control registers
> >   */
> > +#ifdef GAS_HAS_SET_HARDFLOAT
> >  #define read_32bit_cp1_register(source)					\
> >  ({									\
> >  	int __res;							\
> > @@ -1334,11 +1335,29 @@ do {
> 		\
> >  	"	# gas fails to assemble cfc1 for some archs,	\n"	\
> >  	"	# like Octeon.					\n"	\
> >  	"	.set	mips1					\n"	\
> > +	"	.set	hardfloat				\n"	\
> >  	"	cfc1	%0,"STR(source)"			\n"	\
> >  	"	.set	pop					\n"	\
> >  	: "=r" (__res));						\
> >  	__res;								\
> >  })
> > +#else
> > +#define read_32bit_cp1_register(source)					\
> > +({									\
> > +	int __res;							\
> > +									\
> > +	__asm__ __volatile__(						\
> > +	"	.set	push					\n"	\
> > +	"	.set	reorder					\n"	\
> > +	"	# gas fails to assemble cfc1 for some archs,	\n"	\
> > +	"	# like Octeon.					\n"	\
> > +	"	.set	mips1					\n"	\
> > +	"	cfc1	%0,"STR(source)"			\n"	\
> > +	"	.set	pop					\n"	\
> > +	: "=r" (__res));						\
> > +	__res;								\
> > +})
> > +#endif

This looks fairly ugly. I believe you can just add the hardfloat using:

> >  	"	# gas fails to assemble cfc1 for some archs,	\n"	\
> >  	"	# like Octeon.					\n"	\
> >  	"	.set	mips1					\n"	\
> > +	"	"STR(SET_HARDFLOAT)"			\n"	\
> >  	"	cfc1	%0,"STR(source)"			\n"	\
> >  	"	.set	pop					\n"	\
> >  	: "=r" (__res));						\
> >  	__res;								\

The ctc1/cfc1 instructions are quite unusual as they were (before my binutils
patch) floating point instructions but are general purpose after the patch.
While that may indicate that you don't need .set hardfloat to use ctc1/cfc1
that is not true when you consider using a new compiler and/or the
-Wa,-msoft-float CFLAGS patch with an old assembler. It would therefore be
wise to test the kernel patch with an assembler which pre-dates my FPXX
patch to make sure that all instances of ctc1/cfc1 have been caught.

That is the reason why Markos saw issues with using one of the mentor
toolchains with your patch in place.

Markos' secondary issue relating to odd-numbered single-precision registers
is probably something to address on the GCC side but I haven't quite
figured out what the root cause is. I'm trying to avoid the kernel having to
add both .set hardfloat and .set oddspreg as I think it is legitimate for
the kernel to expect that when enabling hardfloat in a softfloat module then
the standard hardfloat ABI should apply to that region and all registers
should be available.

Hope that is helpful,

Matthew
