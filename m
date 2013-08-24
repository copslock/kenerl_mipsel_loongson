Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 17:20:17 +0200 (CEST)
Received: from mail-ee0-f45.google.com ([74.125.83.45]:60569 "EHLO
        mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816122Ab3HXPUHT12Vf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 17:20:07 +0200
Received: by mail-ee0-f45.google.com with SMTP id c50so801010eek.18
        for <multiple recipients>; Sat, 24 Aug 2013 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mK1ud075WZhOjA3aEifM7MPf3pGN8CBFPasV8ggxa/0=;
        b=Jw1W7zGwaBVIiaO6Uz7xzZKYqPm8HqKs5wSesawCbnrGyVnX+A9oa5W9fRiOoVFD4W
         52Zz8h598t0EedMkCBrqAl0X+8a5d01liKvamLzg/HAgnUG3LoNwU8ryWK34/8YW9pyQ
         pNHakYURctVELUitvOAAnDhdXP9bT1g63QoKH4nbi5cXXA78HjaGNEu9CeJz6bcsE+8b
         Ym6endeBFISVTNqIZLYEt/jowfwwCBxfpx65wiwsdcZuoMOAUbBo6uQS6HOuylY9dgjD
         LEAhhxokWg7hCO9t7utpi+GIv3HtxkXaNNkNhmbHjzO6qSm1VHj9aLrNqfoXM5WkHmvB
         udrQ==
X-Received: by 10.15.41.77 with SMTP id r53mr515059eev.64.1377357601959;
        Sat, 24 Aug 2013 08:20:01 -0700 (PDT)
Received: from localhost.localdomain (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id x47sm7415825eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 08:20:00 -0700 (PDT)
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, s.nawrocki@samsung.com
Subject: [PATCH v4 0/5] clk: clock deregistration support
Date:   Sat, 24 Aug 2013 17:19:44 +0200
Message-Id: <1377357589-13242-1-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.4.1
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sylvester.nawrocki@gmail.com
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

This patch series implements clock deregistration in the common clock
framework. This is required for proper support of clock suppliers as
loadable modules.  Previous version of this series can be found at [1].

Changes since v3:
 - dropped exporting of __clk_get(), __clk_put(),
 - replaced WARN_ON() with WARN_ON_ONCE() in clk_nodrv_disable_unprepare()
   callback.

Changes since v2:
 - reordered the patches so the race condition is fixed before it can
   actually cause any issues,
 - fixed handling of NULL clock pointers in __clk_get(), __clk_put(),
 - added patch adding actual asignment of clk->owner; more details are
   discussed in that specific patch.

Changes since v1:
 - moved of_clk_{lock, unlock}, __of_clk_get_from_provider() function
   declaractions to a local header,
 - renamed clk_dummy_* to clk_nodrv_*.


[1] https://lkml.org/lkml/2013/8/23/289

Sylwester Nawrocki (5):
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree
  clk: Add common __clk_get(), __clk_put() implementations
  clk: Assign module owner of a clock being registered
  clk: Implement clk_unregister

 arch/arm/include/asm/clkdev.h      |    2 +
 arch/blackfin/include/asm/clkdev.h |    2 +
 arch/mips/include/asm/clkdev.h     |    2 +
 arch/sh/include/asm/clkdev.h       |    2 +
 drivers/clk/clk.c                  |  187 +++++++++++++++++++++++++++++++++--
 drivers/clk/clk.h                  |   16 +++
 drivers/clk/clkdev.c               |   12 ++-
 include/linux/clk-private.h        |    5 +
 include/linux/clk-provider.h       |    2 +
 include/linux/clkdev.h             |    5 +
 10 files changed, 222 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

--
1.7.4.1
