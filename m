Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B0BmRw025284
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 17:11:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B0BmMf025282
	for linux-mips-outgoing; Wed, 10 Jul 2002 17:11:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B0BfRw025233;
	Wed, 10 Jul 2002 17:11:41 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA25088;
	Wed, 10 Jul 2002 17:15:58 -0700
Message-ID: <3D2CCC83.6090304@mvista.com>
Date: Wed, 10 Jul 2002 17:08:35 -0700
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



BTW, I have seen this problem on four boards (including Malta, two NEC boards 
and a Hitachi board).  Not surprisingly the problem mostly happens when you 
connect to 100Mb/s network.

I even suspect this is the default setting on PCI cards on PC.  Can someone 
verify?  If that is the case, that will explain why driver never sets this 
bit.  Maybe we don't have any "real computers" after all. :-)

Jun
