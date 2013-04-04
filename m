Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 15:47:12 +0200 (CEST)
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:52499 "EHLO
        cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822444Ab3DDNrHyIBnd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Apr 2013 15:47:07 +0200
Received: from cpsps-ews09.kpnxchange.com ([10.94.84.176]) by cpsmtpb-ews02.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 4 Apr 2013 15:47:02 +0200
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 4 Apr 2013 15:47:02 +0200
Received: from [192.168.1.100] ([212.123.139.93]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 4 Apr 2013 15:47:01 +0200
Message-ID: <1365083221.1830.51.camel@x61.thuisdomein>
Subject: [PATCH v2] MIPS: Alchemy: Fix typo "CONFIG_DEBUG_PCI"
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Apr 2013 15:47:01 +0200
In-Reply-To: <515D69B6.6040302@cogentembedded.com>
References: <1365074738.1830.38.camel@x61.thuisdomein>
         <515D69B6.6040302@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2013 13:47:01.0691 (UTC) FILETIME=[E26BE8B0:01CE313A]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit 7517de348663b08a808aff44b5300e817157a568 ("MIPS: Alchemy: Redo
PCI as platform driver") added a reference to CONFIG_DEBUG_PCI. Change
it to CONFIG_PCI_DEBUG, as that is a valid Kconfig macro.

Also add a newline to a debugging printk that this fix enables.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
This version has a verbose commit explanation, as Sergei requested.
Still entirely untested.

 arch/mips/pci/pci-alchemy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 38a80c8..d1faece 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -19,7 +19,7 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/tlbmisc.h>
 
-#ifdef CONFIG_DEBUG_PCI
+#ifdef CONFIG_PCI_DEBUG
 #define DBG(x...) printk(KERN_DEBUG x)
 #else
 #define DBG(x...) do {} while (0)
@@ -162,7 +162,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 	if (status & (1 << 29)) {
 		*data = 0xffffffff;
 		error = -1;
-		DBG("alchemy-pci: master abort on cfg access %d bus %d dev %d",
+		DBG("alchemy-pci: master abort on cfg access %d bus %d dev %d\n",
 		    access_type, bus->number, device);
 	} else if ((status >> 28) & 0xf) {
 		DBG("alchemy-pci: PCI ERR detected: dev %d, status %lx\n",
-- 
1.7.11.7
