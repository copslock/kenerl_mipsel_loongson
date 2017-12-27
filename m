Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 15:38:59 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:34541 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990474AbdL0OivKCZr4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Dec 2017 15:38:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id B6AA91A4946;
        Wed, 27 Dec 2017 15:38:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (unknown [10.10.13.43])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 919301A4904;
        Wed, 27 Dec 2017 15:38:45 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        devicetree@vger.kernel.org, Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: Document mti,mips-cpc binding
Date:   Wed, 27 Dec 2017 15:37:51 +0100
Message-Id: <1514385475-23921-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1514385475-23921-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1514385475-23921-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Paul Burton <paul.burton@mips.com>

Document a binding for the MIPS Cluster Power Controller (CPC) that
allows the device tree to specify where the CPC registers are located.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 Documentation/devicetree/bindings/power/mti,mips-cpc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt

diff --git a/Documentation/devicetree/bindings/power/mti,mips-cpc.txt b/Documentation/devicetree/bindings/power/mti,mips-cpc.txt
new file mode 100644
index 0000000..c6b8251
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mti,mips-cpc.txt
@@ -0,0 +1,8 @@
+Binding for MIPS Cluster Power Controller (CPC).
+
+This binding allows a system to specify where the CPC registers are
+located.
+
+Required properties:
+compatible : Should be "mti,mips-cpc".
+regs: Should describe the address & size of the CPC register region.
-- 
2.7.4
