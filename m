Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 02:32:56 +0100 (CET)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:48328 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007089AbbBXBcAsR4AM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 02:32:00 +0100
Received: by mail-ob0-f201.google.com with SMTP id wo20so10025407obc.0
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 17:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Ks95HpOpnEeDLIOTCNpYjsR+Uj2FthTCz3756Rm9uc=;
        b=Ani7aD2rtReUBorMo76foxGQ6z0/MYVJc/DyoyTVunkyHCLZn0qN1vwNghdqlBf9Dg
         DSpChxB+qmL2Rl3jiVMU6E9ra1YcUen4omVZz/mI8WSxjydutbpzDnzO5gPvNi50/OGd
         +rD/N6sqcMJf7R4mrRQNxcmgyvQa4fT/i5VDXIuWi//CFLSPC5gw3sLja4wYCT/w2g+d
         hJVtnNEmRM9Rsly0+1s19AP4wxI5y45QN7ManL7xaKBO1WMF8NkfVptbMXfozAC1okQt
         pKlwjhujIwHCDDqvIJ6QSaRLu54iitOUNB4r+ESiBBtFuXnGPSZ1ZAb+qWeTF1ix9YKC
         YSLw==
X-Gm-Message-State: ALoCoQk5CQ7yvEPSGs1LmvBSldK+uTxwEUgNDGqx4CDNNxaxQNX02FRoBJTbuA7N8RTgriZ3uS7y
X-Received: by 10.50.87.97 with SMTP id w1mr11605461igz.1.1424741514900;
        Mon, 23 Feb 2015 17:31:54 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id q2si6550980qcn.2.2015.02.23.17.31.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 17:31:54 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Axi9fND1.1; Mon, 23 Feb 2015 17:31:54 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 591D6220728; Mon, 23 Feb 2015 17:31:53 -0800 (PST)
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
Subject: [PATCH 3/5] MIPS: Document Pistachio boot protocol and device-tree bindings
Date:   Mon, 23 Feb 2015 17:31:45 -0800
Message-Id: <1424741507-8882-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
References: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45907
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
 .../devicetree/bindings/mips/img/pistachio.txt     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio.txt

diff --git a/Documentation/devicetree/bindings/mips/img/pistachio.txt b/Documentation/devicetree/bindings/mips/img/pistachio.txt
new file mode 100644
index 0000000..18522b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/img/pistachio.txt
@@ -0,0 +1,40 @@
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
+The bootloader must pass the following arguments to the kernel:
+ - $a0: 0x0.
+ - $a1: 0xffffffff.
+ - $a2: Physical address of the flattened device-tree blob.
-- 
2.2.0.rc0.207.ga3a616c
