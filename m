Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 19:53:11 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:19000 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133734AbVLFTwu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 19:52:50 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB6JqVt23980;
	Tue, 6 Dec 2005 23:52:31 +0400
Message-ID: <4395EBFF.9080408@ru.mvista.com>
Date:	Tue, 06 Dec 2005 22:52:31 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: [PATCH] Philips PNX8550 
Content-Type: multipart/mixed;
 boundary="------------090808000209070800000002"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090808000209070800000002
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf, Pete,

This patch enables NATSEMI eth driver to be used on pci bus.

Does it make sense to push this patch?

Vladimir

--------------090808000209070800000002
Content-Type: text/plain;
 name="natsemi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="natsemi.patch"

--- linux-2.6.15.orig/arch/mips/philips/pnx8550/jbs/irqmap.c	2005-12-02 16:37:59.000000000 +0300
+++ linux-2.6.15/arch/mips/philips/pnx8550/jbs/irqmap.c	2005-12-02 17:33:05.000000000 +0300
@@ -31,6 +31,7 @@
 char irq_tab_jbs[][5] __initdata = {
  [8] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
  [9] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+ [10] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
  [17] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
 };
 

--------------090808000209070800000002--
