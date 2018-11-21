Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:22 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58438 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbeKUWiCjxgI- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:02 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 4BA2420085;
        Thu, 22 Nov 2018 00:38:02 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 09/24] MIPS: OCTEON: octeon-irq: make octeon_irq_ciu3_set_affinity() static
Date:   Thu, 22 Nov 2018 00:37:30 +0200
Message-Id: <20181121223745.22792-10-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Make octeon_irq_ciu3_set_affinity() static.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index cc1d8525e651..f97be32bf699 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2483,8 +2483,8 @@ void octeon_irq_ciu3_mask_ack(struct irq_data *data)
 }
 
 #ifdef CONFIG_SMP
-int octeon_irq_ciu3_set_affinity(struct irq_data *data,
-				 const struct cpumask *dest, bool force)
+static int octeon_irq_ciu3_set_affinity(struct irq_data *data,
+					const struct cpumask *dest, bool force)
 {
 	union cvmx_ciu3_iscx_ctl isc_ctl;
 	union cvmx_ciu3_iscx_w1c isc_w1c;
-- 
2.17.0
