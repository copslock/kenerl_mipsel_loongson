Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 22:44:16 +0100 (CET)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:32924 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013954AbbCPVnVJfUKs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 22:43:21 +0100
Received: by iecrp18 with SMTP id rp18so11503309iec.0
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 14:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fOj3fWRuScYI1RDedgLyWAHnRZAJRuBkJdCWGNcqhYU=;
        b=CrCzqMC0Fpepmlg6uMzwbIfy3DXK1tS88l+omnSudz/HWfV3IUj3Cy8lsOPRKg8+T3
         Uk0S7SUSNA6ldwv+kQHvIQ+k3lunjGVemBiHdpiuLh5x7QHKj3gQiyX0hmCW8kuXVC3t
         c8uoyOYNr86LfIf2+/OT8wUGiz+NpvrkcSK/1oDkhAq46gcmiMydi0kIYWTsZFqVDmVx
         3N0VXi+xZsKKJ1lC6zwpQESwKIWz+D0BVxqrUkzPiLMgb8e1jVW2rAiXwJFEI7Pruqzu
         5fnIiPAktKQ4Hwlotx9qxorrWsInMGMercVXifmiusmW8hLxrf14rbwj8rScggf3bxqR
         z9DQ==
X-Gm-Message-State: ALoCoQmpiQivJpxkzhE+BePXsUIyNvXLsxdxiUYHWzyQTOAo34jbpB8uA5TdQN9EIuksnRgzOwqA
X-Received: by 10.50.43.229 with SMTP id z5mr11769327igl.3.1426542196122;
        Mon, 16 Mar 2015 14:43:16 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 40si591488yho.6.2015.03.16.14.43.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2015 14:43:16 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id VelUEkWh.1; Mon, 16 Mar 2015 14:43:16 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C68E322057C; Mon, 16 Mar 2015 14:43:14 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH V3 3/5] MIPS: Document Pistachio boot protocol and device-tree bindings
Date:   Mon, 16 Mar 2015 14:43:09 -0700
Message-Id: <1426542191-6883-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1426542191-6883-1-git-send-email-abrestic@chromium.org>
References: <1426542191-6883-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46421
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

The Pistachio SoC boots only with device-tree.  Document the required
properties and nodes as well as the boot protocol between the bootlaoder
and the kernel.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
No changes from v2.
Changes from v1:
 - switched to MIPS UHI hand-off protocol
---
 .../devicetree/bindings/mips/img/pistachio.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio.txt

diff --git a/Documentation/devicetree/bindings/mips/img/pistachio.txt b/Documentation/devicetree/bindings/mips/img/pistachio.txt
new file mode 100644
index 0000000..a736d88
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/img/pistachio.txt
@@ -0,0 +1,42 @@
+Imagination Pistachio SoC
+=========================
+
+Required properties:
+--------------------
+ - compatible: Must include "img,pistachio".
+
+CPU nodes:
+----------
+A "cpus" node is required.  Required properties:
+ - #address-cells: Must be 1.
+ - #size-cells: Must be 0.
+A CPU sub-node is also required for at least CPU 0.  Since the topology may
+be probed via CPS, it is not necessary to specify secondary CPUs.  Required
+propertis:
+ - device_type: Must be "cpu".
+ - compatible: Must be "mti,interaptiv".
+ - reg: CPU number.
+ - clocks: Must include the CPU clock.  See ../../clock/clock-bindings.txt for
+   details on clock bindings.
+Example:
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			reg = <0>;
+			clocks = <&clk_core CLK_MIPS>;
+		};
+	};
+
+
+Boot protocol:
+--------------
+In accordance with the MIPS UHI specification[1], the bootloader must pass the
+following arguments to the kernel:
+ - $a0: -2.
+ - $a1: KSEG0 address of the flattened device-tree blob.
+
+[1] http://prplfoundation.org/wiki/MIPS_documentation
-- 
2.2.0.rc0.207.ga3a616c
