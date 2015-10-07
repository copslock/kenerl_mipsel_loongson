Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 08:07:44 +0200 (CEST)
Received: from SMTPBG12.QQ.COM ([183.60.61.233]:38462 "EHLO smtpbg12.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009094AbbJGGHCBtIHj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Oct 2015 08:07:02 +0200
X-QQ-mid: bizesmtp11t1444197962t345t09
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 07 Oct 2015 14:05:53 +0800 (CST)
X-QQ-SSF: 01100000000000F0FJ62
X-QQ-FEAT: HqsAE+iGIGj9pR/CXbMWE4sGN7j2t+HDFkcOvpr/6HUIKWxSI8mHOu4rmB5Z8
        zCj0R43PIhG4fAhQ6XlS4rizxv7T7cl7gWFLBqL7T6lzbBQ4G0VqfYH9COzcmf5EiUw3wyp
        BzJnrA5+u26qS8G6x5+9uLYXM61SXwlENx50eyLaMuJ48hUeR8f0kYnBuCxZ9eXWEfIGWBf
        d99DYrrZjJyspG5Ne2oycQR0fpaYlkIXdC6qOtZBWzVxIuEFtCCGvGhH48OCnhAhn4hH0oZ
        O50g==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 0/4] MIPS: Loongson-3: Improve kernel functionality
Date:   Wed,  7 Oct 2015 14:07:58 +0800
Message-Id: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49464
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

This patchset is prepared for the next 4.4 release for Linux/MIPS. In this
series we cleanup the naming style of Loongson's directory and Kconfig options,
move chipset ACPI code from drivers to arch since it is mostly Loongson-3
specific, introduce coherent cache features to improve performance, and Make
CPU names in /proc/cpuinfo more human-readable.

V1 -> V2:
1, Remove merged patches.
2, Cleanup CONFIG_LOONGSON_SUSPEND.
3, Rebase the code for 4.4.

Huacai Chen(4):
 MIPS: Loongson: Cleanup CONFIG_LOONGSON_SUSPEND.
 MIPS: Loongson-3: Move chipset ACPI code from drivers to arch.
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Loongson: Make CPU names more clear.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                                  |   3 +
 arch/mips/include/asm/cpu-features.h               |   3 +
 .../asm/mach-loongson64/cpu-feature-overrides.h    |   1 +
 arch/mips/kernel/cpu-probe.c                       |   8 +-
 arch/mips/loongson64/Kconfig                       |   5 -
 arch/mips/loongson64/common/Makefile               |   2 +-
 arch/mips/loongson64/lemote-2f/Makefile            |   2 +-
 arch/mips/loongson64/loongson-3/Makefile           |   2 +-
 arch/mips/loongson64/loongson-3/acpi_init.c        | 150 +++++++++++++++++++++
 arch/mips/mm/c-r4k.c                               |  21 +++
 drivers/platform/mips/Kconfig                      |   4 -
 drivers/platform/mips/Makefile                     |   1 -
 drivers/platform/mips/acpi_init.c                  | 150 ---------------------
 13 files changed, 185 insertions(+), 167 deletions(-)
 create mode 100644 arch/mips/loongson64/loongson-3/acpi_init.c
 delete mode 100644 drivers/platform/mips/acpi_init.c
--
2.4.6
