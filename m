Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:06:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3834 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225366AbUA1PGC>;
	Wed, 28 Jan 2004 15:06:02 +0000
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id HAA27910;
	Wed, 28 Jan 2004 07:05:54 -0800
Subject: Re: Linux 2.6 on AMD Alchemy Au1500
From: Pete Popov <ppopov@mvista.com>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <4017927B.5080907@246tNt.com>
References: <4017927B.5080907@246tNt.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075302354.16255.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Jan 2004 07:05:54 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2004-01-28 at 02:44, Sylvain Munaut wrote:
> Hi
> 
> For a new design, we're considering Alchemy Au1500 processor family. I'd 
> like to know what is the current state of the linux 2.6 on this 
> platforms / experiences ?

I'm working on it right now but it will take a bit more time to get
everything done. I have a beta version of the 36 bit address patch
that's required for the PCI and PCMCIA.

Pete

> I mainly need :
>  - PCI support to connect Wifi, IDE controller, USB2.0 Host, FireWire 
> controller
>  - Included Ethernet support
> 
> I've seen in the kernel sources that it should be supported but I'd like 
> to know if there are known issues, comments, ...
> 
> 
> Thanks for any info.
> 
>     Sylvain Munaut
> 
> 
