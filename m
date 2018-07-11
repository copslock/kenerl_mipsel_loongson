Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 20:35:54 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:57049 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993881AbeGKSfsM5LxV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 20:35:48 +0200
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6BIXR1I004645;
        Wed, 11 Jul 2018 20:33:27 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: generic: fix missing of_node_put()
Date:   Wed, 11 Jul 2018 20:32:45 +0200
Message-Id: <1531333965-7342-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hofrat@osadl.org
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

 of_find_compatible_node() returns a device_node pointer with refcount
incremented and must be decremented explicitly.  
 As this code is using the result only to check presence of the interrupt 
controller (!NULL) but not actually using the result otherwise the 
refcount can be decremented here immediately again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
---

Problem located with an experimental coccinelle script

Patch was compiletested with: 32r1_defconfig (implies generic_defconfig)

Patch is against 4.18-rc4 (localversion-next is next-20180711)

 arch/mips/generic/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 07ec084..a106f81 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -203,6 +203,7 @@ void __init arch_init_irq(void)
 					    "mti,cpu-interrupt-controller");
 	if (!cpu_has_veic && !intc_node)
 		mips_cpu_irq_init();
+	of_node_put(intc_node);
 
 	irqchip_init();
 }
-- 
2.1.4
