Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 14:01:14 +0100 (BST)
Received: from bay15-f22.bay15.hotmail.com ([IPv6:::ffff:65.54.185.22]:35343
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225545AbUGMNBI>; Tue, 13 Jul 2004 14:01:08 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 13 Jul 2004 06:01:01 -0700
Received: from 202.56.254.194 by by15fd.bay15.hotmail.msn.com with HTTP;
	Tue, 13 Jul 2004 13:01:01 GMT
X-Originating-IP: [202.56.254.194]
X-Originating-Email: [daff_vadi@hotmail.com]
X-Sender: daff_vadi@hotmail.com
From: "Vadivelan Mani" <daff_vadi@hotmail.com>
To: linux-mips@linux-mips.org
Subject: pci_alloc_consistent() usage 
Date: Tue, 13 Jul 2004 18:31:01 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F223KfTpfpYea00005ca9@hotmail.com>
X-OriginalArrivalTime: 13 Jul 2004 13:01:01.0650 (UTC) FILETIME=[72CDD320:01C468D9]
Return-Path: <daff_vadi@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daff_vadi@hotmail.com
Precedence: bulk
X-list: linux-mips

hi,

   I'm writing a wireless driver which requires 8 transmit and 8 receive 
buffers each of size 3KB approx.

These buffers should be in dma capable space.

I've allocated them using pci_alloc_consistent().

I've allocated 128KBytes just to make more space. I've got few doubts.

   1. Can pci_alloc_consistent() be used to allocate memory upto 128KBytes?

If this is not possible, how much can it allocate?



2.)   I would also like to know the exact use of this allocated space to 
transmit or receive a packet.

During transmission i do the following. Plz correct me if i'm wrong because 
i'm new to driver writing.

The device has a register which should be loaded with the transmit buffers 
starting address.

I copy the packet coming from the Kernel in the form of sk_buff structure 
into one of the transmit buffers that i've allocated using memcpy().
And i set the register in the device to initiate transmission of the packet.

Where does the dma transfer concept come in this?
There is no mention of the direction of data transfer in 
pci_alloc_consistent().

I also assumed that allocating buffer in dma capable space was itself enough 
to start dma transfers.

Since i do not have the device now i'm not able to test the code. But i 
would like to write the code before i get the device.

Kindly help me in this.

thanking u in advance.

regards,
vadi.

_________________________________________________________________
Marriage by choice.... http://www.shaadi.com/ptnr.php?ptnr=hmltag Log onto 
Shaadi.com
