Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 00:35:01 +0200 (CEST)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:50737 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992625AbdJKWevesXfr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 00:34:51 +0200
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id A201130C00F;
        Wed, 11 Oct 2017 15:34:47 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 9029081EB1;
        Wed, 11 Oct 2017 15:34:45 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
Subject: PCI: brcmstb: Add Broadcom Settopbox PCIe support
Date:   Wed, 11 Oct 2017 18:34:20 -0400
Message-Id: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on ARM,
ARM64, and MIPS platforms.  As the HW of the controller is intimately
tied to the memory subsystem, there are some patches required that are
not typical of a PCIe host controller driver.

pci-brcmstb.c -- is the core functionality of the RC driver.
pci-brcmstb-msi.c -- provides the driver for the PCIe's built-in
	MSI controller.
pci-brcmstb-dma.c -- provides the non-standard mapping between
	system memory and the PCIe address space.
drivers/soc/bcm/brcmstb/memory.c -- provides a single call to inform
	the PCIe controller about the size of populated memory in
	the memory controllers.
