Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 09:52:35 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:58289 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990946AbeFPHw2gMtrL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2018 09:52:28 +0200
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5G7oH4S025952;
        Sat, 16 Jun 2018 09:50:17 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: Octeon: add missing of_node_put()
Date:   Sat, 16 Jun 2018 09:49:56 +0200
Message-Id: <1529135396-16728-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64321
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

 The call to of_find_node_by_name inside the do-while-loop is returning
node with refcount incremented thus it must be explicitly decremented
here after usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
commit 93e502b3c2d4 ("MIPS: OCTEON: Platform support for OCTEON III USB controller")
---
Problem located by an experimental coccinelle script

Patch was compile tested with: cavium_octeon_defconfig (implies
CONFIG_USB=y)
(with a number of sparse warnings - not related to the proposed change)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/mips/cavium-octeon/octeon-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index bfdfaf3..76e06b4 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -512,6 +512,7 @@ static int __init dwc3_octeon_device_init(void)
 
 		if (of_device_is_compatible(node, compat_node_name)) {
 			pdev = of_find_device_by_node(node);
+			of_node_put(node);
 			if (!pdev)
 				return -ENODEV;
 
-- 
2.1.4
