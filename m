Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 03:23:33 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30959 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225275AbUJNCX2>; Thu, 14 Oct 2004 03:23:28 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id F022F1857A; Wed, 13 Oct 2004 19:23:26 -0700 (PDT)
Message-ID: <416DE31E.90509@mvista.com>
Date: Wed, 13 Oct 2004 19:23:26 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]PCI on SWARM
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf

This small patch is required to get PCI working on the Broadcom SWARM 
board in 2.6. Without this patch, the PCI bus scan is skipped due to 
resource conflict. Tested using the E100 network card

Thanks
Manish Lachwani

Index: linux/arch/mips/pci/pci-sb1250.c
===================================================================
--- linux.orig/arch/mips/pci/pci-sb1250.c
+++ linux/arch/mips/pci/pci-sb1250.c
@@ -209,7 +209,7 @@
        pci_probe_only = 1;
 
        /* set resource limit to avoid errors */
-       ioport_resource.end = 0x0000ffff;       /* 32MB reserved by 
sb1250 */
+       ioport_resource.end = 0xffffffff;       /* 32MB reserved by 
sb1250 */
        iomem_resource.end = 0xffffffff;        /* no HT support yet */
 
        cfg_space =
