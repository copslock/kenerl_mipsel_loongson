Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 00:00:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:26614 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225643AbTJIXA5>;
	Fri, 10 Oct 2003 00:00:57 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA15576
	for <linux-mips@linux-mips.org>; Thu, 9 Oct 2003 16:00:54 -0700
Subject: Re: CFE bootloader
From: Pete Popov <ppopov@mvista.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB772@iris.adtech-inc.com>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB772@iris.adtech-inc.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1065740466.17498.70.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Oct 2003 16:01:07 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-10-09 at 15:41, Finney, Steve wrote:
> I have no idea how someone would make a choice 
> between MIPS bootloaders (YAMON, U-Boot, CFE, Redboot(?),
> and whatever else), but just so all the options are out 
> there, here's access and licensing information for the 
> Broadcom CFE bootloader: 

I would take a look at the community that's behind it. I like yamon and
it has worked great on the MIPS boards I've worked with. I haven't
played with uboot on MIPS, but what uboot has going for it is a
community that is improving it, adding features, new boards, etc. It's
also cross-arch so if you find yourself supporting multiple products on
different arches, you only have to deal with one bootloader.

Pete
