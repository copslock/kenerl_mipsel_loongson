Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 03:44:57 +0200 (CEST)
Received: from smtpbg65.qq.com ([103.7.28.233]:15553 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27030384AbcESBndMmz-0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2016 03:43:33 +0200
X-QQ-mid: bizesmtp3t1463622169t453t168
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 19 May 2016 09:42:48 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG70000A0000000
X-QQ-FEAT: 6dXuswn9i1XTHYHdJBZ6C4BORxEpxCXm1cT5KuV7HA+gOEQPOmDRvA2emytjb
        8jR+fTeZg5Wrc6EeTG+FEvFwLI7Xp1b+o972Bu7JG6fh3wwMZRmGKMDC6L/G+lRUfqgSuKY
        uwGLMEX2tZK6DcORuwxxBGzXfY46PNR8ZA6mVNY0ceMwlvP/NNMG5olNwhP8MGUjQBeJKdz
        txcuc7hWqy4LXNH1NtFz1Pjov/gFsdAhYOVKf11nhoSeUDzDmVyOX0NKeaGn56GgtSuo1sw
        lIC0WCDFCWfFw3lPnAoSomxo4=
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
Subject: [PATCH RESEND v4 8/9] MIPS: Loongson-1B: Update config file
Date:   Thu, 19 May 2016 09:38:31 +0800
Message-Id: <1463621912-9883-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53535
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

CONFIG_LOONGSON1_LS1B=y is needed to be set, while Loongson-1A is added.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/configs/loongson1b_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index c442f27..7b8ac02 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -1,4 +1,5 @@
 CONFIG_MACH_LOONGSON32=y
+CONFIG_LOONGSON1_LS1B=y
 CONFIG_PREEMPT=y
 # CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
-- 
1.9.1




[i
