Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2005 22:47:19 +0100 (BST)
Received: from i-83-67-53-76.freedom2surf.net ([IPv6:::ffff:83.67.53.76]:18119
	"EHLO skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225936AbVC2VrE>; Tue, 29 Mar 2005 22:47:04 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1DGOXp-0001Lc-00; Tue, 29 Mar 2005 22:46:41 +0100
Date:	Tue, 29 Mar 2005 22:46:41 +0100
To:	Jim Gifford <maillist@jg555.com>
Cc:	Peter Horton <pdh@colonel-panic.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Build 64bit on RaQ2
Message-ID: <20050329214641.GA5152@skeleton-jack>
References: <42449F47.8010002@jg555.com> <20050326091218.GA2471@skeleton-jack> <42488DFC.20408@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42488DFC.20408@jg555.com>
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 28, 2005 at 03:06:36PM -0800, Jim Gifford wrote:
>
>    Got it to compile, but the tulip driver is giving me fits. I built 
> it as a module and into the kernel
> 
> 
> 0000:00:07.0: tulip_stop_rxtx() failed
> 0000:00:07.0: tulip_stop_rxtx() failed
> 0000:00:07.0: tulip_stop_rxtx() failed
> 0000:00:07.0: tulip_stop_rxtx() failed
> 0000:00:07.0: tulip_stop_rxtx() failed
> 0000:00:07.0: tulip_stop_rxtx() failed
>

Tulip driver gave me problems also. I landed up inserting a printk()
which made it work, see the patch. I didn't get round to debugging it
any further, sorry.

P.
