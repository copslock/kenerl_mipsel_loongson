Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 14:12:40 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:21429 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225214AbUJVNMg>; Fri, 22 Oct 2004 14:12:36 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id 1D4DE1EEFA
	for <linux-mips@linux-mips.org>; Fri, 22 Oct 2004 15:12:30 +0200 (CEST)
Message-ID: <417907A2.3030000@enix.org>
Date: Fri, 22 Oct 2004 15:14:10 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Error on TX descriptor free
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

I'm currently using the MV643xx Ethernet driver on my board. When I run 
the command :

# ifconfig eth0 down

I see the following message :

eth0: Error on Tx descriptor free - could not free 1 descriptors

I went through the code, and saw that this message is displayed in 
mv64340_eth_free_tx_rings(). This function frees all remaining skbs 
(registered in the mp->tx_skb array), and decrement mp->tx_ring_skbs. 
Then, it checks if it reached 0. In my case, it is still 1.

In fact, mp->tx_ring_skbs is initialized to 0 and then incremented in 
mv64340_eth_start_xmit() (when a transmission starts), and is 
decremented in mv64340_eth_free_tx_queue (when the transmission is 
done). But the decrementation only occurs if mp->tx_ring_skbs is 
different from one. I don't understand why.

At the end of mv64340_eth_free_tx_queue(), the following code makes sure 
that the number of skbs did not reach 0 :

     if (mp->tx_ring_skbs == 0)
       panic("ERROR - TX outstanding SKBs counter is corrupted");

Well, my question is simply : why can't we decrement the 
mp->tx_ring_skbs counter to 0 ?

What needs to be fixed ? The decrementation of the counter, or the 
function that frees the TX queue when the interface is stopped ?

I've seen similar code in the Titan GE driver.

Do not hesitate to ask for further details,

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
