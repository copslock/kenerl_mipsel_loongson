Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 15:19:30 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:48365 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20024198AbYHGOTX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 15:19:23 +0100
Received: from lagash (p549ADE1B.dip.t-dialin.net [84.154.222.27])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id C6F5C48919;
	Thu,  7 Aug 2008 16:19:21 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KR6Km-0000Fa-JJ; Thu, 07 Aug 2008 16:19:20 +0200
Date:	Thu, 7 Aug 2008 16:19:20 +0200
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
Message-ID: <20080807141920.GA27494@networkno.de>
References: <48989AFE.5000500@nortel.com> <20080805191618.GB8629@linux-mips.org> <4899F41C.5070401@avtrex.com> <20080807134323.GA15703@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080807134323.GA15703@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Aug 06, 2008 at 11:57:32AM -0700, David Daney wrote:
> 
> >>> In the trace below, is "epc" the program counter at the time of the   
> >>> timer interrupt?  How does "ra" fit into this, given that the 
> >>> function  whose address it contains isn't seen in the stack trace 
> >>> until quite a  ways down?
> >>
> >> $LBB378 is an internal symbol.  The value of RA may not be very informative
> >> if it was overwritten by a random subroutine call.
> >>
> >
> > I have thought about eliminating these internal labels when the module's symbols are read.  Would this make any sense?
> 
> I think so.  Maybe that could even be done when the module is linked.  I
> don't think there are ever any relocations against these local symbols.
> Thiemo?

AFAIR all such symbols are branch labels or debug info labels, the module
loader should never use them. (But I don't know if kgdb uses them.)


Thiemo
