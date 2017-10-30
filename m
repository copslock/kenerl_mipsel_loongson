Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 12:59:19 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:51203 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992215AbdJ3L6jJUn2C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Oct 2017 12:58:39 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E707F1A2403;
        Mon, 30 Oct 2017 12:58:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id CAFF31A2006;
        Mon, 30 Oct 2017 12:58:32 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@mips.com>,
        dri-devel@lists.freedesktop.org,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 3/5] Documentation: Add device tree binding for Goldfish FB driver
Date:   Mon, 30 Oct 2017 12:56:34 +0100
Message-Id: <1509364642-21771-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60588
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

Add documentation for DT binding of Goldfish FB driver. The compatible
string used by OS for binding the driver is "google,goldfish-fb".

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/google,goldfish-fb.txt  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt

diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
new file mode 100644
index 0000000..751fa9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
@@ -0,0 +1,17 @@
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
+	display-controller@1f008000 {
+		compatible = "google,goldfish-fb";
+		interrupts = <0x10>;
+		reg = <0x1f008000 0x100>;
+	};
-- 
2.7.4
