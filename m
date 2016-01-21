Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 14:05:02 +0100 (CET)
Received: from smtpbgau2.qq.com ([54.206.34.216]:44931 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009614AbcAUNE7a35lu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 14:04:59 +0100
X-QQ-mid: bizesmtp15t1453381479t992t16
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jan 2016 21:04:12 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: K9kKVgGrj/pJkMqj6IbwGt2hSIu3CADQwaRy4f/S5SAK+oRny7cqoM/KD9L0Q
        FItPxDupkE96NmI9oQ0jLimtJ+ur6RKolueBp46Cnh5YtMAgL59J/HzoOlJWb5W50DdC917
        lqHNuQQuwoqQg+RCLhXx/6kpI3Ihr71dHTz+ztF15cCSGdPlUhIznpEx+gI/FLGogWeJ7aU
        2sHGyvDUhC+V5evI8jocZnFHpJap9gaEydcu/ZIHhY3waAKwSiO/aHqZNX9gaPYZoG/pkYq
        4yWL8x+OPTAcun
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 0/6] MIPS: Cleanups and bugfixes
Date:   Thu, 21 Jan 2016 21:09:46 +0800
Message-Id: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patchset is a collection of cleanups and bugfixes for Linux/MIPS.

V1 -> V2:
1, Update the 3rd patch.
2, Fix commit message of the 6th patch.
3, Sync the code to upstream.

Huacai Chen(6):
 MIPS: Cleanup the unused __arch_local_irq_restore() function.
 MIPS: Loongson-3: Improve -march option and move it to Platform.
 MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler.
 MIPS: hpet: Choose a safe value for the ETIME check.
 MIPS: sync-r4k: reduce skew while synchronization.
 MIPS: Fix some missing CONFIG_CPU_MIPSR6 #ifdefs.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Makefile                     | 10 ----------
 arch/mips/include/asm/irqflags.h       | 30 ------------------------------
 arch/mips/include/asm/pgtable.h        |  4 ++--
 arch/mips/kernel/sync-r4k.c            | 32 ++++++++------------------------
 arch/mips/lib/mips-atomic.c            | 30 +-----------------------------
 arch/mips/loongson64/Platform          | 21 +++++++++++++++++++++
 arch/mips/loongson64/loongson-3/hpet.c | 10 +++++++---
 arch/mips/loongson64/loongson-3/smp.c  | 20 +++++++++++++-------
 arch/mips/mm/tlbex.c                   |  2 +-
 9 files changed, 53 insertions(+), 106 deletions(-)
--
2.4.6
