Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2003 06:42:38 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:41856 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225415AbTLSGmh>;
	Fri, 19 Dec 2003 06:42:37 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id hBJ6atLi000754;
	Thu, 18 Dec 2003 22:36:55 -0800 (PST)
Received: from gmu-linux (gmu-linux.mips.com [172.20.8.94])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id WAA28315;
	Thu, 18 Dec 2003 22:42:29 -0800 (PST)
Subject: Re: Regarding branch delay instructions in R4000
From: Michael Uhler <uhler@mips.com>
To: karthikeyan natarajan <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20031219060127.90257.qmail@web10107.mail.yahoo.com>
References: <20031219060127.90257.qmail@web10107.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 18 Dec 2003 22:41:32 -0800
Message-Id: <1071816092.30316.8.camel@gmu-linux>
Mime-Version: 1.0
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

The MIPS architecture specifies a single delay slot after a branch
or jump.  The fact that the R4000 implementation (and pretty much
any of the ones following) had a pipeline in which more instructions
had already entered the pipe before the branch is resolved is not
relevant to the architecture specification.  In the case you
mention, a single instruction is executed after the branch, as
architecturally required, and any subsequent instructions in the
pipe are killed.

/gmu

On Thu, 2003-12-18 at 22:01, karthikeyan natarajan wrote:
> Hi All,
> 
>     If this is not a right forum to ask this Question,
> 
> please redirect me to the appropriate one...
>     Since R4000 is using the 8 stage pipeline, three
> instructions are already entered into the pipeline
> when the branch instruction is executed. Out of these
> three instructions, the first instruction will be 
> executed for sure.
> 
> My question is:
>     What happens to the other two instruction that are
> in the delay slots? are they nullified?
>     Could anyone please shed some light on this.
> 
> Thanks much,
> -karthi
> 
> =====
> The expert at anything was once a beginner
> 
> ________________________________________________________________________
> Yahoo! Messenger - Communicate instantly..."Ping" 
> your friends today! Download Messenger Now 
> http://uk.messenger.yahoo.com/download/index.html
> 
-- 
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager: uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
