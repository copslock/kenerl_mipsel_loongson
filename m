Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 20:39:24 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21245 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225253AbTCGUjX>;
	Fri, 7 Mar 2003 20:39:23 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA23343;
	Fri, 7 Mar 2003 12:39:19 -0800
Subject: Re: Kernel Debugging on the DBAu1500
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <20030307123637.Y20129@luca.pas.lab>
References: <20030306185345.W20129@luca.pas.lab>
	 <1047043427.30914.432.camel@zeus.mvista.com>
	 <1047043677.6389.436.camel@zeus.mvista.com>
	 <20030307123637.Y20129@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047069561.6389.505.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 12:39:22 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-03-07 at 12:36, Jeff Baitis wrote:
> Pete wrote wrote:
> > > Take a look at the board and remind me if the second serial port is
> > > actually uart2, where the first is uart0. 
> Pete wrote:
> > Sorry, I meant uart3, which would be a reason why the UART2_ADDR define
> > below wouldn't work.
> 
> Hrm. The DBAu1500 seems to lock up when I execute:
>     echo "please, no freeze" > /dev/ttyS2
> I can't even get SysRq to work after that command.

You're just a troublemaker ;) I'll take a look and fix it. I suspect I
know what the problem is.

> /dev/ttyS3 works fine, though.
> 
> > > I think it might be. If that's
> > > the case, arch/mips/au1000/common/dbg_io.c has this define if kgdb is
> > > defined:
> > > 
> > > #define DEBUG_BASE  UART2_ADDR
> 
> I changed it to:
> #define  DEBUG_BASE  UART3_ADDR
> 
> Debugging seems to work great now! Thanks!

No problem.

Pete
