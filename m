Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:58:22 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:37555 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993967AbdGUQ5b0Z4gm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 18:57:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id F19051A4A85;
        Fri, 21 Jul 2017 18:57:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id D3A851A4A7C;
        Fri, 21 Jul 2017 18:57:25 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bo Hu <bohu@google.com>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@imgtec.com>,
        dri-devel@lists.freedesktop.org,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 6/8] Documentation: Add device tree binding for Goldfish FB driver
Date:   Fri, 21 Jul 2017 18:53:35 +0200
Message-Id: <1500656111-9520-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59207
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add documentation for DT binding of Goldfish FB driver. The compatible
string used by OS for binding the driver is "google,goldfish-fb".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 .../devicetree/bindings/display/google,goldfish-fb.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt

diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
new file mode 100644
index 0000000..9ce0615
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
@@ -0,0 +1,18 @@
+Android Goldfish framebuffer
+
+Android Goldfish framebuffer device used by Android emulator.
+
+Required properties:
+
+- compatible : should contain "google,goldfish-fb"
+- reg        : <registers mapping>
+- interrupts : <interrupt mapping>
+
+Example:
+
+	goldfish_fb@1f008000 {
+		compatible = "google,goldfish-fb";
+		interrupts = <0x10>;
+		reg = <0x1f008000 0x0 0x100>;
+		compatible = "google,goldfish-fb";
+	};
-- 
2.7.4
