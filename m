Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 17:59:24 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:59640 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225223AbUJVQ7T>; Fri, 22 Oct 2004 17:59:19 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 9AEEF185D8; Fri, 22 Oct 2004 09:58:57 -0700 (PDT)
Message-ID: <41793C51.40602@mvista.com>
Date: Fri, 22 Oct 2004 09:58:57 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Error on TX descriptor free
References: <417907A2.3030000@enix.org>
In-Reply-To: <417907A2.3030000@enix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Thomas

Thats a bug. I dont have a board to try this on. But, can you?

Thomas Petazzoni wrote:
> Hello,
> 
> I'm currently using the MV643xx Ethernet driver on my board. When I run 
> the command :
> 
> # ifconfig eth0 down
> 
> I see the following message :
> 
> eth0: Error on Tx descriptor free - could not free 1 descriptors
> 
> I went through the code, and saw that this message is displayed in 
> mv64340_eth_free_tx_rings(). This function frees all remaining skbs 
> (registered in the mp->tx_skb array), and decrement mp->tx_ring_skbs. 
> Then, it checks if it reached 0. In my case, it is still 1.
> 
> In fact, mp->tx_ring_skbs is initialized to 0 and then incremented in 
> mv64340_eth_start_xmit() (when a transmission starts), and is 
> decremented in mv64340_eth_free_tx_queue (when the transmission is 
> done). But the decrementation only occurs if mp->tx_ring_skbs is 
> different from one. I don't understand why.
> 
> At the end of mv64340_eth_free_tx_queue(), the following code makes sure 
> that the number of skbs did not reach 0 :
> 
>     if (mp->tx_ring_skbs == 0)
>       panic("ERROR - TX outstanding SKBs counter is corrupted");
> 
> Well, my question is simply : why can't we decrement the 
> mp->tx_ring_skbs counter to 0 ?
> 
> What needs to be fixed ? The decrementation of the counter, or the 
> function that frees the TX queue when the interface is stopped ?

Decrement the counter to zero as you suggested. And remove the 
panic("..") in mv64340_eth_free_tx_queue(). Let me know if it works fine

Thanks
Manish Lachwani



> 
> I've seen similar code in the Titan GE driver.
> 
> Do not hesitate to ask for further details,
> 
> Thanks,
> 
> Thomas
