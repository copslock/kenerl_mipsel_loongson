Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 11:52:50 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:58650 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901165Ab2IBJwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 11:52:42 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0M3O8y-1TPumw1gTQ-00r1Ts; Sun, 02 Sep 2012 11:52:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id A27752A28305;
        Sun,  2 Sep 2012 11:52:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id twrgXeIIwXVe; Sun,  2 Sep 2012 11:52:32 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 449E22A282EC;
        Sun,  2 Sep 2012 11:52:32 +0200 (CEST)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH 0/3] MIPS: JZ4740: Move PWM driver to PWM framework
Date:   Sun,  2 Sep 2012 11:52:27 +0200
Message-Id: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.7.12
X-Provags-ID: V02:K0:Y4bA/5CKk5Dd3Ey41RPM6LHj6BDA9/gLkEb5dPTFqcQ
 jKzCCtGMrlx3LCpv+OXBJeeH9pe/i+4x3KT6XSDn7mjEPLv7+C
 mKaJIakaY8igAFOgWbzM8vCYP/kWgeYdXpDa5EhquVni1bCRlA
 cOb1TwTqmMERzjaNX7s2VvGXbVr7q0KEYSkoXCiPxVXgQKXPi9
 FycTfEQvcFmLzWOCeoQSvCMrSarkZynsqsyM4/9gmVm97lSSp1
 8yyxeITSLSHYbTx07XD1VKsAjYBgSGaa5xOJR7POSt2XKgtm+o
 phXjq0b/eDilil8g/9TqQdQCcZ90tAW0mw+vELxrYYmBRZIFIg
 LpY5TvfgONTPu80IXYYqbUzNyFj+rgwl2puDMoswjAP0ND23Cc
 iw0c3yTf4OKZvU34oN+CXqjN1oTxyd2Ym1odlyGWfJFS1YToxq
 m9PWz
X-archive-position: 34395
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
 arch/mips/include/asm/mach-jz4740/timer.h    |  35 +++++
 arch/mips/jz4740/Kconfig                     |   3 -
 arch/mips/jz4740/Makefile                    |   2 +-
 arch/mips/jz4740/board-qi_lb60.c             |   3 +-
 arch/mips/jz4740/irq.h                       |  23 ---
 arch/mips/jz4740/platform.c                  |   6 +
 arch/mips/jz4740/pwm.c                       | 177 -----------------------
 arch/mips/jz4740/time.c                      |   2 +-
 arch/mips/jz4740/timer.c                     | 128 +++++++++++++++--
 arch/mips/jz4740/timer.h                     | 136 ------------------
 drivers/pwm/Kconfig                          |  12 +-
 drivers/pwm/Makefile                         |   1 +
 drivers/pwm/core.c                           |   2 +-
 drivers/pwm/pwm-jz4740.c                     | 205 +++++++++++++++++++++++++++
 16 files changed, 386 insertions(+), 355 deletions(-)
 delete mode 100644 arch/mips/jz4740/irq.h
 delete mode 100644 arch/mips/jz4740/pwm.c
 delete mode 100644 arch/mips/jz4740/timer.h
 create mode 100644 drivers/pwm/pwm-jz4740.c

-- 
1.7.12
