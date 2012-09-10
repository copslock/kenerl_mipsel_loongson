Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 14:05:44 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.8]:63314 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903446Ab2IJMFg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2012 14:05:36 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0MDCvo-1TKxqh2Qiy-00Gq18; Mon, 10 Sep 2012 14:05:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id E262B2A282E2;
        Mon, 10 Sep 2012 14:05:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ziUt81VE2jDh; Mon, 10 Sep 2012 14:05:21 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id B0A5D2A28267;
        Mon, 10 Sep 2012 14:05:21 +0200 (CEST)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH v2 0/3] MIPS: JZ4740: Move PWM driver to PWM framework
Date:   Mon, 10 Sep 2012 14:05:16 +0200
Message-Id: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.7.12
X-Provags-ID: V02:K0:n+yP6mng7YgOvO61oGfh2jjrxo260QIM+tPDlygG/98
 J67g1c5PE5Msj1DDC976bof1oI7FQ2UXb4WFDo1FUkukY0KI1Q
 In0cvla3RbhQVcy7yTXpeRbiOn6+ou5DK7QuncEpdn6+OxLhy9
 CMBhu3l4AJQCI7sVHBmXmqXstKsDtEXCtDQzmMKg8OgNvqds/S
 w8jM8bk0ai26JWcsT9Kjhr4z/vpeBaL1WpLUtdxbxDcmaQNCPa
 AJ5be4EPcUbuW1X5zDW2fa2XLHAaVOW57mRbxeTFKFyLm50/md
 AZcwiusW6IYlUawCUCYM3EX/+3sX1R8P+szHBSFK6UnBhneFXW
 flchSr83+qGQjA0dEkNt9xFAnEy1rSKzaf4EABE405n0xM0Gd5
 Ox53IgzlbKYyeW347QPgrV0sLNkXJQiZII9l18RgZ5iwI5wmTU
 AE81H
X-archive-position: 34447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

This small series fixes a build error due to a circular header
dependency, exports the timer API so it can be used outside of
the arch/mips/jz4740 tree and finally moves and converts the
JZ4740 PWM driver to the PWM framework.

Note that I don't have any hardware to test this on, so I had to
rely on compile tests only. Patches 1 and 2 should probably go
through the MIPS tree, while I can take patch 3 through the PWM
tree. It touches a couple of files in arch/mips but the changes
are unlikely to cause conflicts.

Thierry

Thierry Reding (3):
  MIPS: JZ4740: Break circular header dependency
  MIPS: JZ4740: Export timer API
  pwm: Add Ingenic JZ4740 support

 arch/mips/include/asm/mach-jz4740/irq.h      |   5 +
 arch/mips/include/asm/mach-jz4740/platform.h |   1 +
 arch/mips/include/asm/mach-jz4740/timer.h    | 113 ++++++++++++++
 arch/mips/jz4740/Kconfig                     |   3 -
 arch/mips/jz4740/Makefile                    |   2 +-
 arch/mips/jz4740/board-qi_lb60.c             |   1 +
 arch/mips/jz4740/irq.h                       |  23 ---
 arch/mips/jz4740/platform.c                  |   6 +
 arch/mips/jz4740/pwm.c                       | 177 ---------------------
 arch/mips/jz4740/time.c                      |   2 +-
 arch/mips/jz4740/timer.c                     |   4 +-
 arch/mips/jz4740/timer.h                     | 136 -----------------
 drivers/pwm/Kconfig                          |  12 +-
 drivers/pwm/Makefile                         |   1 +
 drivers/pwm/pwm-jz4740.c                     | 221 +++++++++++++++++++++++++++
 15 files changed, 363 insertions(+), 344 deletions(-)
 delete mode 100644 arch/mips/jz4740/irq.h
 delete mode 100644 arch/mips/jz4740/pwm.c
 delete mode 100644 arch/mips/jz4740/timer.h
 create mode 100644 drivers/pwm/pwm-jz4740.c

-- 
1.7.12
