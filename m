Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:56:12 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:37439 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993411AbdGUQ4DgeYam (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 18:56:03 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 10EB01A4953;
        Fri, 21 Jul 2017 18:55:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id E30CA1A470A;
        Fri, 21 Jul 2017 18:55:57 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/8] Documentation: Add device tree binding for Goldfish RTC driver
Date:   Fri, 21 Jul 2017 18:53:30 +0200
Message-Id: <1500656111-9520-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59202
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
index 02994f4..847da3f 100644
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
