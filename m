Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 02:07:10 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:30936 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225580AbTJIBHI> convert rfc822-to-8bit; Thu, 9 Oct 2003 02:07:08 +0100
content-class: urn:content-classes:message
Subject: kmalloc question
Date: Wed, 8 Oct 2003 15:06:50 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB76D@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kmalloc question
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcOOAaBsMOtG4wNEQ0WLKrZviKHYAg==
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

Is kmalloc (GFP_KERNEL) on a 32 bit HIGHMEM enabled MIPS kernel (BCM/Sibyte processor) guaranteed to allocate memory from the low, KSEG0/1 addressible region? I'm having trouble sorting through the slab.c code. On this processor, only 256 MB of DRAM is directly addressible; with more than 256 MB of RAM, there is 256 MB in zone 0, and the remainder in zone 2. Zone 1 is empty.

Thanks,
sf
