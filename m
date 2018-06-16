Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 09:29:12 +0200 (CEST)
Received: from www.osadl.org ([62.245.132.105]:58042 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990945AbeFPH3FhCLpL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2018 09:29:05 +0200
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5G7QpAQ009199;
        Sat, 16 Jun 2018 09:26:51 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: Octeon: assign bool true/false not 1/0
Date:   Sat, 16 Jun 2018 09:26:32 +0200
Message-Id: <1529133992-15360-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <hofrat@osadl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64320
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

Booleans should be assigned true/false not 1/0 as comparison is not needed

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by scripts/coccinelle/misc/boolinit.cocci
  ./arch/mips/cavium-octeon/octeon-irq.c:817:3-13:
  WARNING: Assignment of bool to 0/1

Patch was compile tested with: cavium_octeon_defconfig
(with a number of sparse warnings - not related to the proposed change)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/mips/cavium-octeon/octeon-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index b3aec10..31be6a9 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -814,7 +814,7 @@ static int octeon_irq_ciu_set_affinity(struct irq_data *data,
 			pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
 
 		if (cpumask_test_cpu(cpu, dest) && enable_one) {
-			enable_one = 0;
+			enable_one = false;
 			__set_bit(cd->bit, pen);
 		} else {
 			__clear_bit(cd->bit, pen);
-- 
2.1.4
