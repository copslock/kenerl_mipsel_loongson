Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 17:21:46 +0100 (BST)
Received: from [IPv6:::ffff:194.217.161.2] ([IPv6:::ffff:194.217.161.2]:36577
	"EHLO wolfsonmicro.com") by linux-mips.org with ESMTP
	id <S8225072AbTGPQVo>; Wed, 16 Jul 2003 17:21:44 +0100
Received: from campbeltown.wolfson.co.uk (campbeltown [192.168.0.166])
	by wolfsonmicro.com (8.11.3/8.11.3) with ESMTP id h6GGLWe24010
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2003 17:21:32 +0100 (BST)
Received: from caernarfon (unverified) by campbeltown.wolfson.co.uk
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T63788b7491c0a800a6414@campbeltown.wolfson.co.uk> for <linux-mips@linux-mips.org>;
 Wed, 16 Jul 2003 17:22:47 +0100
Subject: [PATCH][2.6.0-test1] Pb1500 PCI - Makefile rule typo
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Message-Id: <1058372493.10765.1600.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 17:21:33 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <liam.girdwood@wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liam.girdwood@wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

Hi,

Please find attached a small patch that fixes a typo in the PCI makefile
for mips PCI.

Index: arch/mips/pci/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/pci/Makefile,v
retrieving revision 1.2
diff -r1.2 Makefile
22c22
< obj-$(CONFIG_MIPS_PB1500)	+= fixups-au1000.o ops-au1000.o
---
> obj-$(CONFIG_MIPS_PB1500)	+= fixup-au1000.o ops-au1000.o


Liam

-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>



Wolfson Microelectronics plc
http://www.wolfsonmicro.com
t: +44 131 272-7000
f: +44 131 272-7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please
immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender,
except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free.
However, we cannot accept responsibility for any virus transmitted by us
and recommend that you subject any incoming Email to your own virus
checking procedures.
