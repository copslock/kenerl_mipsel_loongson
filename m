Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 23:48:11 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2042 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225195AbTC1XsK>;
	Fri, 28 Mar 2003 23:48:10 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA06092;
	Fri, 28 Mar 2003 15:48:08 -0800
Subject: Re: Au1000 ethernet patch
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030329004153.A20126@linux-mips.org>
References: <3E849F22.7BC4EDE@ekner.info>
	 <1048891068.17369.50.camel@zeus.mvista.com>
	 <20030329004153.A20126@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1048895304.29891.8.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Mar 2003 15:48:24 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-03-28 at 15:41, Ralf Baechle wrote:
> On Fri, Mar 28, 2003 at 02:37:48PM -0800, Pete Popov wrote:
> 
> > On Fri, 2003-03-28 at 11:14, Hartvig Ekner wrote:
> > > The following patch fixes an error where ethernet minimum packets are 4 bytes too long. This caused certain
> > > devices not to respond to ARP requests (which is a bug on their side as well, but.....).
> > 
> > 
> > Thanks, I'll apply it later tonight.
> 
> <asm/if_ether.h> already defines the constant ETH_ZLEN for this purpose.

Great, thanks. I'll make the correction.

Pete
