Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:25:19 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:64138 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993907AbdAQPXEIIRcd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:23:04 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MPMZc-1cP5jd2TZo-004WJp; Tue, 17 Jan 2017 16:21:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] MIPS: ip22: fix ip28 build for modern gcc
Date:   Tue, 17 Jan 2017 16:18:46 +0100
Message-Id: <20170117151911.4109452-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:D++CXBECm0fPqgmZQ9uQo82wPd+Otq872mb6tfrldDUPZLYip46
 noIydWKHri2w2MEytDBD6uNL31iXpfBRLuqAJ0ztjUc/FQpXl8NBCNmJ0sEtPrp8RyicNJr
 UfhiM1phZO4bThXRTyKSBkGPiVSphfUBemJPbwttZMfRdz2S6Gcxoif5i4H9anhRGpa7Xmb
 GTRZyf5AB0+2Ny5e5p1Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yFSx64u/hzI=:XiS3JGEilFFpjhh6quYNnZ
 VMFkbzyeIF7q3+ZeD/gaCwmmww5CHIhyGXmshi6fxY/JwO1xxkLdfWLqpIUU7/lD2kkcCRxYH
 UL19+EDfHAqq7R11r1qDLpnpIk2Cdoqrd+qhODrZ7cLq3xkc8HkmaR7G8quPCnRy9TtAYZ6QR
 L9K0dYS59tgJQOsSWbQ44BTKRph200U6558m12R7bD86fGAstiCyIuPEq4NMMjvHVZNWdxcdp
 q238d7XaUyEgcfg2JxT7c6vhrs68u1jcDnTMc3gGByz9XZoEiGhGFrUgyLenRSxnn77taqGLj
 LmDA0EGf9FkuI0SmIbFBt5NkhhC2aRwUA11xgLTGxHLCNYWeuf9CqyeofvT9oP/SriuWjRzth
 Coh9HDtIt2tttfkP39rkWXqfnLd+5hdQ2dVg1Kf8slDc2g+GUcgIrUmAgUbP1AL1U4QhxNEO3
 ZEqBpjKu2KBkyjg+VwWrIGVaJZjMDBaffFzdSWHYxO2QPTvU5qC1ReNnw+TRhg5aZExMchLPI
 6PybvIkZ8QO5Dm8fX0B51qJW3xQrRh/oy9R6WFjpzKOI58/QqSx2nSSTEcZSMumZd6qMqM+K3
 5357MjIXs1MGeT/4zH2G7Dy/q4cJIJ00mrIIj4oWoWC2f0vlBo9AvGBVkmaYjdmv4ik43v5e4
 q0zBL2wtrqL3bDICTn/rF9KPyL0icYi8WMSfloXUyaAMmGDnTAR3CD5XdHwTL9BAGw5w=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56355
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

kernelci reports a failure of the ip28_defconfig build after upgrading its
gcc version:

arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.

The problem apparently is that the -mr10k-cache-barrier=store option is now
rejected for CPUs other than r10k. Explicitly including the CPU in the
check fixes this and is safe because both options were introduced in
gcc-4.4.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/sgi-ip22/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
index b7a4b7e04c38..e8f6b3a42a48 100644
--- a/arch/mips/sgi-ip22/Platform
+++ b/arch/mips/sgi-ip22/Platform
@@ -25,7 +25,7 @@ endif
 # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
 #
 ifdef CONFIG_SGI_IP28
-  ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
+  ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
   endif
 endif
-- 
2.9.0
