Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:49:26 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:55145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993936AbdEETs5RRICp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:48:57 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LhoMU-1dtYMp1sSQ-00nC51; Fri, 05 May 2017 21:48:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3.16-stable 82/87] MIPS: ip27: Disable qlge driver in defconfig
Date:   Fri,  5 May 2017 21:47:40 +0200
Message-Id: <20170505194745.3627137-83-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
X-Provags-ID: V03:K0:152sBavXcMnJxzUxW+E9tC28GyitrFZPaEAewDl3q8rgWdJa2C3
 WpLr82i+gSktqTrJc300VLd4osQMMTGjcjWDWPooEe4pe0R1EagpYFsQwZfubeNKiFhFAcQ
 jUHRXSZoFRz52MPeBKkLLCHwIzvTS3zivdduuVfu2j4rtED394eLm1RTT+E8S4LtxGBZwBY
 kwjAaKoKrx8N2DI//VKeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HprlHVCSEIc=:X7q7bnlmkZV0T3wR0vQ0Hn
 51rS+YGHcNaErJvADWPlQ7eMR4wEGMv5+6QaMey8t0Td+pDXoeuEAbCTg+XkM8DppcbpkliHd
 81E69UNb3a4S6mdRLdx8pYwCYN+FolVZGiHO/qyzx9qgBqGggVW/YoQxKHkKnAbpapBvK6NSN
 pcF8cVKKXpuVTVWlVIgw+6oUZcxL9FMmdvNMpPFkZxL3d5bX8cbiIcz2VWVTZWAdawDXIx7k4
 0cmpxxzMB6Te9QleWyzOlCJFqmaauRzDKyrrHKHTP+PTLammbIIt5kbHYqIXdpSvVsIzTSxRj
 LDdrATYqrb6Jdt289I9/F/GqyVMnncJgUEA3QcVX38GKxov4DuOkNMCPABLSSsSQkCjZswap5
 qbpni8fnrhNwCNMboDSbZNFaWOdXaVrY5mNX0N2+0BKRWUwsGwAa2oP547zDfm0/sjlRb3kxC
 G3FIb6bcU3131JqtJJ1Lg+ihZQoWjxWIeZOHX8J3m4R94Xt5nn+4jW67xO1Uw9A68ebs7gijt
 47fXfB4cbdHpDL64sOxN+5IwNe2XFHWk07SdZ0nIkTL/cwr1ubIGxBXvAZAX5zHGoWseBPqQ/
 sUIzACGH7+B1+OFO0P8qo+iO7enpitvaA7++EfR5n1/vf58sm8yRrZju2DJLOaC/FSaDXDye9
 AAz9/GJcOtTuhHPbyg+sUPXSLJP82E+OOMp92aE370Uib7kOco1wztttg+OmetQOluMk=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57854
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

Commit c64ebe32d3fc90c52277257d6c9fa7d589877cc2 upstream.

One of the last remaining failures in kernelci.org is for a gcc bug:

drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190

This is apparently broken in gcc-6 but fixed in gcc-7, and I cannot
reproduce the problem here. However, it is clear that ip27_defconfig
does not actually need this driver as the platform has only PCI-X but
not PCIe, and the qlge adapter in turn is PCIe-only.

The driver was originally enabled in 2010 along with lots of other
drivers.

Fixes: 59d302b342e5 ("MIPS: IP27: Make defconfig useful again.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15197/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/configs/ip27_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 0e36abcd39cc..7446284dd7b3 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -206,7 +206,6 @@ CONFIG_MLX4_EN=m
 # CONFIG_MLX4_DEBUG is not set
 CONFIG_TEHUTI=m
 CONFIG_BNX2X=m
-CONFIG_QLGE=m
 CONFIG_SFC=m
 CONFIG_BE2NET=m
 CONFIG_LIBERTAS_THINFIRM=m
-- 
2.9.0
