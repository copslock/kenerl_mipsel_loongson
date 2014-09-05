Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:33:43 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:52922 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025901AbaIERam5kfej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:42 +0200
Received: by mail-pa0-f74.google.com with SMTP id lf10so136475pab.5
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kylOHqUj4LTM4vAhvmYxBs//yAeqRBQXZGuNDlzAjTo=;
        b=LF07QL8huPqb0t6P5SK5OYCergU7IRYjj6UAB17e2P/Fg66DX+hHwQct0MaklICDt7
         DgAT4iKujMU5zoa+forETJxFE79sysIao/sYef0Z+CfNfODV9NSaFONJf58+2sIi/6f/
         5UuiNVRdCg1GD/4Ov/vSefBp05AFCGsM+RDB+bYpX/Sc7/H92iD1lBFWbsJmhhbsAFeW
         8C9mWv+731IF3a6GcBU2TL2E11cMuFlH2C2cxZBIgIK1Dl/TrU1jJ4QYOzXQjc1kn710
         yloyyzHo8bS0vKhv177ziEJavYvAvkDo5BBsaiUM0SKHL/8C4cC3u+MST2va+l0XUMwh
         lRDw==
X-Gm-Message-State: ALoCoQk8V0qAWcuNOJxRxOo920kRVZNxXmU+WCaWruibxr68fssFgM62PMZW9SjqFjrz37SpdJga
X-Received: by 10.66.156.232 with SMTP id wh8mr7537423pab.27.1409938237039;
        Fri, 05 Sep 2014 10:30:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id d7si508239yho.2.2014.09.05.10.30.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:36 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D360931C285;
        Fri,  5 Sep 2014 10:30:36 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 97A9F2209EA; Fri,  5 Sep 2014 10:30:36 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/16] of: Add binding document for MIPS GIC
Date:   Fri,  5 Sep 2014 10:30:13 -0700
Message-Id: <1409938218-9026-12-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

The Global Interrupt Controller (GIC) present on certain MIPS systems
can be used to route external interrupts to individual VPEs and CPU
interrupt vectors.  It also supports a timer and software-generated
interrupts.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v1:
 - moved from mips/ to interrupt-controller/
 - removed interrupts and interrupt-parent properties
 - added available-cpu-vectors property
 - dropped third cell in interrupt specifier
---
 .../bindings/interrupt-controller/mips-gic.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
new file mode 100644
index 0000000..81ca911
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
@@ -0,0 +1,39 @@
+MIPS Global Interrupt Controller (GIC)
+
+The MIPS GIC routes external interrupts to individual VPEs and IRQ pins.
+It also supports local (per-processor) interrupts and software-generated
+interrupts which can be used as IPIs.
+
+Required properties:
+- compatible : Should be "mti,global-interrupt-controller"
+- reg : Base address and length of the GIC registers.
+- interrupts : Core interrupts to which the GIC may route external interrupts.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt specifier.  Should be 2.
+  - The first cell is the GIC interrupt number.
+  - The second cell encodes the interrupt flags.
+    See <include/dt-bindings/interrupt-controller/irq.h> for a list of valid
+    flags.
+- mti,available-cpu-vectors : Specifies the list of CPU interrupt vectors
+  to which the GIC may route interrupts.  May contain up to 6 entries, one
+  for each of the CPU's hardware interrupt vectors.  Valid values are 2 - 7.
+
+Example:
+
+	gic: interrupt-controller@1bdc0000 {
+		compatible = "mti,global-interrupt-controller";
+		reg = <0x1bdc0000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mti,available-cpu-vectors = <2>, <3>, <4>, <5>;
+	};
+
+	uart@18101400 {
+		...
+		interrupt-parent = <&gic>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+		...
+	};
-- 
2.1.0.rc2.206.gedb03e5
