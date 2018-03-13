Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2018 16:32:01 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992212AbeCMPbRVgVpr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2018 16:31:17 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2DB611DA;
        Tue, 13 Mar 2018 15:31:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 079/146] MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()
Date:   Tue, 13 Mar 2018 16:24:06 +0100
Message-Id: <20180313152326.901035436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 791412dafbbfd860e78983d45cf71db603a82f67 upstream.

Reading mips_cpc_base value from the DT allows each platform to
define it according to its needs. This is especially convenient
for MIPS_GENERIC kernel where this kind of information should be
determined in runtime.

Use mti,mips-cpc compatible string with just a reg property to
specify the register location for your platform.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/18513/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-cpc.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -10,6 +10,8 @@
 
 #include <linux/errno.h>
 #include <linux/percpu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/spinlock.h>
 
 #include <asm/mips-cps.h>
@@ -22,6 +24,17 @@ static DEFINE_PER_CPU_ALIGNED(unsigned l
 
 phys_addr_t __weak mips_cpc_default_phys_base(void)
 {
+	struct device_node *cpc_node;
+	struct resource res;
+	int err;
+
+	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
+	if (cpc_node) {
+		err = of_address_to_resource(cpc_node, 0, &res);
+		if (!err)
+			return res.start;
+	}
+
 	return 0;
 }
 
