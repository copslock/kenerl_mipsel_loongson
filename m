Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 19:53:58 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:29944 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTBETx5>;
	Wed, 5 Feb 2003 19:53:57 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA14254;
	Wed, 5 Feb 2003 11:53:16 -0800
Subject: Re: which kernel tree for Au1500?
From: Pete Popov <ppopov@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Bruno Randolf <br1@4g-systems.de>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <3E416A47.2090900@embeddededge.com>
References: <200302051234.01252.br1@4g-systems.de>
	 <1044464033.9562.22.camel@adsl.pacbell.net>
	 <3E416A47.2090900@embeddededge.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1044474844.12620.55.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 11:54:04 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-02-05 at 11:47, Dan Malek wrote:
> Pete Popov wrote:
> 
> > ....The PM support ... I haven't tested it in
> > linux-mips.org but it need a little work anyway.
> 
> It needs more than a little work :-)  

I only had in mind the frequency scaling work I had done, not the sleep
mode. The frequency scaling "worked", but there were some bugs with the
timer since using the 'wait' instruction results in the cp0 timer
sleeping, but the external clock doesn't provide very good resolution.

Pete

> I have lots of changes that
> attempt to support sleep mode on the Au1xxxx.  Everything from
> saving/restoring core state, to sdram self refresh, to driver
> modifications for PM functions.  I've done this in the sourceforge
> kernel and will update the linux-mips tree as I have time.  Some
> of the patches will likely require some debate, as they touch software
> outside of the core Au1xxx functions.
> 
> In addition to the kernel modifications, you need a boot rom that
> will support the kernel.  It has to detect a wakeup condition, bring
> the memory back the life, perform some processor initialization, and
> then return to the kernel.  Basically, copy what Yamon does.  ;-)
> 
> If someone is seriously working on this, drop me a note and we can
> exchange information.
> 
> Thanks.
> 
> 
> 	-- Dan
> 
> 
