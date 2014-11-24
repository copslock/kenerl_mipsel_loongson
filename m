Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:37:27 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:59416 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013685AbaKXXgimFekf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:38 +0100
Received: by mail-pd0-f170.google.com with SMTP id fp1so10780199pdb.1
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BM0eaAqoPXGLfSCjZxiUc0YG/ossp/VJr4b/SXUwaNg=;
        b=Hd/4AKjphrL2s/dnIDiT/sO9G2raUhh6qDUtmCADK67avqPQZgN+JUsC4FviPJGOV7
         Ghft7W/YaMaV2B4v2KGwt3HBU9D17tgwwtJeSAiVazZabNghRGlZ33BviID9GU+MWust
         QraLKENz2LLf5qo6NpW/TYfs2W4/QqaHR+dMyO0DIZpy1DcNnsArSg0AMgiBFNq2UiNC
         hf0LQXehpSltP7ON+Wirsq6jZonTq2IuzkZVb/jRVLItTQH6Vv4GxzkI48O9SUKaJ/fV
         2pk+GDbPJR3HDfr1yCMjN8qnjIC+S0YaKdJbMnpSJS02X8cyfG56t/V7K5PfJLeaMw1Z
         8+2w==
X-Received: by 10.70.103.74 with SMTP id fu10mr37691382pdb.53.1416872192717;
        Mon, 24 Nov 2014 15:36:32 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:32 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
Date:   Mon, 24 Nov 2014 15:36:18 -0800
Message-Id: <1416872182-6440-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44415
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

These apply to newly converted drivers, like serial8250/libahci/...
The examples were adapted from the regmap bindings document.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/common-properties.txt

diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
new file mode 100644
index 0000000..21044a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/common-properties.txt
@@ -0,0 +1,60 @@
+Common properties
+
+The ePAPR specification does not define any properties related to hardware
+byteswapping, but endianness issues show up frequently in porting Linux to
+different machine types.  This document attempts to provide a consistent
+way of handling byteswapping across drivers.
+
+Optional properties:
+ - big-endian: Boolean; force big endian register accesses
+   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
+   know the peripheral always needs to be accessed in BE mode.
+ - little-endian: Boolean; force little endian register accesses
+   unconditionally (e.g. readl/writel).  Use this if you know the
+   peripheral always needs to be accessed in LE mode.  This is the
+   default.
+ - native-endian: Boolean; always use register accesses matched to the
+   endianness of the kernel binary (e.g. LE vmlinux -> readl/writel,
+   BE vmlinux -> ioread32be/iowrite32be).  In this case no byteswaps
+   will ever be performed.  Use this if the hardware "self-adjusts"
+   register endianness based on the CPU's configured endianness.
+
+Note that regmap, in contrast, defaults to native-endian.  But this
+document is targeted for existing drivers, most of which currently use
+readl/writel because they expect to be accessing PCI/PCIe devices rather
+than memory-mapped SoC peripherals.  Since the readl/writel accessors
+perform a byteswap on BE systems, this means that the drivers in question
+are implicitly "little-endian".
+
+Examples:
+Scenario 1 : CPU in LE mode & device in LE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      native-endian;
+};
+
+Scenario 2 : CPU in LE mode & device in BE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      big-endian;
+};
+
+Scenario 3 : CPU in BE mode & device in BE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      native-endian;
+};
+
+Scenario 4 : CPU in BE mode & device in LE mode.
+dev: dev@40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      little-endian;
+};
-- 
2.1.0
