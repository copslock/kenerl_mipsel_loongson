Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 15:53:21 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.187]:61384 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028609AbcEMNxUTGWmz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 15:53:20 +0200
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPA (Nemesis) id 0Lpzr1-1bV2Dy0g7z-00ffQK; Fri, 13 May
 2016 15:52:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date:   Fri, 13 May 2016 15:52:27 +0200
Message-Id: <1463147559-544140-1-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
X-Provags-ID: V03:K0:1hCh6XX/NeVvqiL2M429ILwY13Ug1IGn1GPnWz5GxL9ItB+IywS
 +U0fV8SdJqg/PZoE5PE/UL431M9/DA1KjaCIc7iibQslEEcsr8Tf/h77uDNpDyzxf+1ApD6
 4qOlSY/FobCw3RIQMMceaHxxtYQw+f+9sQMLyrzQ1cU4isOgY5fCPmpVRxtTH3q94vGYH7x
 rBOmxLc4Lq41J+snotWdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DE76BD+zPDw=:BkRilqKMVPK+AcQRzD63qC
 TbhN/fbiRjPpRIXWe0rgwQGI9O3h8WkLjIkbNGsEAni0apZ3Qy7qWOPJm0XCUVv2Pwgr6xvHQ
 C1tID4lm4U/nRAxdcJ++vlBdCQd3jEgkGha2HEXnP0PBKwU6MGX4rBThz/9GkWYuQo3tGqC3O
 bG6TO1FPtfh/jCK54HCc6n3nqAFqWr3emSuYyts0xCwQ0ZB7kaoWKcrnsL463fHFpoFISIuRK
 tpOdGy0TXupyWBBFPlxCB7ksjOmCZV2gDCzFyRmn1aqXeFb7HdijZ7ZTEMrRwIBNLlUwXVsm1
 FL8D52WM/RaML3ISRgS8hOhlbRwxn/3xcEveotawNu/H211wHlLBAsRE6cJD5rLuUk7oweCkn
 b2LxhJW3R75aQ3pG7PIJI/x2iCvgZxPDcBbxnOtiGb5U/25+OP5OPARekPIgdkf5y7/pbUSEB
 8f/l7eAgOYAfP94stqnP8sXNxNCQvx8XDxoMf4iWm2raViCllGC6SReiHjAEJ+N0YL1utSmPJ
 puZHxCK/7piSy1dL8pcf4N/GBy/v3RkBJ+soNR+2XYfZ+leGelAly/SMvy7n2M503gj5o/mwf
 7ePAn5goBWIKBg2La4jyDY9bjF0SZZ9E9ZjOscOwLHdSI/jEUIQhxODqubPyNwuu5f2t9+27/
 ZwXwIyXDySmLcEgQuOT1GCH36q2gJzFrcEyOIL3NpNkWMCqzUJFyTW6klFH9Ez55lU6E=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

A patch that went into Linux-4.4 to fix big-endian mode on a Lantiq
MIPS system unfortunately broke big-endian operation on PowerPC
APM82181 as reported by Christian Lamparter, and likely other
systems.

It actually introduced multiple issues:

- it broke big-endian ARM kernels: any machine that was working
  correctly with a little-endian kernel is no longer using byteswaps
  on big-endian kernels, which clearly breaks them.
- On PowerPC the same thing must be true: if it was working before,
  using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
  usually uses big-endian kernels, so they are likely all broken.
- The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
  so the MMIO no longer synchronizes with DMA operations.
- On architectures that require specific CPU instructions for MMIO
  access, using the __raw_ variant may turn this into a pointer
  dereference that does not have the same effect as the readl/writel.

This patch is a simple revert for all architectures other than MIPS,
in the hope that we can more easily backport it to fix the regression
on PowerPC and ARM systems without breaking the Lantiq system again.

We should follow this up with a more elaborate change to add runtime
detection of endianness, to make sure it also works on all other
combinations of architectures and implementations of the usb-dwc2
device. That patch however will be fairly large and not appropriate
for backports to stable kernels.

Felipe suggested a different approach, using an endianness switching
register to always put the device into LE mode, but unfortunately
the dwc2 hardware does not provide a generic way to do that. Also,
I see no practical way of addressing the problem more generally by
patching architecture specific code on MIPS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
---
 drivers/usb/dwc2/core.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 3c58d633ce80..dec0b21fc626 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -64,6 +64,17 @@
 	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		\
 				dev_name(hsotg->dev), ##__VA_ARGS__)
 
+#ifdef CONFIG_MIPS
+/*
+ * There are some MIPS machines that can run in either big-endian
+ * or little-endian mode and that use the dwc2 register without
+ * a byteswap in both ways.
+ * Unlike other architectures, MIPS apparently does not require a
+ * barrier before the __raw_writel() to synchronize with DMA but does
+ * require the barrier after the __raw_writel() to serialize a set of
+ * writes. This set of operations was added specifically for MIPS and
+ * should only be used there.
+ */
 static inline u32 dwc2_readl(const void __iomem *addr)
 {
 	u32 value = __raw_readl(addr);
@@ -90,6 +101,22 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
 	pr_info("INFO:: wrote %08x to %p\n", value, addr);
 #endif
 }
+#else
+/* Normal architectures just use readl/write */
+static inline u32 dwc2_readl(const void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static inline void dwc2_writel(u32 value, void __iomem *addr)
+{
+	writel(value, addr);
+
+#ifdef DWC2_LOG_WRITES
+	pr_info("info:: wrote %08x to %p\n", value, addr);
+#endif
+}
+#endif
 
 /* Maximum number of Endpoints/HostChannels */
 #define MAX_EPS_CHANNELS	16
-- 
2.7.0
