Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 10:43:13 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:25307 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122961AbSIRInM>;
	Wed, 18 Sep 2002 10:43:12 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8I8h5UD009676;
	Wed, 18 Sep 2002 01:43:05 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA25145;
	Wed, 18 Sep 2002 01:43:12 -0700 (PDT)
Message-ID: <004101c25eef$ba035350$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>
References: <20020917160425.O17321@mvista.com> <01b801c25ea7$ce074ed0$10eca8c0@grendel> <20020917171434.Q17321@mvista.com>
Subject: Re: [jsun@mvista.com: Re: [RFC] FPU context switch]
Date: Wed, 18 Sep 2002 10:45:08 +0200
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
X-archive-position: 231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Jun Sun" <jsun@mvista.com>
> On Wed, Sep 18, 2002 at 02:10:17AM +0200, Kevin D. Kissell wrote:
> > Are you able to test this stuff on a proper SMP
> > system, by the way?  The efficiency of the code 
> > that manipulates interprocessor control variables 
> > can reasonably be expected to drop off a bit
> > in a system with MP cache invalidations blasting
> > left and right. 
> 
> Yes.  I understand this effect.  Solution 1), 2) 
> and 3) don't really suffer from this problem because
> variables tested & manipulated are local - unless the 
> process migrates which is a different problem.

It's not a "different problem", it's the heart of the
problem.  If we weren't worried about SMP
behavior, we wouldn't be revisiting this stuff.
While (1) can obviously be done without any
global knowledge, as could something (2)-like 
based on CPU-local state such as Status.CU1, 
(2), (3) and (4), as you describe them, all depend 
to some degree on shared multiprocessor variables 
to determine whether to save or restore FP state.

            Regards,

            Kevin K. 
