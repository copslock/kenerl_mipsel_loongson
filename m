Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:44:19 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993052AbeKMWmhraj5x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:42:37 +0100
Date:   Tue, 13 Nov 2018 22:42:37 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
In-Reply-To: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1811132145480.9637@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

The LittleSur board is marked for high memory support and therefore 
clearly must provide a way to have enough memory installed for some to 
be present outside the low 4GiB physical address range.  With the memory 
map of the BCM1250 SOC it has been built around it means over 1GiB of 
actual DRAM, as only the first 1GiB is mapped in the low 4GiB physical 
address range[1].

Complement commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need 
DMA32.") then and also enable ZONE_DMA32 for LittleSur.

References:

[1] "BCM1250/BCM1125/BCM1125H User Manual", Revision 1250_1125-UM100-R,
    Broadcom Corporation, 21 Oct 2002, Section 3: "System Overview",
    "Memory Map", pp. 34-38

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need DMA32.")
---
New in v3.
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

linux-mips-sibyte-littlesur-zone-dma32.diff
Index: linux-20181104-littlesur64-defconfig/arch/mips/Kconfig
===================================================================
--- linux-20181104-littlesur64-defconfig.orig/arch/mips/Kconfig
+++ linux-20181104-littlesur64-defconfig/arch/mips/Kconfig
@@ -805,6 +805,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select ZONE_DMA32 if 64BIT
 
 config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
