Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 23:42:01 +0000 (GMT)
Received: from p508B652B.dip.t-dialin.net ([IPv6:::ffff:80.139.101.43]:22250
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224827AbTC1XmA>; Fri, 28 Mar 2003 23:42:00 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2SNfrj20358;
	Sat, 29 Mar 2003 00:41:53 +0100
Date: Sat, 29 Mar 2003 00:41:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1000 ethernet patch
Message-ID: <20030329004153.A20126@linux-mips.org>
References: <3E849F22.7BC4EDE@ekner.info> <1048891068.17369.50.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048891068.17369.50.camel@zeus.mvista.com>; from ppopov@mvista.com on Fri, Mar 28, 2003 at 02:37:48PM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 28, 2003 at 02:37:48PM -0800, Pete Popov wrote:

> On Fri, 2003-03-28 at 11:14, Hartvig Ekner wrote:
> > The following patch fixes an error where ethernet minimum packets are 4 bytes too long. This caused certain
> > devices not to respond to ARP requests (which is a bug on their side as well, but.....).
> 
> 
> Thanks, I'll apply it later tonight.

<asm/if_ether.h> already defines the constant ETH_ZLEN for this purpose.

  Ralf
