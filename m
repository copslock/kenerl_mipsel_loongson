Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 09:09:19 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:57718 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990945AbeFPHJM58T-o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2018 09:09:12 +0200
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5G76rXb026481;
        Sat, 16 Jun 2018 09:06:53 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: Octeon: add missing of_node_put()
Date:   Sat, 16 Jun 2018 09:06:33 +0200
Message-Id: <1529132793-9872-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64319
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

 The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch found by experimental coccinelle script

Patch was compile tested with: cavium_octeon_defconfig
(with a number of sparse warnings - not related to the proposed change)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/mips/cavium-octeon/octeon-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db4..1d92efb 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -320,10 +320,11 @@ static int __init octeon_ehci_device_init(void)
 	ehci_node = of_find_node_by_name(NULL, "ehci");
 	if (!ehci_node)
 		return 0;
 
 	pd = of_find_device_by_node(ehci_node);
+	of_node_put(ehci_node);
 	if (!pd)
 		return 0;
 
 	pd->dev.platform_data = &octeon_ehci_pdata;
 	octeon_ehci_hw_start(&pd->dev);
@@ -382,10 +383,11 @@ static int __init octeon_ohci_device_init(void)
 	ohci_node = of_find_node_by_name(NULL, "ohci");
 	if (!ohci_node)
 		return 0;
 
 	pd = of_find_device_by_node(ohci_node);
+	of_node_put(ohci_node);
 	if (!pd)
 		return 0;
 
 	pd->dev.platform_data = &octeon_ohci_pdata;
 	octeon_ohci_hw_start(&pd->dev);
-- 
2.1.4
