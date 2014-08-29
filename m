Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:14:52 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:62706 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007387AbaH2WOuoLewu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:50 +0200
Received: by mail-pa0-f74.google.com with SMTP id lj1so1500137pab.5
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xEDLAlec4IVh8o1aCW1G/VF84xLi2pRWMO4VzSo8Ads=;
        b=W6S0d/M3iZ2xjNeR7wGc3gV1ZTUDPhza9COahmMXDg9t4FTlVOkmMQgV7dzExiObWl
         D7eLwxSQaPJ/VHWVm+j7tophnOXqGSQ7pTv/jqeqE6a52KUxlYgdBtPahKQ6dWaPR4Sp
         a8MKRCRjez/usxJOL5lHdVOkmQCkpywbCY5qWydCxubskR4gQSqGg2X8Ta9M5eQHhxxv
         efPE0MiwWrOFh33LNfQzC6DNB8J7SRqTlhTt+NRKTB3Z1K6C7j/+sNnMjhawOg4LvmQE
         B8V4hppJE6INKVjTY1NLyAcriuyUsELJZIPYRdYgdz5Y8cf2ZSYizPhF5oOykbi3M7xr
         rQvA==
X-Gm-Message-State: ALoCoQmgR48RekL4YqIipPwnbxq95j62EtKAul4HfwAje3uo+CUFUYGujMQSmPYDN4PhLU7M29w0
X-Received: by 10.66.252.6 with SMTP id zo6mr7400607pac.40.1409350484029;
        Fri, 29 Aug 2014 15:14:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j25si1440yhb.0.2014.08.29.15.14.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:43 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CCD9B31C514;
        Fri, 29 Aug 2014 15:14:43 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 86D49221060; Fri, 29 Aug 2014 15:14:43 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] of: Add binding document for MIPS GIC
Date:   Fri, 29 Aug 2014 15:14:30 -0700
Message-Id: <1409350479-19108-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42323
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
 Documentation/devicetree/bindings/mips/gic.txt | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/gic.txt

diff --git a/Documentation/devicetree/bindings/mips/gic.txt b/Documentation/devicetree/bindings/mips/gic.txt
new file mode 100644
index 0000000..725f1ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/gic.txt
@@ -0,0 +1,50 @@
+MIPS Global Interrupt Controller (GIC)
+
+The MIPS GIC routes external interrupts to individual VPEs and IRQ pins.
+It also supports a timer and software-generated interrupts which can be
+used as IPIs.
+
+Required properties:
+- compatible : Should be "mti,global-interrupt-controller"
+- reg : Base address and length of the GIC registers.
+- interrupts : Core interrupts to which the GIC may route external interrupts.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt specifier.  Should be 3.
+  - The first cell is the GIC interrupt number.
+  - The second cell encodes the interrupt flags.
+    See <include/dt-bindings/interrupt-controller/irq.h> for a list of valid
+    flags.
+  - The optional third cell indicates which CPU interrupt vector the GIC
+    interrupt should be routed to.  It is a 0-based index into the list of
+    GIC-to-CPU interrupts specified in the "interrupts" property described
+    above.  For example, a '2' in this cell will route the interrupt to the
+    3rd core interrupt listed in 'interrupts'.  If omitted, the interrupt will
+    be routed to the 1st core interrupt.
+
+Example:
+
+	cpu_intc: interrupt-controller@0 {
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	gic: interrupt-controller@1bdc0000 {
+		compatible = "mti,global-interrupt-controller";
+		reg = <0x1bdc0000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		interrupt-parent = <&cpu_intc>;
+		interrupts = <3>, <4>;
+	};
+
+	uart@18101400 {
+		...
+		interrupt-parent = <&gic>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH 0>;
+		...
+	};
-- 
2.1.0.rc2.206.gedb03e5
