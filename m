Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 13:55:35 +0100 (BST)
Received: from [IPv6:::ffff:194.217.161.2] ([IPv6:::ffff:194.217.161.2]:446
	"EHLO wolfsonmicro.com") by linux-mips.org with ESMTP
	id <S8225072AbTGPMzd>; Wed, 16 Jul 2003 13:55:33 +0100
Received: from campbeltown.wolfson.co.uk (campbeltown [192.168.0.166])
	by wolfsonmicro.com (8.11.3/8.11.3) with ESMTP id h6GCtOe08872
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2003 13:55:25 +0100 (BST)
Received: from caernarfon (unverified) by campbeltown.wolfson.co.uk
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T6377cebba8c0a800a6414@campbeltown.wolfson.co.uk> for <linux-mips@linux-mips.org>;
 Wed, 16 Jul 2003 13:56:39 +0100
Subject: [2.6.0-test1] arch/mips/pci/pci.c Pb1500 build errors
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Message-Id: <1058360126.10765.1584.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 13:55:26 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <liam.girdwood@wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liam.girdwood@wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

Hi,

I've found a few undeclared values (that should be #define'ed somewhere)
in arch/mips/pci/pci.c when I'm building for the Pb1500. i.e.

arch/mips/pci/pci.c: In function `pcibios_fixup_resources':
arch/mips/pci/pci.c:98: structure has no member named `name'
arch/mips/pci/pci.c:116: `IO_MEM_LOGICAL_START' undeclared (first use in
this function)
arch/mips/pci/pci.c:116: (Each undeclared identifier is reported only
once
arch/mips/pci/pci.c:116: for each function it appears in.)
arch/mips/pci/pci.c:117: `IO_MEM_LOGICAL_END' undeclared (first use in
this function)
arch/mips/pci/pci.c:118: `IO_MEM_VIRTUAL_OFFSET' undeclared (first use
in this function)
arch/mips/pci/pci.c:121: `IO_PORT_LOGICAL_START' undeclared (first use
in this function)
arch/mips/pci/pci.c:122: `IO_PORT_LOGICAL_END' undeclared (first use in
this function)
arch/mips/pci/pci.c:123: `IO_PORT_VIRTUAL_OFFSET' undeclared (first use
in this function)
make[1]: *** [arch/mips/pci/pci.o] Error 1
make: *** [arch/mips/pci] Error 2


However, if I add the following:-

#define IO_PORT_LOGICAL_START    (Au1500_PCI_IO_START + 0x300)
#define IO_PORT_LOGICAL_END      (Au1500_PCI_IO_END)
#define IO_MEM_LOGICAL_START   (Au1500_PCI_MEM_START)
#define IO_MEM_LOGICAL_END     (Au1500_PCI_MEM_END)

I'm just left with the `IO_PORT_VIRTUAL_OFFSET' and
`IO_MEM_VIRTUAL_OFFSET' errors. I can't find anything familiar to them
from the Alchemy headers and noticed from 2.4 that both values used to
be set by ioremap().

Does anyone know what they should be ? 
I don't mind creating a patch for this.

Thanks

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
