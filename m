Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ANt1Rw024271
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 16:55:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ANt1Fv024270
	for linux-mips-outgoing; Wed, 10 Jul 2002 16:55:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ANsqRw024259;
	Wed, 10 Jul 2002 16:54:53 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA24490;
	Wed, 10 Jul 2002 16:59:07 -0700
Message-ID: <3D2CC891.1010506@mvista.com>
Date: Wed, 10 Jul 2002 16:51:45 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>,
   marcelo@conectiva.com.br
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
References: <E17SRFB-00087H-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alan Cox wrote:

>>This patch fixes a tx underflow error for 79c973 chip.  It essentially delay 
>>the transmission until the whole packet is received into the on-chip sdram.
>>
>>The patch is already accepted by Marcelo for the 2.4 tree, I think.
>>
> 
> Which slows the stuff down for people with real computers.


Contrary to what it might appear at first glance, it does not really.

While it delays the start of a transmission of the first packet, the delay 
does not aggregate in a steam of data.  The bottle neck is either in upper 
layer (how fact upper layer generates packets) or in the link layer (when we 
exceed the maximum bandwitch of the wire, in which case we always have plenty 
of full packets to send).

The delay itself is small (should be < 100us typically).  So there is no 
impact on interactive packets.  Note if the delay is not small (e.g., on 
system where PCI bus arbitration may be broken), then you *will* have the tx 
underflow problem.

So on a good system the delay should be really small (especially if you 
compare to what it takes to transmit the whole packet to the other end).  On a 
bad system where the delay can be long, then you will need the fix anyway.

Jun

> Please apply
> some kind of heuristic to this - eg switch to delaying if you exceed
> 50 failures in a 60 second period.
> 
> Alan
> 
