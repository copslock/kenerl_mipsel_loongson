Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 08:34:54 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:7296 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225534AbUERHex>; Tue, 18 May 2004 08:34:53 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BPz7X-0001mF-00; Tue, 18 May 2004 08:34:39 +0100
Date: Tue, 18 May 2004 08:34:39 +0100
To: Kieran Fulke <kieran@pawsoff.org>
Cc: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518073439.GA6818@skeleton-jack>
References: <20040513183059.GA25743@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513183059.GA25743@getyour.pawsoff.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Thu, May 13, 2004 at 07:30:59PM +0100, Kieran Fulke wrote:
> 
> getting the below when loading the dvb budget_ci module. it disables IRQ 
> #23 which is attached to the card, rendering it useless. i asked the 
> same question over there and none of them suspect it to be a DVB 
> problem. some esoteric pci bug perhaps?
> 

Not quite so esoteric :-)

Try changing COBALT_QUBE_SLOT_IRQ from 23 to 9 in
include/asm/cobalt/cobalt.h.

P.
