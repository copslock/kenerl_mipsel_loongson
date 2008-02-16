Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Feb 2008 23:35:45 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:4220 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20034599AbYBPXfm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 Feb 2008 23:35:42 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 16 Feb 2008 15:35:35 -0800
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 16 Feb 2008 15:35:34 -0800
Date:	Sat, 16 Feb 2008 15:35:30 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Michael Buesch <mb@bu3sch.de>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Linux MIPS PCI resource sanity check
Message-ID: <20080216153530.7a426a73@ripper.onstor.net>
In-Reply-To: <47B6BFD4.5050404@ru.mvista.com>
References: <200802161139.10791.mb@bu3sch.de>
	<47B6BFD4.5050404@ru.mvista.com>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2008 23:35:34.0951 (UTC) FILETIME=[A0A44370:01C870F4]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Sat, 16 Feb 2008 13:49:56 +0300 Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:

> Michael Buesch wrote:
> 
> > There's a sanity check in pcibios_enable_resources() that looks
> > like this:
> 
> > 	r = &dev->resource[idx];
> > 	if (!r->start && r->end) {
> > 		printk(KERN_ERR "PCI: Device %s not available
> > because of resource collisions\n", pci_name(dev)); return -EINVAL;
> > 	}
> > 
> > What is this check actually doing?
> 
>    It makes sure that a PCI resource is allocated (base of 0 means
> that it's unallocated due to previously detected resource conlict (or
> some other reason).


Actually, IIRC, resources are based on what the device requested, so a
device behind a bridge could request a resource starting at 0.  I had
to change this for a system as well.  I changed it to

if (!r->start && !r->end) {

because I couldn't see anything in the code that made r->start == 0 an
improper thing.  Not to mention I couldn't access the device any other
way.  Both being 0 is definitelty bogus.

> > It triggers for me on a BCM4318 device which is behind a BCM4710
> > PCI bridge. r->start is 0 and r->end is 0x1FFF when this triggers.
> > If I simply comment out that check the device is detected correctly
> > and seems to initialize just fine.
> 
>     No, that failnig resource should be relocated.
> 
> WBR, Sergei
> 
