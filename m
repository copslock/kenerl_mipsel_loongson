Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Feb 2008 10:56:03 +0000 (GMT)
Received: from vs166246.vserver.de ([62.75.166.246]:3785 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20033306AbYBPK4A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 16 Feb 2008 10:56:00 +0000
Received: from t5730.t.pppool.de ([89.55.87.48] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1JQKi7-0005om-VV; Sat, 16 Feb 2008 10:56:00 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Linux MIPS PCI resource sanity check
Date:	Sat, 16 Feb 2008 11:55:38 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
References: <200802161139.10791.mb@bu3sch.de> <47B6BFD4.5050404@ru.mvista.com>
In-Reply-To: <47B6BFD4.5050404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802161155.38557.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Saturday 16 February 2008 11:49:56 Sergei Shtylyov wrote:
> Michael Buesch wrote:
> 
> > There's a sanity check in pcibios_enable_resources() that looks like this:
> 
> > 	r = &dev->resource[idx];
> > 	if (!r->start && r->end) {
> > 		printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
> > 		return -EINVAL;
> > 	}
> > 
> > What is this check actually doing?
> 
>    It makes sure that a PCI resource is allocated (base of 0 means that it's 
> unallocated due to previously detected resource conlict (or some other reason).

So well, that's what the error message already told me. ;)
But where is the actual bug? I mean, this tells me there's some collision
for this MMIO resource. Still, I can access the MMIO space just fine.

> > It triggers for me on a BCM4318 device which is behind a BCM4710 PCI bridge.
> > r->start is 0 and r->end is 0x1FFF when this triggers.
> > If I simply comment out that check the device is detected correctly
> > and seems to initialize just fine.
> 
>     No, that failnig resource should be relocated.

How?

-- 
Greetings Michael.
