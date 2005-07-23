Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2005 02:22:07 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:4271 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224912AbVGWBVv>; Sat, 23 Jul 2005 02:21:51 +0100
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.50 #1 (Debian))
	id 1Dw7oI-0007Gt-0w; Fri, 22 Jul 2005 19:24:10 -0500
Message-ID: <42E19C2E.8010808@realitydiluted.com>
Date:	Fri, 22 Jul 2005 20:23:58 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Joanne Woo <jwoo@mvista.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Register definition file for the Broadcom 91250
References: <42E19522.2030106@mvista.com>
In-Reply-To: <42E19522.2030106@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Joanne Woo wrote:
> 
> I'm looking for a register definition file for the Broadcom 91250 for 
> debugging the kernel using the Abatron BDI2000.    If you know where I 
> can find it, please let me know.   Thanks.
>
There is a site devoted to the BCM1250 chips with regard to Linux and
NetBSD. It is:

    http://sibyte.broadcom.com/

The User's manual is what you probably want:

    http://sibyte.broadcom.com/public/resources/index.html#um

As far as the BDI2000, I believe you are out of luck. The only hardware
debugger I know of that works with the SiByte boards is from Coreolis
[sp?]. I heard rumors of other people who reverse-engineered the
protocol for more open debugging, but I do not know more than that.
Maybe others on the list will comment.

-Steve
