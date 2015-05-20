Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 14:44:57 +0200 (CEST)
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:41456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010189AbbETMoztLBrn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 14:44:55 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 61D459EA1C;
        Wed, 20 May 2015 12:44:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: twig86_82474aed92534
X-Filterd-Recvd-Size: 1789
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 May 2015 12:44:55 +0000 (UTC)
Message-ID: <1432125894.2870.284.camel@perches.com>
Subject: [PATCH] mips: irq: Use DECLARE_BITMAP
From:   Joe Perches <joe@perches.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        John Crispin <blogic@openwrt.org>
Date:   Wed, 20 May 2015 05:44:54 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

Use the generic mechanism to declare a bitmap instead of unsigned long.

This could fix an overwrite defect of whatever follows irq_map.

Not all "#define NR_IRQS <value>" are a multiple of BITS_PER_LONG so
using DECLARE_BITMAP allocates the proper number of longs required
for the possible bits.

For instance:

arch/mips/include/asm/mach-ath79/irq.h:#define NR_IRQS                  51
arch/mips/include/asm/mach-db1x00/irq.h:#define NR_IRQS 152
arch/mips/include/asm/mach-lantiq/falcon/irq.h:#define NR_IRQS 328

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d2bfbc2..51f57d8 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -29,7 +29,7 @@
 int kgdb_early_setup;
 #endif
 
-static unsigned long irq_map[NR_IRQS / BITS_PER_LONG];
+static DECLARE_BITMAP(irq_map, NR_IRQS);
 
 int allocate_irqno(void)
 {
