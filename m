Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 22:57:10 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.135]:53032 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027122AbcELU5J2oSt6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 22:57:09 +0200
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPA (Nemesis) id 0Lzna3-1bf9zb1ybL-0153yH; Thu, 12 May
 2016 22:56:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <balbi@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date:   Thu, 12 May 2016 22:56:17 +0200
Message-Id: <1463086588-2393828-1-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
X-Provags-ID: V03:K0:2WffHOAcIjtD8tCezWEVUyDVQXp+k4RIngSjfjep4rB7gzIUo1c
 vtC3tlAWmZ7SrQwC6COgN36FhZYYWHIJw60dCTim2h4OBEAIK6m1HytqkeyG56cj42nx1Qa
 dzIn9jBFR9LyI7c6SYvuId4vIC8nib4gwQeIG1rOaC4rVtlEbMBJPmW7SS/OlhRhXmw20Rb
 bcFD503v9gt07Ec1AJZCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cQkSeLthu8Q=:usA+l/WNDkeieyGethtLcw
 m1ypdx5b0+KkkXrOOqaIhXMNfUcaKrkvqb3TvFcuX5sD9gMD+mjLmK959PmjfeQMc3redTwVq
 sIZ9OCyIPZ7xs6pugzeBoCU0TueKz37PzYhIcemrQ8hS428zWggLR2oEZDLZWMPBXCMP7q2lK
 GpPQ/Of2QIJaRJYDFkU54XvSv+DNuNZw3dqzskUpxuxZwlvBJd5ptmEYCQXis5iYuF89kzPll
 fBQBUD0tVyoqRyhwH0k3RgaJ0eMK1wOBZTkBj3bfdS7RoLOowB4ZNrzr4rpADPAg5SY6y8qts
 0x5Hnlgm5w/SFLTH+iRZvUO9pZGw69pEfZz8tThVrjznArutoDAOkB/SpKE7sJTmppPoDFIsk
 MZgu5jPJ9vtfjb2PuN3rC27L6rjWSJ3ze4bikrEve8bsLVN22Z/Prey9xp5R3/fSs+4Y6xmuC
 WvdPm9Jw4o6NNnYjPmF2ZaDAmF01dmTqKbOhqydUfPHpmB8zjzB6U6kUnAtTwyKXdUDMyxY7W
 SvSqTO0kG+TaBYBcR4J+lUfRiCC5Xi6ztBi1Q1UglI49BRjsLGdV8BdUhMXq6PFUEspb92/d8
 kFn3E4Op2140P+lMWt7bsJws+Kz3EJerRNJTHjtWTZhTH5nn0WVjiA3suMmwiS2mlM8+LhvSX
 ddDeXIqVQxxi1YJDZzENkU8/a2JRvd8YF3jja60O+MgPLPS8r/Gk5utrWP6d/icfytfw=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53418
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
detection of endianess, to make sure it also works on all other
combinations of architectures and implementations of the usb-dwc2
device. That patch however will be fairly large and not appropriate
for backports to stable kernels.

Felipe suggested a different approach, using an endianess switching
register to always put the device into LE mode, but unfortunately
the dwc2 hardware does not provide a generic way to do that. Also,
I see no practical way of addressing the problem more generally by
patching architecture specific code on MIPS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
---
v3: reverted the accidental changes that slipped into the patch,
    resending as requested by Christian.

 drivers/usb/dwc2/core.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 3c58d633ce80..74ed2ee881cd 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -64,6 +64,18 @@
 	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		\
 				dev_name(hsotg->dev), ##__VA_ARGS__)
 
+
+#ifdef CONFIG_MIPS
+/*
+ * There are some MIPS machines that can run in either big-endian
+ * or little-endian mode and that use the dwc2 register without
+ * a byteswap in both ways.
+ * Unlike other architectures, MIPS does not require a barrier
+ * before the __raw_writel() to synchronize with DMA but does
+ * require the barrier after the writel() to serialize a series
+ * of writes. This set of operations was added specifically for
+ * MIPS and should only be used there.
+ */
 static inline u32 dwc2_readl(const void __iomem *addr)
 {
 	u32 value = __raw_readl(addr);
@@ -90,6 +102,23 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
 	pr_info("INFO:: wrote %08x to %p\n", value, addr);
 #endif
 }
+#else
+/* Normal architectures just use readl/write */
+static inline u32 dwc2_readl(const void __iomem *addr)
+{
+	u32 value = readl(addr);
+	return value;
+}
+
+static inline void dwc2_writel(u32 value, void __iomem *addr)
+{
+	writel(value, addr);
+
+#ifdef dwc2_log_writes
+	pr_info("info:: wrote %08x to %p\n", value, addr);
+#endif
+}
+#endif
 
 /* Maximum number of Endpoints/HostChannels */
 #define MAX_EPS_CHANNELS	16
-- 
2.7.0
