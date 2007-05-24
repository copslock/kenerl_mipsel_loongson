Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 23:28:50 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:30910 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022069AbXEXW2s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2007 23:28:48 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HrLkX-00083I-FU; Thu, 24 May 2007 22:25:37 +0000
Message-ID: <465610E0.6020309@garzik.org>
Date:	Thu, 24 May 2007 18:25:36 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
CC:	Marc St-Jean <stjeanma@pmc-sierra.com>, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/12] drivers: PMC MSP71xx ethernet driver
References: <46560E06.9090506@pmc-sierra.com>
In-Reply-To: <46560E06.9090506@pmc-sierra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Marc St-Jean wrote:
> I asked if the remaining section (above) was acceptable so we could retain our
> buffer recycling which enhances throughput. I never received a rely so it was
> left in my last patch.
> 
> The above comment now answers my part of my initial question. Are you aware of
> a better way to implement this or must we lose all our recycling enhancements?


You can poke around on netdev and ask about skb recycling in a new 
thread, and propose something.

I just know that having your own custom skb initialization is a 
non-starter.  Any updates the main skb init code receives will 
inevitably -not- be propagate to your code, rapidly leading to an 
unmaintainable disconnect.

skb recycling in general is an interesting area to explore, and others 
have poked around that area before.  I bet googling for skb recycling 
would turn up some useful thoughts and past efforts.

	Jeff
