Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 02:08:26 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:6869 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122987AbSIRAIZ>;
	Wed, 18 Sep 2002 02:08:25 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8I08EUD008189;
	Tue, 17 Sep 2002 17:08:14 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id RAA11080;
	Tue, 17 Sep 2002 17:08:25 -0700 (PDT)
Message-ID: <01b801c25ea7$ce074ed0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@linux-mips.org>, "Jun Sun" <jsun@mvista.com>
References: <20020917160425.O17321@mvista.com>
Subject: Re: [jsun@mvista.com: Re: [RFC] FPU context switch]
Date: Wed, 18 Sep 2002 02:10:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> ----- Forwarded message from Jun Sun <jsun@mvista.com> -----
Sep 17, 2002 at 03:58:54PM -0700, Greg Lindahl wrote:
> > 
> > The only good test is Linux with and without lazy saves. Throwing in a
> > new OS complicates matters. It sounds like Jun already has working
> > code for (1) and (3), so he can do a good test.
> >
> 
> I actually have 2) and 3).  1) is easy to do, though.  
> 
> Anyone can recommand some test programs to try?
> 
> A while back, I tried lmbench which is not very telling.
> I think the reason is that most of the tests are not using
> FPU at all.

"Not very telling?"  Sounds to me as if it confirms the
hypothesis that the benefits of these optimizations are
maginal.  ;-)
 
> However I might try it again anyway.  It might tell the
> difference between 1) and 2)&3) easily.

If I wanted to see the effect at its strongest, I'd whip
up an FP-intensive, low-I/O program along the lines
of the old fashioned Whetstone benchmark that runs
for at least a few seconds, then time a script that 
forks off N of them in parallel with M instances of
a program that does no FP.  You can then play with 
M and N to see where a hack becomes advantageous.  
If all runnable programs are using the FPU, there's 
clearly no benefit from the optimization.

Are you able to test this stuff on a proper SMP
system, by the way?  The efficiency of the code 
that manipulates interprocessor control variables 
can reasonably be expected to drop off a bit
in a system with MP cache invalidations blasting
left and right. 

            Regards,

            Kevin K.
