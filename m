Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2R7eEC29716
	for linux-mips-outgoing; Tue, 26 Mar 2002 23:40:14 -0800
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2R7eBq29708
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 23:40:11 -0800
Received: from [192.168.2.2] (IDENT:root@earth.ayrnetworks.com [10.1.1.24])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g2R7df824249;
	Tue, 26 Mar 2002 23:39:42 -0800
Mime-Version: 1.0
X-Sender: kph@192.168.2.1
Message-Id: <a05100302b8c726e35570@[192.168.2.2]>
In-Reply-To: <3CA10449.F0088B95@redhat.com>
References: <3CA10449.F0088B95@redhat.com>
Date: Tue, 26 Mar 2002 23:42:13 -0800
To: David Milburn <dmilburn@redhat.com>, linux-mips@oss.sgi.com
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: Re: PCI ethernet cards
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 5:29 PM -0600 3/26/02, David Milburn wrote:
>Hello,
>
>Can anyone recommend some PCI 100 Mbit ethernet cards/drivers
>that work well with the 2.4 linux-mips kernel?
>
>Thanks,
>David

I've used the tulip driver and a DEC21140-based ethernet adapter 
(proprietary) on rm7000/big endian. There are a few endian bugs (at 
least in 2.4.2) dealing with some debugging messages, but besides 
that the driver works just fine.

Note that the 2.4.2 tulip driver uses PCI I/O space. If you don't 
support PCI I/O space on your platform, this may be a problem. Later 
kernels have an option for using memory mapped PCI space, but I 
haven't tried that driver option yet.

I've also successfully used an i82543-based PCI adapter using the 
driver available on intel's website. This is a 10/100/1000 adapter. 
Again, the only changes that I needed were because of the proprietary 
nature of my platform's I/O interfaces; if you are using intel's 
adapter the driver should work for you out of the box.

Kevin
-- 
