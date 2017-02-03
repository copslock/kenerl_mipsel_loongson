Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 17:44:29 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:54839 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993912AbdBCQoUepDpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 17:44:20 +0100
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MaiO9-1ctqFO3FwP-00K6Jt; Fri, 03 Feb 2017 17:44:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ip27: disable qlge driver in defconfig
Date:   Fri,  3 Feb 2017 17:43:50 +0100
Message-Id: <20170203164409.3580513-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:cvL2PUdwcoxxRRe8CSLbXSAYq6EEjhWBe6T8et2oecTStboQvdx
 dwNXVEoiXMcbSZNP765fU6Px2XE3uHk/TRv9fMW3Rr4AJBiEn1W88r2t80vBzDUaC7A4mbX
 0XftOlgbTf9Z4w/g51RY+XneYsILu8z24MJ2PTbbV4GsI3BiXxitFio3J/W8FgrHDX7GKNt
 czmbNWZO80DWdBeKTvbcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O7wXRHHsxX8=:NuD/EDAFs2bpzpa0D4vF7f
 rf1cHKWqaUI4uEtzbunnJKfFRcSsyrl2xaDgCI2pGZc85pL8yun4b6LvBC5R47PJsHnGL+u2i
 n2gVMpcx8+JtYipBZ+UVGhh6DFLdHeZS9lCByDRqrsgzNskbTTAhm0IDRSg6bbSbDTKHZxDBg
 EW+wHnufqlKceA1TEKushxD8qcXJF9CMGMC1my7dieJcW0CVRmBcIExiksGdBNkLcyzkF5/PB
 oapZiSV/fvw2aO+ds77Kmq0ZzGTowVrul7XYw8m6qChSbpQ7qdmMr/M76+hrHgi48LAIh3CMn
 yczWGxrTzfNDe9nldO7TTOx0QRGAhhF6jWjxR7aNQNzeNdhPe9QhDmWipVDdm8i9EM6a/fXOr
 P7gDbWyjT+8VRfZ1IItE90LfnCby6z4d4fqZztp9J6Cg4JqmV8cacc+MTZtW4hTYQxN1maIoA
 6mi2Vsq8O38LkaUuz+h9SNTUyQw7qdMoKDQk/LUQS/6VzwhXFptx7gOYCAGjsd/Q/RIrdWh30
 dU9B/hO5bbb5bU97bO643JQIibUEj0ibV1uIaOrHSKhprkVriTEmXwTrubVq6d9Sl3StZHUOZ
 guze2SXmLyRbVFtBluIZ6mGGZLDK83dzWZwhlamnOdOcQApQ3Z6nti4HOoUUgBpFzY3k7lgCl
 cY6cRxw4dd+MSKeH+39wxNWxL1Ke3nWRwCH8p8BABw7Os2K6sH1mot41u8u1Vs0nUPZw=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56627
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

One of the last remaining failures in kernelci.org is for a gcc bug:

drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190

This is apparently broken in gcc-6 but fixed in gcc-7, and I cannot reproduce the
problem here. However, it is clear that ip27_defconfig does not actually need
this driver as the platform has only PCI-X but not PCIe, and the qlge adapter
in turn is PCIe-only.

The driver was originally enabled in 2010 along with lots of other drivers.

Fixes: 59d302b342e5 ("MIPS: IP27: Make defconfig useful again.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/configs/ip27_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 18f024967dcd..e582069b44fd 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -205,7 +205,6 @@ CONFIG_MLX4_EN=m
 # CONFIG_MLX4_DEBUG is not set
 CONFIG_TEHUTI=m
 CONFIG_BNX2X=m
-CONFIG_QLGE=m
 CONFIG_SFC=m
 CONFIG_BE2NET=m
 CONFIG_LIBERTAS_THINFIRM=m
-- 
2.9.0
