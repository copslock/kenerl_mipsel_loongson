Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 17:02:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33694 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491158Ab1FUPCa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2011 17:02:30 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5LF2SsP015258;
        Tue, 21 Jun 2011 16:02:28 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5LF2RP6015256;
        Tue, 21 Jun 2011 16:02:27 +0100
Date:   Tue, 21 Jun 2011 16:02:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
Subject: Section mismatches in bcm47xx_defconfig
Message-ID: <20110621150227.GB14197@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17245

WARNING: vmlinux.o(.text+0x2727b8): Section mismatch in reference from the function ssb_pcicore_init_hostmode() to the function .devinit.text:register_pci_controller()
The function ssb_pcicore_init_hostmode() references
the function __devinit register_pci_controller().
This is often because ssb_pcicore_init_hostmode lacks a __devinit
annotation or the annotation of register_pci_controller is wrong.

WARNING: vmlinux.o(.text+0x273398): Section mismatch in reference from the function ssb_gige_probe() to the function .devinit.text:register_pci_controller()
The function ssb_gige_probe() references
the function __devinit register_pci_controller().
This is often because ssb_gige_probe lacks a __devinit
annotation or the annotation of register_pci_controller is wrong.
