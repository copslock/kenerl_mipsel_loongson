Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 17:47:30 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:26869 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBYRr3>;
	Tue, 25 Feb 2003 17:47:29 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1PHlLJ23040;
	Tue, 25 Feb 2003 09:47:21 -0800
Date: Tue, 25 Feb 2003 09:47:21 -0800
From: Jun Sun <jsun@mvista.com>
To: jeff <jeff_lee@coventive.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Kernel 2.4.20
Message-ID: <20030225094721.C14818@mvista.com>
References: <20030225124850.32cfa6f5.yoichi_yuasa@montavista.co.jp> <LPECIADMAHLPOFOIEEFNIELPCNAA.jeff_lee@coventive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <LPECIADMAHLPOFOIEEFNIELPCNAA.jeff_lee@coventive.com>; from jeff_lee@coventive.com on Tue, Feb 25, 2003 at 03:58:51PM +0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 25, 2003 at 03:58:51PM +0800, jeff wrote:
> Dear All,
>     I am trying to porting NEC Vr4131 platform from 2.4.16 to 2.4.20 but I found some problem.
> In kernel 2.4.16, the kernel entry is 0x80002470 but the kernel entry in 2.4.20 is 0x801xxxxx
> So my problem is how to change the kernel entry from 0x801xxxxx to be 0x8000xxxx? or how 
> to test this kernel when the kernel entry is 0x801xxxxx?
>

Change LOADADDR to 0x80002000 in arch/mips/Makefile.  If you
want to learn more about it, see 

http://linux.junsun.net/porting-howto/porting-howto.html#chapter-directory

Jun
 
