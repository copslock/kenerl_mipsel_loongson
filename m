Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Oct 2008 14:02:35 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:47799 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S21283832AbYJLNCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Oct 2008 14:02:33 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 165815BC024;
	Sun, 12 Oct 2008 16:02:31 +0300 (EEST)
Date:	Sun, 12 Oct 2008 16:01:35 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Florian Fainelli <florian@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] mips/pci/fixup-rc32434.c must #include
	<asm/mach-rc32434/irq.h>
Message-ID: <20081012130135.GK31153@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following compile error caused by
commit 606a083b1e1a357cb66454e4581b80f1a67d8368
(MIPS: RB532: Cleanup the headers again):

<--  snip  -->

...
  CC      arch/mips/pci/fixup-rc32434.o
arch/mips/pci/fixup-rc32434.c: In function 'pcibios_map_irq':
arch/mips/pci/fixup-rc32434.c:46: error: 'GROUP4_IRQ_BASE' undeclared (first use in this function)
arch/mips/pci/fixup-rc32434.c:46: error: (Each undeclared identifier is reported only once
arch/mips/pci/fixup-rc32434.c:46: error: for each function it appears in.)
make[2]: *** [arch/mips/pci/fixup-rc32434.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

diff --git a/arch/mips/pci/fixup-rc32434.c b/arch/mips/pci/fixup-rc32434.c
index 75b90dc..3d86823 100644
--- a/arch/mips/pci/fixup-rc32434.c
+++ b/arch/mips/pci/fixup-rc32434.c
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 
 #include <asm/mach-rc32434/rc32434.h>
+#include <asm/mach-rc32434/irq.h>
 
 static int __devinitdata irq_map[2][12] = {
 	{0, 0, 2, 3, 2, 3, 0, 0, 0, 0, 0, 1},
