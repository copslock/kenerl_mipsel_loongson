Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 04:01:24 +0100 (BST)
Received: from p508B6081.dip.t-dialin.net ([IPv6:::ffff:80.139.96.129]:9901
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225207AbTHADBW>; Fri, 1 Aug 2003 04:01:22 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7131Dx6010835;
	Fri, 1 Aug 2003 05:01:13 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7131BqF010831;
	Fri, 1 Aug 2003 05:01:11 +0200
Date: Fri, 1 Aug 2003 05:01:11 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030801030110.GD4197@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02> <3F29B6EE.5070207@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F29B6EE.5070207@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Adam,

On Fri, Aug 01, 2003 at 08:40:14AM +0800, Fuxin Zhang wrote:

> Current linux code does exactly this. But I was seeing all kinds of 
> faults occuring around the
> sigreturn point on the stack without a sync? And a sync does greatly 
> improve the stablity.
> 
> >The ordering does matter however since the Hit_Invalidate_I makes sure the 
> >write buffer is flushed.

could there be an errata explaining Fuxin's findings?

Fuxin, what version are you running?

  Ralf
