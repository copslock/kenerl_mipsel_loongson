Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:52:00 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58802 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992143AbdFSPt5h4S1H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:49:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id D6F0A1A46A9;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id B70C01A46E6;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 06/10] Documentation: Add device tree binding for Goldfish FB driver
Date:   Mon, 19 Jun 2017 17:49:36 +0200
Message-Id: <1497887380-13718-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58615
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

Add documentation for DT binding of Goldfish FB driver. The device
tree key used by OS for binding the driver is "google,goldfish-fb".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 .../bindings/goldfish/google,goldfish-fb.txt           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/goldfish/google,goldfish-fb.txt

diff --git a/Documentation/devicetree/bindings/goldfish/google,goldfish-fb.txt b/Documentation/devicetree/bindings/goldfish/google,goldfish-fb.txt
new file mode 100644
index 0000000..9ce0615
--- /dev/null
+++ b/Documentation/devicetree/bindings/goldfish/google,goldfish-fb.txt
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
