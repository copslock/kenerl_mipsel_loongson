Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 16:58:38 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65273 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTBEQ6h>;
	Wed, 5 Feb 2003 16:58:37 +0000
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA06766;
	Wed, 5 Feb 2003 08:57:52 -0800
Subject: Re: which kernel tree for Au1500?
From: Pete Popov <ppopov@mvista.com>
To: Bruno Randolf <br1@4g-systems.de>
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <200302051234.01252.br1@4g-systems.de>
References: <200302051234.01252.br1@4g-systems.de>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1044464033.9562.22.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 08:53:53 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-02-05 at 03:34, Bruno Randolf wrote:
> hello, 
> 
> we are developing a board based on the Au1500 SOC and we need to adapt the 
> linux kernel for it. since we need something working soon, we will 
> concentrate on the 2.4 version.
> 
> so i wanted to ask which kernel tree is recommended for the Au1x00 chipset. 
> i've found the tree on http://linux-mips.sourceforge.net/ and the 2_4 branch 
> of linux-mips.org look most promising, but they have various differences, 
> most obvious the hyd1100/ directory on sf and the db1x00/ directory on 
> linux-mips. another significant difference is that the sf version has power 
> management support and that linux-mips supports one more PHY in au1000_eth.c.

linux-mips.org is more up to date now and I don't plan on updating the
sourceforge tree anymore. You don't need the hyd1100 board since it's an
internal board only. The PM support ... I haven't tested it in
linux-mips.org but it need a little work anyway.

Pete
