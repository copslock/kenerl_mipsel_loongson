Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 10:15:50 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:30599 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225405AbTLTKPr>;
	Sat, 20 Dec 2003 10:15:47 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id hBKAA0YV005647;
	Sat, 20 Dec 2003 02:10:00 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA08490;
	Sat, 20 Dec 2003 02:15:37 -0800 (PST)
Message-ID: <01e801c3c6e2$4aa51ff0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "karthikeyan natarajan" <karthik_96cse@yahoo.com>,
	"Michael Uhler" <uhler@mips.com>
Cc: <linux-mips@linux-mips.org>
References: <20031220095312.38822.qmail@web10104.mail.yahoo.com>
Subject: Re: Regarding branch delay instructions in R4000
Date: Sat, 20 Dec 2003 11:16:09 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Yes, MIPS stood for Microprocessor without Interlocked Pipeline Stages
when it was first used as a name for a graduate student project at Stanford
University in publications from 1982.  But that in itself was a play on words,
as the most common metric of computer perfomance at the time was 
"Millions of Instructions Per Second", or MIPS.  The Stanford architcture 
was revamped and commercialized as the "MIPS I" architecture, implemented 
in the R2000 and R3000 CPUs, which likewise had no interlocks on cache load 
delays. As silicon geometries became finer and gates got cheaper, the relative cost
of providing the interlocks decreased, while the need to run the same MIPS 
binaries on multiple, very different implementations of the architecture increased.
So from the R4000 onwards, MIPS CPUs have had interlocks.  But by that time
the name "MIPS" was a well-known trademark, and it made no sense to change it.

----- Original Message ----- 
From: "karthikeyan natarajan" <karthik_96cse@yahoo.com>
To: "Michael Uhler" <uhler@mips.com>
Cc: <linux-mips@linux-mips.org>
Sent: Saturday, December 20, 2003 10:53
Subject: Re: Regarding branch delay instructions in R4000


> Hi gmu,
> 
>     Have got a one more doubt...
> MIPS stands for Microprocessor without Interlocked
> Pipeline Stages.
>     But, in the "R4400_Uman_book_Ed2.pdf" doc, it is
> mentioned that the CPU general registers are 
> interlocked. I am bit confused after reading this doc.
>     Would be great if you clarify this doubt too...
> 
> Thanks much,
> -karthi
> 
> > The MIPS architecture specifies a single delay slot
> > after a branch
> > or jump.  The fact that the R4000 implementation
> > (and pretty much
> > any of the ones following) had a pipeline in which
> > more instructions
> > had already entered the pipe before the branch is
> > resolved is not
> > relevant to the architecture specification.  In the
> > case you
> > mention, a single instruction is executed after the
> > branch, as
> > architecturally required, and any subsequent
> > instructions in the
> > pipe are killed.
> > 
> > /gmu
> > 
> > On Thu, 2003-12-18 at 22:01, karthikeyan natarajan
> > wrote:
> > > Hi All,
> > > 
> > >     If this is not a right forum to ask this
> > Question,
> > > 
> > > please redirect me to the appropriate one...
> > >     Since R4000 is using the 8 stage pipeline,
> > three
> > > instructions are already entered into the pipeline
> > > when the branch instruction is executed. Out of
> > these
> > > three instructions, the first instruction will be 
> > > executed for sure.
> > > 
> > > My question is:
> > >     What happens to the other two instruction that
> > are
> > > in the delay slots? are they nullified?
> > >     Could anyone please shed some light on this.
> > > 
> > > Thanks much,
> > > -karthi
> > > 
> > > =====
> > > The expert at anything was once a beginner
> > > 
> > >
> >
> ________________________________________________________________________
> > > Yahoo! Messenger - Communicate instantly..."Ping" 
> > > your friends today! Download Messenger Now 
> > > http://uk.messenger.yahoo.com/download/index.html
> > > 
> > -- 
> > Michael Uhler, Chief Technology Officer
> > MIPS Technologies, Inc.  Email: uhler@mips.com 
> > Pager: uhler_p@mips.com
> > 1225 Charleston Road     Voice:  (650)567-5025  FAX:
> >   (650)567-5225
> > Mountain View, CA 94043  Mobile: (650)868-6870 
> > Admin: (650)567-5085
> > 
> >  
> 
> =====
> The expert at anything was once a beginner
> 
> ________________________________________________________________________
> Yahoo! Messenger - Communicate instantly..."Ping" 
> your friends today! Download Messenger Now 
> http://uk.messenger.yahoo.com/download/index.html
> 
> 
