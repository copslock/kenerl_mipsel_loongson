Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 10:11:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34110 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011153AbbATJLweC2ut convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 10:11:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E819479F63C4;
        Tue, 20 Jan 2015 09:11:45 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 09:11:46 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 20 Jan 2015 09:11:45 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for MIPS
 R6
Thread-Topic: [PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for
 MIPS R6
Thread-Index: AQHQMXp7Uk0hRvGsf0qFh7PvUfWtWJzILMWAgACPufA=
Date:   Tue, 20 Jan 2015 09:11:44 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FAC20A@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com>
 <alpine.LFD.2.11.1501200015580.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501200015580.28301@eddie.linux-mips.org>
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
X-archive-position: 45355
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

Maciej W. Rozycki <macro@linux-mips.org> writes:
> On Fri, 16 Jan 2015, Markos Chandras wrote:
> 
> > GCC versions supporting MIPS R6 use the ZC constraint to enforce a
> > 9-bit offset for MIPS R6. We will use that for all MIPS R6 LL/SC
> > instructions.
> >
> > Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> >  arch/mips/include/asm/compiler.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/include/asm/compiler.h
> b/arch/mips/include/asm/compiler.h
> > index c73815e0123a..8f8ed0245a09 100644
> > --- a/arch/mips/include/asm/compiler.h
> > +++ b/arch/mips/include/asm/compiler.h
> > @@ -16,12 +16,20 @@
> >  #define GCC_REG_ACCUM "accum"
> >  #endif
> >
> > +#ifdef CONFIG_CPU_MIPSR6
> > +/*
> > + * GCC uses ZC for MIPS R6 to indicate a 9-bit offset although
> > + * the macro name is a bit misleading
> > + */
> > +#define GCC_OFF12_ASM() "ZC"
> > +#else
> >  #ifndef CONFIG_CPU_MICROMIPS
> >  #define GCC_OFF12_ASM() "R"
> >  #elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
> >  #define GCC_OFF12_ASM() "ZC"
> >  #else
> >  #error "microMIPS compilation unsupported with GCC older than 4.9"
> > -#endif
> > +#endif /* CONFIG_CPU_MICROMIPS */
> > +#endif /* CONFIG_CPU_MIPSR6 */
> >
> >  #endif /* _ASM_COMPILER_H */
> 
>  I'd prefer to have a GCC version trap here just like with the microMIPS
> constraint.  What is the first upstream version to support R6?  5.0?

Correct.
 
>  Also rather than stating that the name of the macro has now become a
> misnomer I think it should actually be renamed to something more general,
> like `GCC_OFF_SMALL_ASM' (any better suggestions are welcome).  That'd
> have to be a separate patch though, to be applied first, preferably.

The ZC constraint is suitable for use in LL/SC/PREF/CACHE for all ISAs. I
believe this is the smallest width displacement for a memory operation in
all ISAs. The only other reduced displacement in Release 6 is for copro 2
load/stores which are 11-bit rather than 9-bit.

Matthew
