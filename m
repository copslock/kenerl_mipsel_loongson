Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2007 13:51:26 +0100 (BST)
Received: from real.realitydiluted.com ([66.43.201.61]:61585 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20022219AbXGRMvY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jul 2007 13:51:24 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.67)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1IB8z4-0002fK-9x; Wed, 18 Jul 2007 07:50:26 -0500
Date:	Wed, 18 Jul 2007 07:50:26 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
To:	Scott S <techtom@netzero.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Help with BCM7038 Ethernet driver
Message-ID: <20070718125026.GA10086@real.realitydiluted.com>
References: <5.1.0.14.2.20070718023126.0367b5f0@unixmail.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20070718023126.0367b5f0@unixmail.qualcomm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <sjhill@real.realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> I verified with Ethereal, the ethernet driver can send packets, but the 
> 7038 acts as if interrupts are disabled.  I verified that interrupt 23 is 
> enabled, but no interrupts occur.  The uart and the ide/sata interface work 
> fine, so the MIPS int 2 is working fine.  I know there is nothing wrong 
> with the ethernet interface because I use it to boot the kernel in CFE. 
> (see boot below)
> 
Typically this type of behavior has to do with the PHY. If you can send
packets, but not receive....you're PHY is in half-duplex and something
went wrong with autonegotation. Broadcom, AMD, Marvell and others almost
always have some software work arounds for PHY bugs. Did you look up
the part number for the PHY used on your board and grep through the net
drivers in the Linux kernel for possible work-arounds done by some of
the other network drivers? I do not know if your version of CFE has the
ability to examine the PHY registers. If so, do a 'ifconfig /auto' to
get your IP address for your board. Then dump the PHY registers. Next,
boot your kernel and dump the PHY registers and look at differences.

-Steve
