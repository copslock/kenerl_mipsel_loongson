Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 02:27:08 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:15613 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIRA1H>;
	Wed, 18 Sep 2002 02:27:07 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8I0EYj27445;
	Tue, 17 Sep 2002 17:14:34 -0700
Date: Tue, 17 Sep 2002 17:14:34 -0700
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [jsun@mvista.com: Re: [RFC] FPU context switch]
Message-ID: <20020917171434.Q17321@mvista.com>
References: <20020917160425.O17321@mvista.com> <01b801c25ea7$ce074ed0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01b801c25ea7$ce074ed0$10eca8c0@grendel>; from kevink@mips.com on Wed, Sep 18, 2002 at 02:10:17AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 18, 2002 at 02:10:17AM +0200, Kevin D. Kissell wrote:
> Are you able to test this stuff on a proper SMP
> system, by the way?  The efficiency of the code 
> that manipulates interprocessor control variables 
> can reasonably be expected to drop off a bit
> in a system with MP cache invalidations blasting
> left and right. 
>

Yes.  I understand this effect.  Solution 1), 2) 
and 3) don't really suffer from this problem because
variables tested & manipulated are local - unless the 
process migrates which is a different problem.

Jun
