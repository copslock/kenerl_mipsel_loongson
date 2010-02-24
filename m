Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 21:47:20 +0100 (CET)
Received: from g4t0015.houston.hp.com ([15.201.24.18]:37984 "EHLO
        g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491856Ab0BXUrP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 21:47:15 +0100
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
        by g4t0015.houston.hp.com (Postfix) with ESMTP id 034A98199;
        Wed, 24 Feb 2010 20:47:09 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g4t0018.houston.hp.com (Postfix) with ESMTP id A72361011D;
        Wed, 24 Feb 2010 20:47:08 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 7E5E0CF0097;
        Wed, 24 Feb 2010 13:47:08 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ei15nWSvjWq9; Wed, 24 Feb 2010 13:47:08 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id 69776CF0095;
        Wed, 24 Feb 2010 13:47:08 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: RFC: [MIPS] BCM1480HT set mips_io_port_base
Date:   Wed, 24 Feb 2010 13:47:07 -0700
User-Agent: KMail/1.9.10
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002241347.07685.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

I don't see anywhere that BCM1480HT sets mips_io_port_base (but maybe
I missed it).  We *do* set bcm1480ht_controller.io_map_base, so pci_iomap()
should work, but without mips_io_port_base, I don't think inb() et al.
will work.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/arch/mips/pci/pci-bcm1480ht.c b/arch/mips/pci/pci-bcm1480ht.c
index 0fd0222..021e959 100644
--- a/arch/mips/pci/pci-bcm1480ht.c
+++ b/arch/mips/pci/pci-bcm1480ht.c
@@ -205,6 +205,7 @@ static int __init bcm1480ht_pcibios_init(void)
 			4 * 1024 * 1024);
 	bcm1480ht_controller.io_map_base = (unsigned long)
 		ioremap(A_BCM1480_PHYS_HT_IO_MATCH_BYTES, 65536);
+	set_io_port_base(bcm1480ht_controller.io_map_base);
 
 	register_pci_controller(&bcm1480ht_controller);
 
