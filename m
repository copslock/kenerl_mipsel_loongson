Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 22:32:29 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:17822 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133359AbVIVVcM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2005 22:32:12 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EIYfp-0004CG-AA; Thu, 22 Sep 2005 17:32:09 -0400
Date:	Thu, 22 Sep 2005 17:32:09 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Andy Isaacson <adi@hexapodia.org>, linux-mips@linux-mips.org
Subject: Re: Building the kernel for a Broadcom SB1
Message-ID: <20050922213209.GB15905@nevyn.them.org>
References: <20050922072259.GC6920@hexapodia.org> <20050922172250.6756.qmail@web31513.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922172250.6756.qmail@web31513.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 22, 2005 at 10:22:50AM -0700, Jonathan Day wrote:
> Loading: 0xffffffff80100000/2903912
> 0xffffffff803c4f68/305896 Entry at
> 0xffffffff80396000
> Closing network.
> Starting program at 0xffffffff80396000
> Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
> Board type: SiByte BCM91250E (Sentosa)

[*hang* here]

Andy's patches should fix this; I grabbed them from Thiemo's
experimental Debian packages a couple of days ago and they brought my
Sentosa up again.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
