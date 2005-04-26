Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2005 22:53:55 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:1170
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8224983AbVDZVxk>; Tue, 26 Apr 2005 22:53:40 +0100
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@71.128.175.241 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 26 Apr 2005 21:53:37 -0000
Subject: Re: should the kernel be initializing the uarts on the Au1550?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <ecb4efd105042612586d43fcc5@mail.gmail.com>
References: <ecb4efd105042612586d43fcc5@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 26 Apr 2005 14:53:37 -0700
Message-Id: <1114552417.5524.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Tue, 2005-04-26 at 15:58 -0400, Clem Taylor wrote:
> It seems that the kernel (2.6.10) isn't properly initializing the
> Au1550 serial ports. All three of the serial ports work, just not at
> the same time. Linux seems to need yamon to configure the serial port
> first. Out of the box yamon uses UART0 & UART3 and ttyS0 & ttyS2
> (UART3, the 1550 doesn't have a UART2) work in linux, but ttyS1
> doesn't. If I switch yamon to use UART1 & UART3, then ttyS0 doesn't
> seem to work in linux. The serial port that isn't configured by yamon
> will hang in an ioctl() on calling tcsetattr().
> 
> Before I just cheat and add a third serial port to yamon, should the
> kernel be initializing the UARTs or does it really expect the yamon to
> initialize them first? Is anyone using all 3 serial ports on an
> Au1550?

Yes, it should. And we should really rewrite the serial driver from
scratch. 

Pete
