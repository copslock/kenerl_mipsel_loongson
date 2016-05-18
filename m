Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 12:54:45 +0200 (CEST)
Received: from smtpbg340.qq.com ([14.17.44.35]:54525 "EHLO smtpbg340.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029935AbcERKw5HSl-1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 May 2016 12:52:57 +0200
X-QQ-mid: bizesmtp3t1463568751t207t072
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 18 May 2016 18:52:30 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG60000A0000000
X-QQ-FEAT: FRywArojKxa7ncZWH8YfFYUhYKXNfA6Fknmay098qJ35dnzYXKhZZ4LtshW4t
        JCC1TbqFcvafc43jUoN7aSYAoqCesWNr9OB1/M+jxcQ/qvxcHGvWE1Z9QEOff21nDyrnDAE
        0K7NR/272gn7e7ehTmhcQeNoVxvjIhu38p8LyFvBC8P5FNpwy67iN+n7TQXHpjHwc2RnDdp
        66xu9ajZmsUbGRj/UwM4uyi8fYxZf33hqVynoCB5jooGb09KUiy6VU4RIgvImKiOIO0E2Bx
        bdXWm5ogZfH4DDW6VIfF7qlkY=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 8/9] MIPS: Loongson-1B: Update config file
Date:   Wed, 18 May 2016 18:50:00 +0800
Message-Id: <1463568601-25042-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463568601-25042-1-git-send-email-zhoubb@lemote.com>
References: <1463568601-25042-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

CONFIG_LOONGSON1_LS1B=y is needed to be set.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/configs/loongson1b_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index c442f27..476f52b 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -1,4 +1,5 @@
 CONFIG_MACH_LOONGSON32=y
+CONFIG_LOONGSON1_LS1B=y
 CONFIG_PREEMPT=y
 # CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
@@ -43,7 +44,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_LOONGSON1=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=m
@@ -72,7 +72,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GPIOLIB=y
-CONFIG_GPIO_LOONGSON1=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_HID_GENERIC=m
-- 
1.9.1


ÿÿÿÿ	
