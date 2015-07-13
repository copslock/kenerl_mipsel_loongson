Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 18:14:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4942 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010542AbbGMQOuSpff8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 18:14:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BCD9EB4A7F04B;
        Mon, 13 Jul 2015 17:14:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 17:14:44 +0100
Received: from localhost (10.100.200.70) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 17:14:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: PCI: ops-emma2rh: drop nonsensical db_assert
Date:   Mon, 13 Jul 2015 17:14:21 +0100
Message-ID: <1436804062-30041-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.70]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The db_assert call checks whether the bus_num pointer is non-NULL, but
does so after said pointer has been dereferenced by the assignment on
the previous line. Thus the check is pointless & likely to have been
optimised out by the compiler anyway. The check_args function is static
& only ever called from the local file with bus_num being a pointer to
an on-stack variable, so the check seems somewhat overzealous anyway.
Simply remove it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/pci/ops-emma2rh.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/ops-emma2rh.c b/arch/mips/pci/ops-emma2rh.c
index 710aef5..2dc97c4 100644
--- a/arch/mips/pci/ops-emma2rh.c
+++ b/arch/mips/pci/ops-emma2rh.c
@@ -25,7 +25,6 @@
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
-#include <asm/debug.h>
 
 #include <asm/emma/emma2rh.h>
 
@@ -40,10 +39,9 @@
 static int check_args(struct pci_bus *bus, u32 devfn, u32 * bus_num)
 {
 	/* check if the bus is top-level */
-	if (bus->parent != NULL) {
+	if (bus->parent != NULL)
 		*bus_num = bus->number;
-		db_assert(bus_num != NULL);
-	} else
+	else
 		*bus_num = 0;
 
 	if (*bus_num == 0) {
-- 
2.4.5
