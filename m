Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2004 13:12:26 +0000 (GMT)
Received: from cpe-68-118-232-104.ma.charter.com ([IPv6:::ffff:68.118.232.104]:17288
	"EHLO shuttle") by linux-mips.org with ESMTP id <S8225545AbUBVNMX>;
	Sun, 22 Feb 2004 13:12:23 +0000
Received: by shuttle (Postfix, from userid 1000)
	id BA82F92C010; Sun, 22 Feb 2004 08:12:20 -0500 (EST)
Date:	Sun, 22 Feb 2004 08:12:20 -0500
From:	Daniel Walton <dwalton+mips@ddtsm.com>
To:	linux-mips@linux-mips.org
Subject: Re: MIPS SMP Linux
Message-ID: <20040222131219.GA28782@ddtsm.com>
Reply-To: Daniel Walton <dwalton+mips@ddtsm.com>
References: <20040220214022.71153.qmail@web41504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220214022.71153.qmail@web41504.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Return-Path: <dwalton@ddtsm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalton+mips@ddtsm.com
Precedence: bulk
X-list: linux-mips

> I would like to know if any one is using MIPS SMP
> Linux in the realworld(i.e., more than just for mips
> SMP linux development work)? I am specifically
> interested in broadcom BCM12500s running SMP Linux.

We have been using it on commercially deployed telco grade products
for 18 months or more. If you have been talking with Broadcom they can
probably provide references for you. I believe a large proportion of
their designs are Linux based now.

> If yes, I would like to know their experience in terms
> of stability and performance.

It's stability is fine with SMP. You application code will (should?)
crash much more than the kernel will :-)

Performance is relative to a lot of factors (board space/power/thermal
budget available). It's hard to beat the size/performance offered by
the 1250. 

Daniel
