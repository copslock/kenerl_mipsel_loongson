Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 20:15:13 +0200 (CEST)
Received: from resqmta-po-10v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:169]:45292
        "EHLO resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbdJQSPEMkKyj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 20:15:04 +0200
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-10v.sys.comcast.net with ESMTP
        id 4WKKeqydxX5P54WLveROja; Tue, 17 Oct 2017 18:12:31 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-14v.sys.comcast.net with SMTP
        id 4WLueAJ5Ctgxr4WLve5aa0; Tue, 17 Oct 2017 18:12:31 +0000
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Add XBRIDGE macro definitions
Message-ID: <f2d67cff-9c44-1456-a328-4d45319d19aa@gentoo.org>
Date:   Tue, 17 Oct 2017 14:12:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOy77DhxVigjxWml3xEJQ+6khEIAfh9wtgVDYhMNdpQVcPUoTHESIIlmXRxV861D2fQYreXmYRHJnTBJyS9MULOG1j6Tg/bkTqhiNs6TxeymrkXM6K2q
 JONaB4L5WVzlhcl7VZ70pd/EEyDp8XplCN0lGQa3930GVuEdRl9qReSFC7o+HFvt1BMowt5rqyb0o2NpfK/Lbfil4fCjroekYQI=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Add macros for the two known XBRIDGE revisions commonly found on IP35
hardware and reportedly on some IP27 hardware.  Both macros are sourced
from the IA64 copy of bridge.h from Linux-2.4.18.  This is for future
patches that will make use of these macros.

Also add a macro for bit 55 of the Crosstalk address to select whether
to use byte-swapping or not.  This bit is specific to XBRIDGE.

Cc: linux-mips@linux-mips.org
Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/pci/bridge.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 3206245d1ed6..7740be3f989e 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -401,6 +401,8 @@ typedef struct bridge_err_cmdword_s {
 #define BRIDGE_REV_B			0x2
 #define BRIDGE_REV_C			0x3
 #define BRIDGE_REV_D			0x4
+#define XBRIDGE_REV_A			0x1
+#define XBRIDGE_REV_B			0x2
 
 /* Bridge widget status register bits definition */
 
@@ -794,6 +796,7 @@ typedef struct bridge_err_cmdword_s {
 #define PCI64_ATTR_PREC		0x0400000000000000
 #define PCI64_ATTR_VIRTUAL	0x0200000000000000
 #define PCI64_ATTR_BAR		0x0100000000000000
+#define PCI64_ATTR_SWAP		0x0080000000000000 /* XBRIDGE only */
 #define PCI64_ATTR_RMF_MASK	0x00ff000000000000
 #define PCI64_ATTR_RMF_SHFT	48
 
