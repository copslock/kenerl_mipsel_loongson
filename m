Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 14:32:42 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:144 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225411AbVEFNc1>; Fri, 6 May 2005 14:32:27 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1DU2wJ-0006H6-Bd; Fri, 06 May 2005 08:32:23 -0500
Subject: Re: dbau1200 ethernet driver?
In-Reply-To: <261758805.20050506155322@izmiran.rssi.ru>
To:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Date:	Fri, 6 May 2005 08:32:23 -0500 (CDT)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1DU2wJ-0006H6-Bd@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

>  There is a smc91c111 network chip on board, so my question is - what
> driver is suitable with him? Is it "MIPS AU1000 Ethernet support"
> which fails to compile with "error: `NUM_ETH_INTERFACES' undeclared"
> (and it must be?) or something different? It seems that I have enabled
> all other options for ethernet functionality.
> 
Without having access to a source tree currently, how about you grep
through the 'arch/mips/au1000' directory and friends for the string
NUM_ETH_INTERFACES. I think you will find that each board-specific
setup file is responsible for defining it. Either that, or look in
'include/asm-mips'. In the future, make sure you grep through all of
the source to find other possible uses or examples.

-Steve
