Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 10:43:04 +0100 (WEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36220
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023583AbZFHJm5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 10:42:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id C2C57C8C0F4;
	Mon,  8 Jun 2009 02:42:53 -0700 (PDT)
Date:	Mon, 08 Jun 2009 02:42:53 -0700 (PDT)
Message-Id: <20090608.024253.54091368.davem@davemloft.net>
To:	macro@linux-mips.org
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] declance: Restore tx descriptor ring locking
From:	David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LFD.1.10.0906080219360.6360@ftp.linux-mips.org>
References: <alpine.LFD.1.10.0906080219360.6360@ftp.linux-mips.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 8 Jun 2009 02:47:05 +0100 (WEST)

> A driver overhaul on 29 Feb 2000 (!) broke locking around fiddling with 
> the tx descriptor ring in start_xmit(); a follow-on "fix" removed the 
> broken remnants altogether.  Here's a patch to restore proper locking in 
> the function -- the complement in the interrupt handler has been correct 
> all the time.
> 
>  This *may* have been the reason for the occasional confusion of the chip 
> -- triggering a tx timeout followed by a chip reset sequence -- seen on 
> R4k-based DECstations with the onboard Ethernet interface.  Another theory 
> is the confusion is due to an unindentified problem -- perhaps a silicon 
> erratum -- associated with the variation of the MT ASIC used to interface 
> the R4k CPU to the rest of the system on these computers; with its 
> aggressive write-back buffering the design is particularly weakly ordered 
> when it comes to MMIO (in the absence of ordering barriers uncached reads 
> are allowed to bypass earlier uncached writes, even if to the same 
> location), which may trigger all kinds of corner cases in peripheral 
> hardware as well as software.
> 
> Either way this piece of code is buggy.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Looks good to me, applied.
