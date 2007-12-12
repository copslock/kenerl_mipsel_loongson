Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 19:01:13 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:35204 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20035012AbXLLTBF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2007 19:01:05 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 5D65998021;
	Wed, 12 Dec 2007 19:00:33 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 4609198020;
	Wed, 12 Dec 2007 19:00:33 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.68)
	(envelope-from <drow@caradoc.them.org>)
	id 1J2Woq-00085Z-5E; Wed, 12 Dec 2007 14:00:32 -0500
Date:	Wed, 12 Dec 2007 14:00:32 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: questions on struct sigcontext
Message-ID: <20071212190032.GA30506@caradoc.them.org>
References: <47601DEE.4090200@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47601DEE.4090200@nortel.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 11:44:14AM -0600, Chris Friesen wrote:
>
> Hi all,
>
> First, I'm not subscribed to the list so I'd appreciate being cc'd on any 
> replies.
>
> We have a project getting started with MIPS, and one of the things that  
> we're trying to bring in is some exception-handling code that logs  
> various information about the ways that apps fail.
>
> In particular, the guys working on this have asked for the STATUS, CAUSE, 
> BADVADDR, and FPC_EIR registers to be made available as part of struct 
> sigcontext so that they can determine exactly why the app is failing.
>
> Looking at include/asm-mips/sigcontext.h I can see that these registers  
> appear to be in the struct, but are either marked as "unused" or now have 
> different names.
>
> Am I correct that these registers are not currently exported to userspace 
> on a fault?  If this is the case, why not?  Does anyone have a patch to 
> enable this export?

There used to be slots for badvaddr and cause.  You'll have to ask
Ralf why he decided to clobber them for DSP state, I don't remember
:-)  I suspect they may never have held useful information for you;
we don't context switch them for userspace, so an intervening fault
in kernel space or in another thread could change them.

FPC_EIR is, unless I misremember, constant and read only.  You can
just read it.

-- 
Daniel Jacobowitz
CodeSourcery
