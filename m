Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 16:05:47 +0100 (BST)
Received: from smtp004.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.81]:28804
	"HELO smtp004.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226686AbVGNPF2>; Thu, 14 Jul 2005 16:05:28 +0100
Received: (qmail 17192 invoked from network); 14 Jul 2005 15:06:40 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp004.bizmail.sc5.yahoo.com with SMTP; 14 Jul 2005 15:06:40 -0000
Subject: Re: Au1550 ethernet throughput low
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	jaypee@hotpop.com, linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1121353347.10582.3.camel@orionlinux.starfleet.com>
References: <1121270402l.7656l.3l@cavan>
	 <1121353347.10582.3.camel@orionlinux.starfleet.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 14 Jul 2005 08:06:46 -0700
Message-Id: <1121353606.4797.346.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-14 at 17:02 +0200, Matej Kupljen wrote:
> Hi
> 
> > I've got a au1550 board based largely on the pb1550. The ethernet  
> > throughput is ~66Mbps using the 2.6 kernel. This also consumes a
> > lot of cpu cycles to send.

Completely different ethernet drivers. The 1550 throughput should be
very good. I haven't noticed any issues with 2.6 on my db1550 but I
haven't run netperf lately. I'll do it when I have a little time.

Pete

> I get low throughput with DB1200 also, although I did not measure
> it (yet). I noticed very slow NFS mounted rootfs and I get a lot of:
> NFS server not responding, still trying
> NFS server O.K.
> (Something like that, I do not have the board here right now).
> 
> AMD supplies smc9111 driver in smc9111.c/h. Should I use
> this driver or is smc9x.c/h better?
> 
> BR,
> Matej
> 
> 
