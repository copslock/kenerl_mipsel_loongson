Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 20:23:24 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:16103 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225481AbTI3TXM> convert rfc822-to-8bit; Tue, 30 Sep 2003 20:23:12 +0100
content-class: urn:content-classes:message
Subject: RE: 64 bit operations w/32 bit kernel
Date: Tue, 30 Sep 2003 09:23:05 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75F@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 64 bit operations w/32 bit kernel
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcOHa/iHA4w76B2aTZ2Vd+J8J8pAgQAG5J6Q
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: "Ralf Baechle" <ralf@linux-mips.org>,
	"Finney, Steve" <Steve.Finney@SpirentCom.COM>
Cc: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

> 
> What you want really is a 64-bit kernel.  On a 64-bit kernel even for
> processes running in 32-bit address spaces (o32, N32) the processor
> will run with the UX bit enabled.  o32 userspace still lives in the
> assumption that registers are 32-bit so only those bits will 
> be restored
> in function calls etc.  N32 (where userspace isn't ready for 
> prime time
> yet) does guarantee that.  And N64 (userspace similarly not ready for
> prime time) obviously is fully 64-bit everything.

What is the page table space impact of a 64 bit kernel on an architecture like the Sibyte with discontiguous physical address spaces?  Do you still waste 36 MB of page table space on the "hole", or does it even double because the page table entries are bigger for the wider addresses? Or do the issues become irrelevant with the larger address space?

Thanks,
sf
