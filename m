Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2003 18:32:11 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:6910 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225436AbTI2RcI> convert rfc822-to-8bit; Mon, 29 Sep 2003 18:32:08 +0100
content-class: urn:content-classes:message
Subject: 64 bit operations w/32 bit kernel
Date: Mon, 29 Sep 2003 07:31:57 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Topic: 64 bit operations w/32 bit kernel
Thread-Index: AcOGr5RuaH2Cp/S8QqaiUMNpsQeklA==
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

What would be the downside to enabling 64 bit operations in user space on a 32 bit kernel (setting the PX bit in the status register?). The particular issue is that I want to access 64 bit-memory mapped registers, and I really need to do it as an atomic operation. I tried borrowing sibyte/64bit.h from the kernel, but I get an illegal instruction on the double ops.

Also, assuming this isn't a horrible idea, is there any obvious single place where "default" values in the CP0 status register get set?

Thanks,
sf
