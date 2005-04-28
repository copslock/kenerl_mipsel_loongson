Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 00:53:07 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:60837 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225947AbVD1Xww>;
	Fri, 29 Apr 2005 00:52:52 +0100
Received: from port-195-158-168-232.dynamic.qsc.de ([195.158.168.232] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DRIoH-0004Ad-00; Fri, 29 Apr 2005 01:52:45 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DRIoH-0004RS-2S; Fri, 29 Apr 2005 01:52:45 +0200
Date:	Fri, 29 Apr 2005 01:52:45 +0200
To:	Dan Malek <dan@embeddedalley.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: iptables/vmalloc issues on alchemy
Message-ID: <20050428235244.GB1621@hattusa.textio>
References: <8230E1CC35AF9F43839F3049E930169A137228@yang.LibreStream.local> <c145ddc72b875ec3833ceba1a849b156@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c145ddc72b875ec3833ceba1a849b156@embeddedalley.com>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:
> 
> On Apr 28, 2005, at 5:22 PM, Christian Gan wrote:
> 
> >..... Again it would be okay if I used
> >kmalloc or if I disabled CONFIG_64BIT_PHYS_ADDR.
> 
> An Au1500 or Au1550 isn't likely to work with this disabled.
> PCI and other peripherals exist in the 36-bit space, unless you
> disable them.  I suspect all of this got broken with the dynamic
> exception handler building.  Prior to that, I suspect it works
> fine.  I guess we need to do some regression testing ....

I took the code from 2.4 for 36bit support, without the means of testing
the result. There was no support for it in the 2.6 linux-mips.org CVS at
that time, but some people apparently had uncontributed patches.


Thiemo
