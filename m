Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 18:07:24 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65008 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTDHRHX>;
	Tue, 8 Apr 2003 18:07:23 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h38H7KJ07021;
	Tue, 8 Apr 2003 10:07:20 -0700
Date: Tue, 8 Apr 2003 10:07:20 -0700
From: Jun Sun <jsun@mvista.com>
To: "Avinash S." <avinash.s@inspiretech.com>
Cc: linux <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: printk problems
Message-ID: <20030408100720.B6865@mvista.com>
References: <200304081211.h38CBgf6024962@smtp.inspirtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200304081211.h38CBgf6024962@smtp.inspirtek.com>; from avinash.s@inspiretech.com on Tue, Apr 08, 2003 at 05:27:23PM +0530
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2003 at 05:27:23PM +0530, Avinash S. wrote:
> Hello,
> I am trying to port linux to a custom built IDT MIPS board. I have 
> managed to get the UART working. My bootup code loads and prints some 
> debugging messages initially and then actual kernel bootup occurs. 
> However it hangs when it reaches the first printk function. i have tried 
> to debug this with some difficulty but with no effect. Could some one 
> tell me or atleast point me to where i can get some info on how printk 
> works or atleast how to debug my printk to see where the actual problem 
> lies?
>

You might want to try the early printk approach.  See

http://linux.junsun.net/porting-howto/

Jun
