Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 02:06:41 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:14683
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226180AbVGBBGZ>; Sat, 2 Jul 2005 02:06:25 +0100
Received: (qmail 23007 invoked from network); 2 Jul 2005 01:06:19 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 2 Jul 2005 01:06:18 -0000
Subject: Re: possible serial driver fixup for au1x00 in 2.6?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b720507011756247735d6@mail.gmail.com>
References: <2db32b720507011756247735d6@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 01 Jul 2005 18:06:23 -0700
Message-Id: <1120266383.5987.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-07-01 at 17:56 -0700, rolf liu wrote:
> Basically, au1x00_uart.c is doing the same thing as 8250.c. 

Basically.

> If I want
> to add extra serial port support by 8250.c. There could be some
> problem. Any idea?

Don't know, haven't tried it. In general, the au1x00 serial driver needs
to be rewritten.

Pete
