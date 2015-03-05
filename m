Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 15:34:29 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:61303 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008192AbbCEOe1UuDZ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 15:34:27 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 5 Mar
 2015 17:34:22 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 1/3] MIPS: OCTEON: Add semaphore to serialize bootbus accesses.
Date:   Thu, 5 Mar 2015 17:31:29 +0300
Message-ID: <1425565893-30614-2-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1425565893-30614-1-git-send-email-aleksey.makarov@auriga.com>
References: <1425565893-30614-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Some hardware blocks attached to the OCTEON bootbus run asynchronously
to accesses from the CPUs.  These include MMC/SD host, CF(when using
DMA), and NAND controller.  A bus error, or corrupt data may occur if
a CPU is trying to access a bootbus connected device at the same time
the bus is running asynchronous operations.

To work around these problems we add this semaphore that must be
acquired before initiating bootbus activity.  Subsequent patches will
add users for this.

Signed-off-by: David Daney <david.daney@cavium.com>
[aleksey.makarov@auriga.com: combine the patches]
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c       | 3 +++
 arch/mips/include/asm/octeon/octeon.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a42110e..01130e9 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -51,6 +51,9 @@ extern void pci_console_init(const char *arg);
 
 static unsigned long long MAX_MEMORY = 512ull << 20;
 
+DEFINE_SEMAPHORE(octeon_bootbus_sem);
+EXPORT_SYMBOL(octeon_bootbus_sem);
+
 struct octeon_boot_descriptor *octeon_boot_desc_ptr;
 
 struct cvmx_bootinfo *octeon_bootinfo;
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 0415965..de9f74e 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -335,4 +335,6 @@ void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t);
 
 extern void octeon_fixup_irqs(void);
 
+extern struct semaphore octeon_bootbus_sem;
+
 #endif /* __ASM_OCTEON_OCTEON_H */
-- 
2.3.0
