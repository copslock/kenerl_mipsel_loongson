Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 21:01:46 +0100 (BST)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:60994
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225458AbUC2UBp>; Mon, 29 Mar 2004 21:01:45 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id i2TK1ZHK029092
	for <linux-mips@linux-mips.org>; Mon, 29 Mar 2004 22:01:35 +0200
Message-ID: <4068809F.8070103@murphy.dk>
Date: Mon, 29 Mar 2004 22:01:35 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: BUG in pcnet32.c?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

In pcnet32.c where the driver writer sets up her receive buffers there 
is this line

lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, 
rx_skbuff->len, PCI_DMA_FROMDEVICE);

the length value turns out to be 0 and crashes the running process,ifconfig.
Is making a map for a buffer of length 0 valid at all? If not what the 
hell is going on here.

I feel this should say PKT_BUF_SZ instead of rx_skbuff->len which is the 
length of skbuff which has been
allocated at this point in the code, this is line 986 in todays checkout.

Something is wrong in any case, any pointers?

/Brian
