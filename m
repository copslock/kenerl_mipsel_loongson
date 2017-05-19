Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2017 21:56:09 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994891AbdEST4Cw7jQZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 May 2017 21:56:02 +0200
Received: from localhost (unknown [69.55.156.165])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB1B23990;
        Fri, 19 May 2017 19:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB1B23990
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 1/2] MIPS: Loongson: Remove unused PCI_BAR_COUNT
 definition
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 May 2017 14:55:59 -0500
Message-ID: <20170519195559.25338.30891.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Remove unused PCI_BAR_COUNT definition.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../asm/mach-loongson64/cs5536/cs5536_pci.h        |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
index 8a7ecb4d5c64..bf9dd9eb4ceb 100644
--- a/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
+++ b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
@@ -80,7 +80,6 @@ extern u32 cs5536_pci_conf_read4(int function, int reg);
 #define PCI_BAR3_REG			0x1c
 #define PCI_BAR4_REG			0x20
 #define PCI_BAR5_REG			0x24
-#define PCI_BAR_COUNT			6
 #define PCI_BAR_RANGE_MASK		0xFFFFFFFF
 
 /* CARDBUS CIS POINTER */
