Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 18:12:06 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27631 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225352AbTFFRME>;
	Fri, 6 Jun 2003 18:12:04 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA17016;
	Fri, 6 Jun 2003 10:11:01 -0700
Subject: Re: pcmcia problem on pb1500
From: Pete Popov <ppopov@mvista.com>
To: Jan Pedersen <jp@q-networks.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1054919329.18838.184.camel@zeus.mvista.com>
References: <1054907964.14600.172.camel@jp>
	 <1054919329.18838.184.camel@zeus.mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1054919545.18864.186.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 10:12:25 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-06-06 at 10:08, Pete Popov wrote:
> Hi Jan,
> 
> > /etc/pcmcia/config.opts:
> > include port 0x100-0x4ff, port 0xc00-0xcff
> > include memory 0x80000000-0x80ffffff
> 
> I think you need something like that for mips as well.
> 
> > THEN, i saw in the linux-mips archives, that Jeff Baitis has succeeded
> > in getting it working on 2.4. He had applied two patches: 
> > Pete's 36bit_addr_2.4.21-pre4.patch
> > Pete's 64bit_pcmcia.patch
> 
> > I've found and patched theese into my kernel, but now, nothing works!
> 
> Not surprising :)  The 36bit_add_xxxx patch was applied to the tree so
> it's not integrated in the source tree. So this begs the question --

Sorry, this should read "...it's now integrated in the source..."

Pete

> what version of linux-mips are you using? If you're using the latest cvs
> bits, applying the above 36bit patch should have failed miserably. You
> do need the 64bit_pcmcia.patch though.
> 
> Take a look at the archives again and see how Jeff setup config.opts on
> the target board. That was the key.  The cardmgr is recognizing your
> card so it's reading the attribute memory successfully. You're almost
> there ;)
> 
> Pete
> 
> 
> 
> 
