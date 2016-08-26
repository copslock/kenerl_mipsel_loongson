Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:25:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25818 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992483AbcHZOWqGcmBn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:22:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 774347ED1EBB5;
        Fri, 26 Aug 2016 15:22:26 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:22:29 +0100
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
Subject: [PATCH v2 16/19] dt-bindings: img-ascii-lcd: Document a binding for simple ASCII LCDs
Date:   Fri, 26 Aug 2016 15:17:48 +0100
Message-ID: <20160826141751.13121-17-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54779
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

Changes in v2:
- Fix filename & path in MAINTAINERS

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
index 0bbe4b1..f7a68b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5953,6 +5953,11 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+IMGTEC ASCII LCD DRIVER
+M:	Paul Burton <paul.burton@imgtec.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
+
 INA209 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.9.3
