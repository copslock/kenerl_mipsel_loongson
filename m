Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 15:15:52 +0000 (GMT)
Received: from [IPv6:::ffff:202.56.254.201] ([IPv6:::ffff:202.56.254.201]:49151
	"EHLO mail.soc-soft.com") by linux-mips.org with ESMTP
	id <S8225232AbUCVPPv> convert rfc822-to-8bit; Mon, 22 Mar 2004 15:15:51 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Non recoverabe Abort
Date: Mon, 22 Mar 2004 20:45:44 +0530
Message-ID: <E519BE9E8DAC6A4B89DA4AD1D2A155B783B561@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Non recoverabe Abort
Thread-Index: AcQQIIuuFN5FE3GcQ2ev+aN7lIF2+Q==
From: "Nitin P Mahajan" <Nitin@soc-soft.com>
To: <linux-mips@linux-mips.org>
Cc: <linux-net@vger.kernel.org>
Return-Path: <Nitin@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nitin@soc-soft.com
Precedence: bulk
X-list: linux-mips

Hi!

	I am writing a driver for the on-chip Ethernet controller
(Exactly Similar to TC35815) on TX4938.

I am facing one problem for a long time. I am getting the following two
interrupts but not the transmit interrupt when I attempt to transmit. 1.
Non-recoverable Abort. 2. Master Abort Reception.

I have just created one transmit descriptor and attached a small data
buffer to it. Through the MAC loop back I want to test this basic
transmission. I am not getting the TxComp interrupt. I am giving the
physical address of the descriptor to the DMA controller and assigning
the physical address of the data buffer into the DataBuff field in the
descriptor. Is it possible to get the transmit and receive interrupts in
the MAC loopback condition.

Could anyone please tell me what can be the reason of these interrupts
(1. Non-recoverable Abort, 2. Master Abort Reception) and how can I
overcome it.

Thanking u in advance,

Regards

-Nitin Mahajan
