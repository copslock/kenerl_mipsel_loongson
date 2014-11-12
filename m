Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 20:44:28 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:57185 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013558AbaKLTnxYZaWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 20:43:53 +0100
Received: by mail-ie0-f202.google.com with SMTP id tr6so2098886ieb.5
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 11:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJJXpfALwZpNEe4LF0i8lzr3DPab4g+J94owMiLr5P8=;
        b=MGqdwi03NvdykOygWiN7acJAhWP/yV+8KHikHz2JRPxBY40BjWxDSMx0eZimk/fTn6
         /Zb3MqczI2h8cJ3yG7Evkz4n2Rz8mDFB9pupFhbJ6kpRoT6eavMG/5pGtsP6mA0VhLDS
         cJtKO1i8cD9a6DS0UgfFn8Wd3Auxdt0ILNAo7z+fWpMY0mErNEp0c3Vas9BZwaQnByAf
         GJkUPfeqCPsHCfYUdYgl9r7MwVB3M1Kf/RKQQ+fEbDkF1tUQdPyMvXGs56lPdNAl867n
         sc9sySbKpuSnJ/fyGeVx6HRZJmUDxJxe5LLAoHiKJQI7fFLnfc9YpYzWM56xwOfujN7B
         /JGQ==
X-Gm-Message-State: ALoCoQlblJI9e64njkRP4bcQwPnRS99dcxC/1jRNDQmFeipB/VCvPgdW75P9q0rRoez+AzUnjY2R
X-Received: by 10.182.240.226 with SMTP id wd2mr37598821obc.6.1415821427520;
        Wed, 12 Nov 2014 11:43:47 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id r6si931600yhg.1.2014.11.12.11.43.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 11:43:47 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id bfkxVGud.1; Wed, 12 Nov 2014 11:43:47 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id A2BBD220C22; Wed, 12 Nov 2014 11:43:45 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/4] of: Add binding document for MIPS GIC
Date:   Wed, 12 Nov 2014 11:43:37 -0800
Message-Id: <1415821419-26974-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44072
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
No changes from v4.
Changes from v3:
 - removed CPU name from compatible string
 - removed available-cpu-vectors, added reserved-cpu-vectors
 - made reg property optional
Changes from v2:
 - added third cell to specify local vs. shared
 - added documentation for timer sub-node
 - changed compatible string to include CPU version
Changes from v1:
 - moved from mips/ to interrupt-controller/
 - removed interrupts and interrupt-parent properties
 - added available-cpu-vectors property
 - dropped third cell in interrupt specifier
---
 .../bindings/interrupt-controller/mips-gic.txt     | 55 ++++++++++++++++++++++
 .../dt-bindings/interrupt-controller/mips-gic.h    |  9 ++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/mips-gic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
new file mode 100644
index 0000000..5a65478
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
@@ -0,0 +1,55 @@
+MIPS Global Interrupt Controller (GIC)
+
+The MIPS GIC routes external interrupts to individual VPEs and IRQ pins.
+It also supports local (per-processor) interrupts and software-generated
+interrupts which can be used as IPIs.  The GIC also includes a free-running
+global timer, per-CPU count/compare timers, and a watchdog.
+
+Required properties:
+- compatible : Should be "mti,gic".
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt specifier.  Should be 3.
+  - The first cell is the type of interrupt, local or shared.
+    See <include/dt-bindings/interrupt-controller/mips-gic.h>.
+  - The second cell is the GIC interrupt number.
+  - The third cell encodes the interrupt flags.
+    See <include/dt-bindings/interrupt-controller/irq.h> for a list of valid
+    flags.
+
+Optional properties:
+- reg : Base address and length of the GIC registers.  If not present,
+  the base address reported by the hardware GCR_GIC_BASE will be used.
+- mti,reserved-cpu-vectors : Specifies the list of CPU interrupt vectors
+  to which the GIC may not route interrupts.  Valid values are 2 - 7.
+  This property is ignored if the CPU is started in EIC mode.
+
+Required properties for timer sub-node:
+- compatible : Should be "mti,gic-timer".
+- interrupts : Interrupt for the GIC local timer.
+- clock-frequency : Clock frequency at which the GIC timers operate.
+
+Example:
+
+	gic: interrupt-controller@1bdc0000 {
+		compatible = "mti,gic";
+		reg = <0x1bdc0000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		mti,reserved-cpu-vectors = <7>;
+
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clock-frequency = <50000000>;
+		};
+	};
+
+	uart@18101400 {
+		...
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
+		...
+	};
diff --git a/include/dt-bindings/interrupt-controller/mips-gic.h b/include/dt-bindings/interrupt-controller/mips-gic.h
new file mode 100644
index 0000000..cf35a57
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/mips-gic.h
@@ -0,0 +1,9 @@
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define GIC_SHARED 0
+#define GIC_LOCAL 1
+
+#endif
-- 
2.1.0.rc2.206.gedb03e5
