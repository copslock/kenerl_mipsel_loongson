Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 17:37:29 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45306 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTFIQh1>;
	Mon, 9 Jun 2003 17:37:27 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA03196;
	Mon, 9 Jun 2003 09:36:23 -0700
Subject: Re: pcmcia problem on pb1500
From: Pete Popov <ppopov@mvista.com>
To: Jan Pedersen <jp@q-networks.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1055143704.17835.16.camel@jp>
References: <1054907964.14600.172.camel@jp>
	 <1054919329.18838.184.camel@zeus.mvista.com> <1055013539.10775.46.camel@jp>
	 <1055110501.11039.2.camel@adsl.pacbell.net>  <1055143704.17835.16.camel@jp>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1055176618.9976.1.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jun 2003 09:36:59 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


> tried same with 64bit_pcmcia.patch
> same result. I guess that the 36bit patch is included in this kernel?

I think so. I don't remember the date when Ralf applied the patch.

> Tried 2.4.21 & 2.4.21-pre7 from kernel.org
> They die when initializing pci.
> 
> Are there different versions of the 36bit-patch? Mine is named
> 36bit_addr_121302.patch

Well, I kept updating the patch and always put the latest one in my
directory. But the updates were always minor -- just so the patch would
apply cleanly. After Ralf checked it in, I removed it from my directory.

Pete
