Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LJJDO10737
	for linux-mips-outgoing; Thu, 21 Mar 2002 11:19:13 -0800
Received: from tibook.netx4.com ([209.113.146.155])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LJJAq10734
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 11:19:10 -0800
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id g2LJLW100683;
	Thu, 21 Mar 2002 14:21:32 -0500
Message-ID: <3C9A32B9.7000307@embeddededge.com>
Date: Thu, 21 Mar 2002 14:21:29 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.11-pre6-ben0 ppc; en-US; 0.8) Gecko/20010419
X-Accept-Language: en
MIME-Version: 1.0
To: sjhill@cotw.com
CC: Pete Popov <ppopov@mvista.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: pci-pcmcia bridges/adapters
References: <1016683254.4951.168.camel@zeus> <3C9A15AA.304AE304@cotw.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven J. Hill wrote:


> ....of my wireless cards and the driver never worked, so my
> experience has not been good. 

I have been working with quite a few wireless cards in embedded
systems and have discovered they are quite sensitive to reset
after power up.  The power-on, reset, first access to the card
seems to have some timing considerations that some socket drivers
can handle better than others.  Before you assume the bridge and
its related software are at fault, try a variety of cards not
sensitive to this, like a CF in a PCMCIA adapter.  I got burned
by this again yesterday :-).


	-- Dan
