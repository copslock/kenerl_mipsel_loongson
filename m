Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:35:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5397 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992310AbcH3RdcQsID0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:33:32 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DBCF334ED27;
        Tue, 30 Aug 2016 18:33:12 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:33:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/26] dt-bindings: Document mti,mips-cdmm binding
Date:   Tue, 30 Aug 2016 18:29:16 +0100
Message-ID: <20160830172929.16948-14-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54854
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

Document a binding for the MIPS Common Device Memory Map (CDMM) which
simply allows the device tree to specify where the CDMM registers should
be mapped.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt

diff --git a/Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt b/Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt
new file mode 100644
index 0000000..5b0fc40
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt
@@ -0,0 +1,8 @@
+Binding for MIPS Common Device Memory Map (CDMM) bus.
+
+This binding allows a system to specify where the CDMM registers should be
+mapped using device tree.
+
+Required properties:
+compatible : Should be "mti,mips-cdmm".
+regs: Should describe the address & size of the CDMM register region.
-- 
2.9.3
