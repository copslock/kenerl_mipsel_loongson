Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:42:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30635 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992722AbcHIMk0sXkk4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:40:26 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8579E6396A017;
        Tue,  9 Aug 2016 13:40:07 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:40:10 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 17/20] dt-bindings: img-ascii-lcd: Document a binding for simple ASCII LCDs
Date:   Tue, 9 Aug 2016 13:35:42 +0100
Message-ID: <20160809123546.10190-18-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add documentation for a devicetree binding for the simple ASCII LCD
displays found on development boards such as the MIPS Boston, MIPS Malta
& MIPS SEAD3 from Imagination Technologies.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 .../devicetree/bindings/auxdisplay/img-ascii-lcd.txt    | 17 +++++++++++++++++
 MAINTAINERS                                             |  5 +++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt

diff --git a/Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt b/Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
new file mode 100644
index 0000000..b69bb68
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
@@ -0,0 +1,17 @@
+Binding for ASCII LCD displays on Imagination Technologies boards
+
+Required properties:
+- compatible : should be one of:
+    "img,boston-lcd"
+    "mti,malta-lcd"
+    "mti,sead3-lcd"
+
+Required properties for "img,boston-lcd":
+- reg : memory region locating the device registers
+
+Required properties for "mti,malta-lcd" or "mti,sead3-lcd":
+- regmap: phandle of the system controller containing the LCD registers
+- offset: offset in bytes to the LCD registers within the system controller
+
+The layout of the registers & properties of the display are determined
+from the compatible string, making this binding somewhat trivial.
diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..d08cf6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1971,6 +1971,11 @@ S:	Maintained
 F:	Documentation/hwmon/asc7621
 F:	drivers/hwmon/asc7621.c
 
+ASCII LCD DRIVER
+M:	Paul Burton <paul.burton@imgtec.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/ascii-lcd.txt
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user@lists.sourceforge.net
-- 
2.9.2
