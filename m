Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2003 23:59:31 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1775 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225255AbTGRW73>;
	Fri, 18 Jul 2003 23:59:29 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6IMxRe02882;
	Fri, 18 Jul 2003 15:59:27 -0700
Date: Fri, 18 Jul 2003 15:59:27 -0700
From: Jun Sun <jsun@mvista.com>
To: Jack Miller <jack.miller@pioneer-pdt.com>
Cc: Linux-Mips <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: kernel BUG at sched.c:784!
Message-ID: <20030718155927.I31523@mvista.com>
References: <20030718112942.G31523@mvista.com> <JCELLCFDJLFKPOBFKGFNAEKOCFAA.jack.miller@pioneer-pdt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <JCELLCFDJLFKPOBFKGFNAEKOCFAA.jack.miller@pioneer-pdt.com>; from jack.miller@pioneer-pdt.com on Fri, Jul 18, 2003 at 03:51:25PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jul 18, 2003 at 03:51:25PM -0700, Jack Miller wrote:
>   Jun,
>     ' Got the BUG() again after about 5 hours of operation.  The BUG()
> report is below.  Any additional insight you can provide is greatly
> appreciated.  Thanks again for your help.
> 
>   Jack
> 
> Linux version 2.4.17 (jack@saturn) (gcc version 3.2.2 20030612 (Pioneer
> Voyager)) #5 Fri Jul 18 12:51:00 PDT 2003
> 
> active_mm = 83f02b20
>

This make CPU bug being the cause unlikely.

Are you using preemptible-kernel?  I can't think of anything specific.
I think you have to do some honest kgdb debugging.

BTW, I have a simple trace tool (which I think is easier to use
than LTT) you may find helpful.  Good luck.

http://linux.junsun.net/patches/generic/experimental/030716.a-jstrace.patch

Jun
