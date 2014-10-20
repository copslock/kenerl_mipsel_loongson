Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:56:12 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50694 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011966AbaJTUzGn3dPW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:06 +0200
Received: by mail-pa0-f41.google.com with SMTP id eu11so6009939pac.0
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U0ZM3e7ZtNEHKCn/ni2axwJp5bLctriOHDyLrWsyJPg=;
        b=cR1Mjs//lp9Gw6g9J87Zn8AlMbMX3a1Ffrduse/XEnFk52pePFM+1eMh1CQaKO80DM
         oKY9vz12GonR8dZgn2Yr8afoBXKVoCEY8QALCHdRW0xOWwFTFD7dHqFhW8Kf9atI6ipk
         A1Vj+3hEnLOAiUSswRhpWxkYuCOzXgIHIBXrmvzfn9HX/3G3jcE0RoP9YnGcRXc6Lbbm
         62S04cpXNUTy3VEB4B+RZikqVa7jzFKXtZbxM44RVxt1xJoyh6iaJwJDc7SG3NuVOneM
         lILDMOQdquiELu7dRmyoimcutIEcZFvJvsct0L2ugJD/ZBXH0UjC4Hl96FsyZESRnJm6
         setA==
X-Received: by 10.67.13.205 with SMTP id fa13mr6181110pad.118.1413838500781;
        Mon, 20 Oct 2014 13:55:00 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.54.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:55:00 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date:   Mon, 20 Oct 2014 13:54:03 -0700
Message-Id: <1413838448-29464-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This squashes a checkpatch warning on my new bcm3384 dts submission.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/serial/bcm63xx-uart.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..b01c76a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/bcm63xx-uart.txt
@@ -0,0 +1,34 @@
+* BCM63xx UART
+
+Required properties:
+
+- compatible: "brcm,bcm6345-uart"
+
+- reg: The base address of the UART register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clocks: Clock driving the hardware; used to figure out the baud rate
+  divisor.
+
+- clock-names: The appropriate output name in the referenced clock node.
+
+Example:
+
+	uart0: serial@14e00520 {
+		compatible = "brcm,bcm6345-uart";
+		reg = <0x14e00520 0x18>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <2>;
+		clocks = <&periph_clk>;
+		clock-names = "periph";
+	};
+
+	clocks {
+		periph_clk: periph_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+			clock-output-names = "periph";
+		};
+	};
-- 
2.1.1
