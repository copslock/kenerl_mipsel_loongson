Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2004 16:22:32 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2296 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8226169AbUEGPWb>;
	Fri, 7 May 2004 16:22:31 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA21597;
	Fri, 7 May 2004 08:22:24 -0700
Message-ID: <409BA9AE.3080800@mvista.com>
Date: Fri, 07 May 2004 08:22:22 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: linux-mips@linux-mips.org
Subject: Re: drivers/pcmcia/au1000_generic.c
References: <20040507104055.GA10779@lst.de>
In-Reply-To: <20040507104055.GA10779@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:

>Does someone care for that file in 2.6?  It doesn't compile at all in
>2.4, in fact it looks like someone just dropped that file into the tree
>after all 2.5 pcmcia changes were over..
>
>  
>
Of course I care. It compiles in 2.4, unless the recent 2.4.26 merge 
broke it, but I doubt it. And in 2.6, I basically rewrote the driver so 
it's up to date for the db1x00 boards but not the rest of the au1x 
boards. I'll get to those soon.

Pete
