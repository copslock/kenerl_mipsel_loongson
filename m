Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 09:53:15 +0000 (GMT)
Received: from web10104.mail.yahoo.com ([IPv6:::ffff:216.136.130.54]:29096
	"HELO web10104.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225405AbTLTJxO>; Sat, 20 Dec 2003 09:53:14 +0000
Message-ID: <20031220095312.38822.qmail@web10104.mail.yahoo.com>
Received: from [128.107.253.43] by web10104.mail.yahoo.com via HTTP; Sat, 20 Dec 2003 09:53:12 GMT
Date: Sat, 20 Dec 2003 09:53:12 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Re: Regarding branch delay instructions in R4000
To: Michael Uhler <uhler@mips.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <1071816092.30316.8.camel@gmu-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi gmu,

    Have got a one more doubt...
MIPS stands for Microprocessor without Interlocked
Pipeline Stages.
    But, in the "R4400_Uman_book_Ed2.pdf" doc, it is
mentioned that the CPU general registers are 
interlocked. I am bit confused after reading this doc.
    Would be great if you clarify this doubt too...

Thanks much,
-karthi

> The MIPS architecture specifies a single delay slot
> after a branch
> or jump.  The fact that the R4000 implementation
> (and pretty much
> any of the ones following) had a pipeline in which
> more instructions
> had already entered the pipe before the branch is
> resolved is not
> relevant to the architecture specification.  In the
> case you
> mention, a single instruction is executed after the
> branch, as
> architecturally required, and any subsequent
> instructions in the
> pipe are killed.
> 
> /gmu
> 
> On Thu, 2003-12-18 at 22:01, karthikeyan natarajan
> wrote:
> > Hi All,
> > 
> >     If this is not a right forum to ask this
> Question,
> > 
> > please redirect me to the appropriate one...
> >     Since R4000 is using the 8 stage pipeline,
> three
> > instructions are already entered into the pipeline
> > when the branch instruction is executed. Out of
> these
> > three instructions, the first instruction will be 
> > executed for sure.
> > 
> > My question is:
> >     What happens to the other two instruction that
> are
> > in the delay slots? are they nullified?
> >     Could anyone please shed some light on this.
> > 
> > Thanks much,
> > -karthi
> > 
> > =====
> > The expert at anything was once a beginner
> > 
> >
>
________________________________________________________________________
> > Yahoo! Messenger - Communicate instantly..."Ping" 
> > your friends today! Download Messenger Now 
> > http://uk.messenger.yahoo.com/download/index.html
> > 
> -- 
> Michael Uhler, Chief Technology Officer
> MIPS Technologies, Inc.  Email: uhler@mips.com 
> Pager: uhler_p@mips.com
> 1225 Charleston Road     Voice:  (650)567-5025  FAX:
>   (650)567-5225
> Mountain View, CA 94043  Mobile: (650)868-6870 
> Admin: (650)567-5085
> 
>  

=====
The expert at anything was once a beginner

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
