Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 14:43:39 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:18843
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022944AbYHGNnc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2008 14:43:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m77DhO0u016257;
	Thu, 7 Aug 2008 14:43:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m77DhNNB016255;
	Thu, 7 Aug 2008 14:43:23 +0100
Date:	Thu, 7 Aug 2008 14:43:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org,
	Thiemo Seufer <ths@networkno.de>
Subject: Re: looking for help interpreting softlockup/stack trace
Message-ID: <20080807134323.GA15703@linux-mips.org>
References: <48989AFE.5000500@nortel.com> <20080805191618.GB8629@linux-mips.org> <4899F41C.5070401@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4899F41C.5070401@avtrex.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2008 at 11:57:32AM -0700, David Daney wrote:

>>> In the trace below, is "epc" the program counter at the time of the   
>>> timer interrupt?  How does "ra" fit into this, given that the 
>>> function  whose address it contains isn't seen in the stack trace 
>>> until quite a  ways down?
>>
>> $LBB378 is an internal symbol.  The value of RA may not be very informative
>> if it was overwritten by a random subroutine call.
>>
>
> I have thought about eliminating these internal labels when the module's symbols are read.  Would this make any sense?

I think so.  Maybe that could even be done when the module is linked.  I
don't think there are ever any relocations against these local symbols.
Thiemo?

  Ralf
