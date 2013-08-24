Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 20:27:40 +0200 (CEST)
Received: from mail-ee0-f54.google.com ([74.125.83.54]:39484 "EHLO
        mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817237Ab3HXS1iac16l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 20:27:38 +0200
Received: by mail-ee0-f54.google.com with SMTP id e53so869207eek.27
        for <linux-mips@linux-mips.org>; Sat, 24 Aug 2013 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7otyocsafYSU1UDC+VXotuNu46DsqQNSoz+jw+rxgm0=;
        b=GaW2qwXm4Tfx1/V/VIMry+uerzfohDJnbxuMrZwu9YGXT+qeyPu5kveD8NltPgcTG8
         y3t23CsYvMWBCFqJtkyP7jLkvWDfDjPt+5SbX7ROsNBBOTVV4fvR4UGcHShkoV3pw2f0
         niVk4cAxTPtSVnzrQw3L+vEfdRSq/J8oyvqgQZTIKL0H4h0rKPPqU078k+jKLWGDcPbt
         6KEqW0l+xINPfqCiLbtdqq+eZLfF6BoLrCxzjolEwfzHCzKWYm/WPIYsVQ5myjt6tjiW
         /oWES93n/cmYLy6Numn26bYDaSjXIhf+b6oZ3fKsoa+cebgYp/CxVynWxsUcANacM7tu
         Ivlw==
X-Received: by 10.14.214.136 with SMTP id c8mr9871003eep.6.1377368853177;
        Sat, 24 Aug 2013 11:27:33 -0700 (PDT)
Received: from localhost.localdomain (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id b45sm8446922eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 11:27:32 -0700 (PDT)
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, s.nawrocki@samsung.com
Subject: [PATCH v5 0/5] clk: clock deregistration support
Date:   Sat, 24 Aug 2013 20:27:00 +0200
Message-Id: <1377368825-30715-1-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.4.1
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37680
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
framework.  This is required for proper support of clock suppliers as
loadable modules.  Previous version of this series can be found at [1].

Comparing to v4 only a stray struct module forward declaration has been 
removed from patch 3/5. My apologies for spamming.

Changes since v3:
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

[1] https://lkml.org/lkml/2013/8/24/43

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
 include/linux/clkdev.h             |    5 +
 9 files changed, 220 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

-- 
1.7.4.1
