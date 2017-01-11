Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 15:31:36 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:54924 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993893AbdAKObXmLfKP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 15:31:23 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MF4EF-1cG6iA2WeR-00GG8c; Wed, 11 Jan 2017 15:31:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mips: update lemote2f_defconfig for CPU_FREQ_STAT change
Date:   Wed, 11 Jan 2017 15:29:49 +0100
Message-Id: <20170111143054.410084-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170111143054.410084-1-arnd@arndb.de>
References: <20170111143054.410084-1-arnd@arndb.de>
X-Provags-ID: V03:K0:NNtDu/VcaHF+yFbjAakxBCqb9JDGZqSnpZthyn2BLQOAJKUoiCK
 J/pou1KWN4BiTowUh13JvR8awgPxeCMEtd2XTUDxI5/GMy4TyoLYeOFcpbJ9dQfX5pnQmho
 uCUAEU0K6ugO9vONbj6z/alS34Qhq/Y3io6lf9UmHCBwPnOY5OAjnI6gbnE4KIjSUweo++n
 Xjgi07hgeym0HE9JFxejQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jhsu/i6iFgM=:leg1ohYBsyQW3LtkbN4U0L
 k1yoHkZf2awo9inGPrAhVUUykF9dvQF5dXa9+men8gxU6LlmfvsjUOr/0Fg9OzczOGJHZ4jV2
 AV+J1u2dMlMnr5prL8mdXodWV2CLS84w/9mYN5srL4bJFdR+lKGkRg7LGi73V6HosDAAPAm1I
 5Bd4b5O+jz1ZDPL/FBtAKh5cdQePBLh03Gyc1nBNNFq+vYXqqkV14OaIzUofwHezoLt5M98W7
 CPXZURwdxIO05jjD6Oxfcr+fp7nA0gCr/IhSaqa9XhgVKxpFkEeKOLWTZlBP9FtY33G2Tx+go
 ji7Httr5WRcENs/60NR1xmSyBWrOqQ8Lo/20r9jzEMNX5c+GpggXsFtruFSA92xmu3DS9Jg8O
 KlIeCLWL2wXCq/0bO3inOHbx4+TPBSzkQRi2IXTZLGcw17FRR7g/NKz6rbk9QyW0GQvbk7rDj
 i2DO9eTXTdyXOiYtXB2+dWU4cGAr9hKv33+Ww3IKJpuXc9cs3SLQATCB7M3BY60KocFelyCuE
 EsBM3hbDli1qshyokQ+3jRpkUg3HtKj+VvY1LGpXHhzDzp3lG21V5i9p4kWSs5p+VHlWfS/Z0
 UiVEXXUS8hdTGOyEpRSWyYMYa5Qws9OO/DdSOg85a9MVOZLXtBHbWaTM1FQ0ouLaX7f7NijHB
 XaLCAwIBKBkyk88nUzwj2C5F+LC8r3zzu8URSAx3So8ymrsS6SZu+TcsiFEDgdmT3d5I=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56262
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

Since linux-4.8, CPU_FREQ_STAT is a bool symbol, causing a warning in
kernelci.org:

arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid for CPU_FREQ_STAT

This updates the defconfig to have the feature built-in.

Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/configs/lemote2f_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 5da76e0e120f..0cdb431bff80 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -39,7 +39,7 @@ CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION="/dev/hda3"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEBUG=y
-CONFIG_CPU_FREQ_STAT=m
+CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
-- 
2.9.0
