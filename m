Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 06:55:49 +0100 (CET)
Received: from smtpbg328.qq.com ([14.17.43.160]:54137 "EHLO smtpbg328.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008177AbcAEFy5h40B- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2016 06:54:57 +0100
X-QQ-mid: bizesmtp4t1451973249t654t208
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 05 Jan 2016 13:54:00 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK60B00A0000000
X-QQ-FEAT: DnZhDcReyHvnKqsKAtWSnvDMjcCnTF0LKRNAWUve6CFzeayMWR2JKJ2OsLR2F
        z7NsLupZ4kIVRD6P6Ne5sGFokmqKaKrK9I8VwtA0T2DYqb7/4kcjnQU9sPsVeD8gffYK9HE
        /uoPEcVFig95WHb8qG3WpwaphFmAVVtZMSsDt57e2TJz7fOyrmuXyY7qvCc9JN5FdFUEWch
        E+4QK7nGUptYXgAbI/jpqLhlKkuSaVUIYB3EPkphEO3rEBQPPLsBY7zVPHoJJgz1BaGb45t
        phDg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/6] MIPS: Cleanups and bugfixes
Date:   Tue,  5 Jan 2016 13:59:03 +0800
Message-Id: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50900
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

Huacai Chen(6):
 MIPS: Cleanup the unused __arch_local_irq_restore() function.
 MIPS: Loongson-3: Improve -march option and move it to Platform.
 MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler.
 MIPS: hpet: Choose a safe value for the ETIME check.
 MIPS: sync-r4k: reduce skew while synchronization.
 MIPS: Fix some missing CONFIG_CPU_MIPSR6 definitions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Makefile                     | 10 ----------
 arch/mips/include/asm/irqflags.h       | 30 ------------------------------
 arch/mips/include/asm/pgtable.h        |  4 ++--
 arch/mips/kernel/sync-r4k.c            | 32 ++++++++------------------------
 arch/mips/lib/mips-atomic.c            | 30 +-----------------------------
 arch/mips/loongson64/Platform          | 21 +++++++++++++++++++++
 arch/mips/loongson64/loongson-3/hpet.c | 10 +++++++---
 arch/mips/loongson64/loongson-3/smp.c  |  2 ++
 arch/mips/mm/tlbex.c                   |  2 +-
 9 files changed, 42 insertions(+), 99 deletions(-)
--
2.4.6


ÿÿÿÿÿÿ‰
