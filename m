Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 23:55:10 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:33293 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013734AbbCMWyTjGdFS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 23:54:19 +0100
Received: by iecrp18 with SMTP id rp18so7472002iec.0
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 15:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bzs+Zm6R9CdEXe+cZNPS0LZOCaniVGrIwZP8NFiCR4I=;
        b=K8+/Gbau0/kdO9yyDwi7gqHlNjHM3rcodhqOFLIvQeK3bpEx8EVIZvOMFZidJjOHfE
         t6dQuTInrEs2iGpPy0Km3Sxq26akMPoBszZ095fwApt/IXAj84FeioyB5cLBfrK8tXY1
         scYMhi25BeA/ArR4HK3TLi9cH/yNhhmzB0OXNsjMRCgCAJCLE71YQM4eY9sDKpA1A9oy
         DgoTH4xX4Vl2wmsaY5Nz+C41fkYuDGz9cmwtLAiyFMJlGJdVOR8Eh1Ofa+K8XG/uYtJD
         6yOSRD7R2HRF9r+Z2v99nIi7PIX4ua1mmc5MapjFnVC5CqJhwanyCO5iL1Cg6lx1Cwsx
         sSgg==
X-Gm-Message-State: ALoCoQnl1aiei/rPXSrUZOphWqezhfTPnA/WxIyWG+CrVrDnu841gLUD7xgiHikRdAh3oqiVXYOU
X-Received: by 10.43.1.71 with SMTP id np7mr45556574icb.15.1426287254372;
        Fri, 13 Mar 2015 15:54:14 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id u27si191033yhu.4.2015.03.13.15.54.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 15:54:14 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id GtaoT7pW.1; Fri, 13 Mar 2015 15:54:14 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 26105220C28; Fri, 13 Mar 2015 15:54:13 -0700 (PDT)
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
Subject: [PATCH V2 3/5] MIPS: Document Pistachio boot protocol and device-tree bindings
Date:   Fri, 13 Mar 2015 15:54:07 -0700
Message-Id: <1426287249-27185-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
References: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46382
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
