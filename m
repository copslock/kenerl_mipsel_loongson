Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:51:37 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58784 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992127AbdFSPtwbJOeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:49:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 717721A2452;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 509EE1A45D1;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 01/10] Documentation: Add device tree binding for Goldfish RTC driver
Date:   Mon, 19 Jun 2017 17:49:31 +0200
Message-Id: <1497887380-13718-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58614
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

Add documentation for DT binding of Goldfish RTC driver. The device
tree key used by OS for binding the driver is "google,goldfish-rtc".

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
