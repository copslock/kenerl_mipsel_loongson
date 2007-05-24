Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 23:50:28 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:46466 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022068AbXEXWu1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 23:50:27 +0100
Received: (qmail 18432 invoked by uid 101); 24 May 2007 22:49:20 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 24 May 2007 22:49:20 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l4OMnGwV015856;
	Thu, 24 May 2007 15:49:16 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNWYHJH>; Thu, 24 May 2007 15:49:16 -0700
Message-ID: <46561667.1070105@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/12] drivers: PMC MSP71xx ethernet driver
Date:	Thu, 24 May 2007 15:49:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 24 May 2007 22:49:11.0382 (UTC) FILETIME=[BECC5760:01C79E55]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Jeff Garzik wrote:
> Marc St-Jean wrote:
>  > I asked if the remaining section (above) was acceptable so we could 
> retain our
>  > buffer recycling which enhances throughput. I never received a rely 
> so it was
>  > left in my last patch.
>  >
>  > The above comment now answers my part of my initial question. Are you 
> aware of
>  > a better way to implement this or must we lose all our recycling 
> enhancements?
> 
> 
> You can poke around on netdev and ask about skb recycling in a new
> thread, and propose something.
> 
> I just know that having your own custom skb initialization is a
> non-starter.  Any updates the main skb init code receives will
> inevitably -not- be propagate to your code, rapidly leading to an
> unmaintainable disconnect.
> 
> skb recycling in general is an interesting area to explore, and others
> have poked around that area before.  I bet googling for skb recycling
> would turn up some useful thoughts and past efforts.
> 
>         Jeff
> 

I will resend the driver without the skb recycling shortly. We will need
to see if we can allocate resources to contribute to recycling at the
stack level later.

Thanks,
Marc
