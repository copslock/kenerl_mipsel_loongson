Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:01:51 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:38758 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009908AbaLYR5al6vR6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:30 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so12020448pab.14;
        Thu, 25 Dec 2014 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+lePaPtYFMcZVD9k1l2bNtR4oD3W7sKejs/s4zH17FM=;
        b=TzrzsV7biKht+WuMoU7hojLy7QSFl5aIzwUGFPI++PZM0WcgqyIS2aJOfnhdbFa0W5
         IXI01XDxw6ehVLV+ldVnFXUM4xTxzEZiyFxiOGxtvdf2yIWFUsja4VvYlhwPXTLI1lsU
         y6AmSsqra2YtEFOkZAO/vI60iBKZ5V17XBzu0tkA6ANiwpXXOzJkomkLL+V+syKOp8k3
         YenlgRKa6MF1aNDVCOI5PSRrLUCnvg2WnInad0qcZAHOqA6lveX/nuH3BEZEk+uRvC37
         GWS4oyX5Kergim8sIAP7uDI93I4p0GH8LtaCMaCWLDL5iNSKEUeGAdnjTzqT+OOM49T1
         uGGg==
X-Received: by 10.68.134.164 with SMTP id pl4mr62035074pbb.128.1419530245071;
        Thu, 25 Dec 2014 09:57:25 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:24 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 16/25] MIPS: BMIPS: Document the firmware->kernel DTB interface
Date:   Thu, 25 Dec 2014 09:49:11 -0800
Message-Id: <1419529760-9520-17-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44926
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

Add a new section covering the Generic BMIPS machine type.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/devicetree/booting-without-of.txt | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index 7768518..e49e423 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -15,6 +15,7 @@ Table of Contents
     1) Entry point for arch/arm
     2) Entry point for arch/powerpc
     3) Entry point for arch/x86
+    4) Entry point for arch/mips/bmips
 
   II - The DT block format
     1) Header
@@ -288,6 +289,33 @@ it with special cases.
   or initrd address. It simply holds information which can not be retrieved
   otherwise like interrupt routing or a list of devices behind an I2C bus.
 
+4) Entry point for arch/mips/bmips
+----------------------------------
+
+  Some bootloaders only support a single entry point, at the start of the
+  kernel image.  Other bootloaders will jump to the ELF start address.
+  Both schemes are supported; CONFIG_BOOT_RAW=y and CONFIG_NO_EXCEPT_FILL=y,
+  so the first instruction immediately jumps to kernel_entry().
+
+  Similar to the arch/arm case (b), a DT-aware bootloader is expected to
+  set up the following registers:
+
+         a0 : 0
+
+         a1 : 0xffffffff
+
+         a2 : Physical pointer to the device tree block (defined in chapter
+         II) in RAM.  The device tree can be located anywhere in the first
+         512MB of the physical address space (0x00000000 - 0x1fffffff),
+         aligned on a 64 bit boundary.
+
+  Legacy bootloaders do not use this convention, and they do not pass in a
+  DT block.  In this case, Linux will look for a builtin DTB, selected via
+  CONFIG_DT_*.
+
+  This convention is defined for 32-bit systems only, as there are not
+  currently any 64-bit BMIPS implementations.
+
 II - The DT block format
 ========================
 
-- 
2.1.1
