Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:13:59 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:60844 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20023834AbZDIFNx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:13:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id E82443412F;
	Thu,  9 Apr 2009 13:10:54 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyyX1YBBJvuO; Thu,  9 Apr 2009 13:10:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id D508834129;
	Thu,  9 Apr 2009 13:10:46 +0800 (CST)
Message-ID: <49DD8404.7040705@lemote.com>
Date:	Thu, 09 Apr 2009 13:13:40 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 14/14] lemote: PCI resource naming fixup
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips


---
arch/mips/lemote/lm2f/common/pci.c | 4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lemote/lm2f/common/pci.c
b/arch/mips/lemote/lm2f/common/pci.c
index f7acbe7..9c080cb 100644
--- a/arch/mips/lemote/lm2f/common/pci.c
+++ b/arch/mips/lemote/lm2f/common/pci.c
@@ -34,14 +34,14 @@ extern struct pci_ops loongson2f_pci_pci_ops;
/* if you want to expand the pci memory space, you should config 64bits
kernel too. */

static struct resource loongson2f_pci_mem_resource = {
- .name = "LOONGSON2E PCI MEM",
+ .name = "PCI MEM",
.start = 0x14000000UL,
.end = 0x1fffffffUL,
.flags = IORESOURCE_MEM,
};

static struct resource loongson2f_pci_io_resource = {
- .name = "LOONGSON2E PCI IO MEM",
+ .name = "PCI IO MEM",
.start = 0x00004000UL,
.end = 0x0000ffffUL,
.flags = IORESOURCE_IO,
-- 
1.5.6.5
