Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:36:50 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:52103 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbdF1Pgn44PP8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:36:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 4263F1A46C0
        for <linux-mips@linux-mips.org>; Wed, 28 Jun 2017 17:36:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 2031C1A46D2
        for <linux-mips@linux-mips.org>; Wed, 28 Jun 2017 17:36:38 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v2 01/10] Documentation: Add device tree binding for Goldfish RTC driver
Date:   Wed, 28 Jun 2017 17:36:18 +0200
Message-Id: <1498664187-27995-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498664187-27995-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664187-27995-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58849
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

Add documentation for DT binding of Goldfish RTC driver. The compatible
string used by OS for binding the driver is "google,goldfish-rtc".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 .../devicetree/bindings/rtc/google,goldfish-rtc.txt     | 17 +++++++++++++++++
 MAINTAINERS                                             |  5 +++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt b/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
new file mode 100644
index 0000000..634312d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
@@ -0,0 +1,17 @@
+Android Goldfish RTC
+
+Android Goldfish RTC device used by Android emulator.
+
+Required properties:
+
+- compatible : should contain "google,goldfish-rtc"
+- reg        : <registers mapping>
+- interrupts : <interrupt mapping>
+
+Example:
+
+	goldfish_timer@9020000 {
+		compatible = "google,goldfish-rtc";
+		reg = <0x9020000 0x1000>;
+		interrupts = <0x3>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 09b5ab6..519cdef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,6 +841,11 @@ S:	Supported
 F:	drivers/android/
 F:	drivers/staging/android/
 
+ANDROID GOLDFISH RTC DRIVER
+M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
+
 ANDROID ION DRIVER
 M:	Laura Abbott <labbott@redhat.com>
 M:	Sumit Semwal <sumit.semwal@linaro.org>
-- 
2.7.4
