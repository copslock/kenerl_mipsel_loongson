Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 14:15:53 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:3773 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022682AbXDHNPw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2007 14:15:52 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HaXCE-0004L6-00; Sun, 08 Apr 2007 15:12:42 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id B344FC223A; Sun,  8 Apr 2007 15:12:28 +0200 (CEST)
Date:	Sun, 8 Apr 2007 15:12:28 +0200
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
Message-ID: <20070408131228.GA7819@alpha.franken.de>
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4618DDF0.1020604@ru.mvista.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Apr 08, 2007 at 04:20:00PM +0400, Sergei Shtylyov wrote:
> Thomas Bogendoerfer wrote:
> 
> >PCI based SNI RM machines have their EISA bus behind an Intel PCI/EISA
> >bridge. So the PCI IO range must start at 0x0000. Changing that will
> >break the PCI bus, because i8259.c already has registered it's IO
> >addresses before the PCI bus gets initialized. Below is a patch,
> >which will register the PCI host bridge resources inside
> >register_pci_controller(). It also changes i8259.c to use insert_region(),
> >because request_resource() will fail, if the IO space of the PIT hanging
> >of the PCI host bridge (maybe passing the resource parent to
> >init_i8259_irqs() is a cleaner fix for that).
> 
>    First, I don't understand how PIT and PIC resources may intersect. Then, 

oops, I meant PIC resources.

> IIUC, using inert_resource() will cause PIT resource be the child of the 
> PIC resource which doesn't make sense either.

the insert_resource will make it child of the PCI resource, which makes
perfect sense, because the ISA bus is behind the PCI host bridge.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
