Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 20:47:49 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:2044 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIQSrt>;
	Tue, 17 Sep 2002 20:47:49 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8HIZGO05422;
	Tue, 17 Sep 2002 11:35:16 -0700
Date: Tue, 17 Sep 2002 11:35:16 -0700
From: Jun Sun <jsun@mvista.com>
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] FPU context switch
Message-ID: <20020917113516.F17321@mvista.com>
References: <20020917110423.E17321@mvista.com> <20020917113136.A1890@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020917113136.A1890@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Tue, Sep 17, 2002 at 11:31:36AM -0700
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 11:31:36AM -0700, Greg Lindahl wrote:
> On Tue, Sep 17, 2002 at 11:04:23AM -0700, Jun Sun wrote:
> 
> > Currently I am leaning towards 2) or 3).  What is your opinion?
> 
> (1) and (2) are how other archs like Alpha and Itanium deal with
> this. I think (3) is likely to be painful to debug 

The good news is that I have already got it implemented and it
survived fairly stressful FPU tests.  :-)

> and maintain and
> won't win much. So I'd suggest (2).
>

Yes, 3) is a little harder to maitain.  I don't have much clue
as how much it will improve the performance in reality.
Presumably if there is only one FPU intensive process in the
system, it can improve a little bit.

Thanks for the feedback.

Jun
