Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 19:37:49 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:58598 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8229665AbVCYTh1>;
	Fri, 25 Mar 2005 19:37:27 +0000
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DEud5-00060b-Rl; Fri, 25 Mar 2005 14:37:59 -0500
Date:	Fri, 25 Mar 2005 14:37:59 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ed Martini <martini@c2micro.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Observations on LLSC and SMP
Message-ID: <20050325193759.GA23046@nevyn.them.org>
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com> <20050316120647.GB8563@linux-mips.org> <42446555.6090005@c2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42446555.6090005@c2micro.com>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 25, 2005 at 11:24:05AM -0800, Ed Martini wrote:
> 1. If the first part of the if were an ifdef instead it would result in 
> a code size reduction as well as a runtime performance gain.

You should spend a little time playing with an optimizing compiler. 
They're capable of working out when a condition will always be false.

> 2. In atomic.h the "C lang stuff" is wrapped with a spinlock.  In the 
> SMP case the spinlock will result in code that contains ll and sc 
> instructions, so I infer that there are no SMP system configs that use 
> CPUs that don't have the ll and sc instructions. 

That's correct.  It is not practical to implement SMP without a mutex
primitive.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
