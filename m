Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B3WrRw003055
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 20:32:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B3Wr7J003054
	for linux-mips-outgoing; Wed, 10 Jul 2002 20:32:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pd3mo2so.prod.shaw.ca (h24-71-223-10.cg.shawcable.net [24.71.223.10])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B3WlRw003044
	for <linux-mips@oss.sgi.com>; Wed, 10 Jul 2002 20:32:47 -0700
Received: from pd5mr2so.prod.shaw.ca
 (pd5mr2so-qfe3.prod.shaw.ca [10.0.141.233]) by l-daemon
 (iPlanet Messaging Server 5.1 HotFix 0.8 (built May 12 2002))
 with ESMTP id <0GZ2001OQDPXSV@l-daemon> for linux-mips@oss.sgi.com; Wed,
 10 Jul 2002 21:01:09 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca
 (pn2ml1so-qfe0.prod.shaw.ca [10.0.121.145]) by l-daemon
 (iPlanet Messaging Server 5.1 HotFix 0.8 (built May 12 2002))
 with ESMTP id <0GZ2005AHDPYA9@l-daemon> for linux-mips@oss.sgi.com; Wed,
 10 Jul 2002 21:01:10 -0600 (MDT)
Received: from wakko.debian.net
 (h24-86-210-128.ed.shawcable.net [24.86.210.128])
 by l-daemon (iPlanet Messaging Server 5.1 HotFix 0.8 (built May 12 2002))
 with ESMTP id <0GZ200KAADPXNH@l-daemon> for linux-mips@oss.sgi.com; Wed,
 10 Jul 2002 21:01:10 -0600 (MDT)
Received: from localhost	([127.0.0.1] helo=wakko.debian.net ident=jgg)
	by wakko.debian.net with smtp (Exim 3.16 #1 (Debian))
	id 17SUCb-0005ov-00; Wed, 10 Jul 2002 21:01:09 -0600
Date: Wed, 10 Jul 2002 21:01:09 -0600 (MDT)
From: Jason Gunthorpe <jgg@debian.org>
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
In-reply-to: <3D2CC891.1010506@mvista.com>
X-Sender: jgg@wakko.debian.net
To: Jun Sun <jsun@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com,
   marcelo@conectiva.com.br
Reply-to: Jason Gunthorpe <jgg@debian.org>
Message-id: <Pine.LNX.3.96.1020710203633.22254C-100000@wakko.debian.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Wed, 10 Jul 2002, Jun Sun wrote:

> > Which slows the stuff down for people with real computers.
> 
> Contrary to what it might appear at first glance, it does not really.

I studied this sort of a problem to some extent on my system using a 8139
card..

Eventually it turned out to be poor arbitrartion between the PCI interface
and the CPU within the system controller. What happens is that the
memcpy from the skbuf to the packet ring in the driver ends up generating
a steady stream of very small writes that starve out PCI access. This is a
particular quirk of our system controller but I wouldn't be surprised if
other controllers had a simlar problem.

A good fix is to use a cached+flushed tx buffer which will lower the
observed DMA latency considerably.

There are some situations where a badly implemented PCI controller can
cause high enough latency if other devices are trying to use the bus, it
depends on how much the interface can burst and where the low watermark is
on the ethernet card. Most scenarios are unlikely though IMHO. 

If you have access to a PCI bus tracer you can determine where the problem
lies pretty quickly. 

> The delay itself is small (should be < 100us typically).  So there is no 

Actually it should be << 30us on an unloaded system. Measurements I've
done on my box are about 13us for a 8139 to read a 1.5K pkt over PCI.

Jason
