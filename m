Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 19:20:30 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:1212 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992149AbcJERTuzIY6u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 19:19:50 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id A8326626C963C;
        Wed,  5 Oct 2016 18:19:43 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 18:19:44 +0100
Received: from localhost (10.100.200.82) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 18:19:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 03/18] MIPS: PCI: Make pcibios_set_cache_line_size an initcall
Date:   Wed, 5 Oct 2016 18:18:09 +0100
Message-ID: <20161005171824.18014-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161005171824.18014-1-paul.burton@imgtec.com>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.82]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55329
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

In preparation for allowing configurations in which pcibios_init is not
included, make pcibios_set_cache_line_size an initcall. arch_initcall is
used such that it runs before the pcibios_init subsys_initcall for
platforms that continue to use it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 5207c04..30320a4 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -220,7 +220,7 @@ out:
 	       "Skipping PCI bus scan due to resource conflict\n");
 }
 
-static void __init pcibios_set_cache_line_size(void)
+static int __init pcibios_set_cache_line_size(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int lsize;
@@ -238,14 +238,14 @@ static void __init pcibios_set_cache_line_size(void)
 	pci_dfl_cache_line_size = lsize >> 2;
 
 	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+	return 0;
 }
+arch_initcall(pcibios_set_cache_line_size);
 
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose;
 
-	pcibios_set_cache_line_size();
-
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry(hose, &controllers, list)
 		pcibios_scanbus(hose);
-- 
2.10.0
