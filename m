Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 17:22:43 +0200 (CEST)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36197 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010711AbaJGPWmLAoX8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 17:22:42 +0200
Received: by mail-wg0-f41.google.com with SMTP id b13so9740488wgh.24
        for <multiple recipients>; Tue, 07 Oct 2014 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vjKYJKy9CLAyrYlBBE6c6C2tBY+K2FPR0oryFrIepzY=;
        b=Y2V18F9m/O6sCfJc3MYgKCe1WdjKwU1JtM2qx4qjIws9imPPivyRf/CTm/NApmQ71W
         VYqV+0tnW8nhm9qsnZw/3Tr9flrMFV3rlzHrKvtchY/4JgHiiIA+kHh1uzi4UiaWep4M
         VmJaUUxVVsOLIKG0KRZndp47cXbweq9OFzYh5UX/JWbnoi2LixdCqdt98l3qzvicFKcU
         X4ISbGFeocRQkX9Q82etshjCuwcE/IXpvtqN720FtYBsnfXjnOotpVJIvSxC6Ws5VRNx
         pq0OA717ZQ32NTN+BsOfBl9YATqVM0T6W9n5muUQ8vCV8aE7njmQ8H8HNv4STovfqYsv
         zT6Q==
X-Received: by 10.194.78.136 with SMTP id b8mr5621938wjx.106.1412695356879;
        Tue, 07 Oct 2014 08:22:36 -0700 (PDT)
Received: from cizrna.lan (37-48-36-103.tmcz.cz. [37.48.36.103])
        by mx.google.com with ESMTPSA id ny6sm15093285wic.22.2014.10.07.08.22.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 08:22:35 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-omap@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/8] Per-user clock constraints
Date:   Tue,  7 Oct 2014 17:21:45 +0200
Message-Id: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomeu.vizoso@collabora.com
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

Hello,

this second version of the series adds several cleanups that were suggested by
Stephen Boyd and contains several improvements to the seventh patch (clk: Make
clk API return per-user struct clk instances) that were suggested by him during
the review of v1.

The first six patches are just cleanups that should be desirable on their own,
and that should make easier to review the actual per-user clock patch.

The seventh patch actually moves the per-clock data that was stored in struct
clk to a new struct clk_core and adds references to it from both struct clk and
struct clk_hw. struct clk is now ready to contain information that is specific
to a given clk consumer.

The eighth patch adds API for setting floor and ceiling constraints and stores
that information on the per-user struct clk, which is iterable from struct
clk_core.

Thanks,

Tomeu

Tomeu Vizoso (8):
  MIPS: Alchemy: Remove direct access to prepare_count field of struct
    clk
  clk: Remove unused function __clk_get_prepare_count
  clk: Don't try to use a struct clk* after it could have been freed
  clk: Don't expose __clk_get_accuracy
  clk: change clk_debugfs_add_file to take a struct clk_hw
  clk: Change clk_ops->determine_rate to return a clk_hw as the best
    parent
  clk: Make clk API return per-user struct clk instances
  clk: Add floor and ceiling constraints to clock rates

 arch/arm/mach-omap2/cclock3xxx_data.c   | 108 +++--
 arch/arm/mach-omap2/clock.h             |  11 +-
 arch/arm/mach-omap2/clock_common_data.c |   5 +-
 arch/mips/alchemy/common/clock.c        |   7 +-
 drivers/clk/at91/clk-programmable.c     |   4 +-
 drivers/clk/bcm/clk-kona.c              |   4 +-
 drivers/clk/clk-composite.c             |   9 +-
 drivers/clk/clk.c                       | 723 +++++++++++++++++++++-----------
 drivers/clk/clk.h                       |   7 +
 drivers/clk/clkdev.c                    |  23 +-
 drivers/clk/hisilicon/clk-hi3620.c      |   2 +-
 drivers/clk/qcom/clk-rcg.c              |  20 +-
 drivers/clk/qcom/clk-rcg2.c             |  28 +-
 drivers/clk/sunxi/clk-factors.c         |   4 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c     |   4 +-
 include/linux/clk-private.h             |  40 +-
 include/linux/clk-provider.h            |  30 +-
 include/linux/clk.h                     |  18 +
 18 files changed, 697 insertions(+), 350 deletions(-)

-- 
1.9.3
