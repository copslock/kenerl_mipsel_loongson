Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 11:51:12 +0100 (CET)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:62409 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011905AbaJ3KvLVwAoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 11:51:11 +0100
Received: by mail-wg0-f48.google.com with SMTP id m15so5354397wgh.7
        for <multiple recipients>; Thu, 30 Oct 2014 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wfdrEbGad1Q30KHEjPr7bfMqTUb+HCLQZnN94LhJt5E=;
        b=ITWFEOIBv3AzJmDaECVrnyecpxJXDBQjyWvQD47fDD8GKS+76sISj/XxvAoGLhFtOg
         ssZpfpAQYvlimrVgpYEVfDW619IygNRoO12VXAPdc5bo7VPd/DjH8EgUT7NYMVHgQtQZ
         7zh7lCn4D4L0HlZtjHkUglSGGCiRgeq2wvqKU6Y+ae/YwdJ1BtTt0b82wxGY6cqxH5rc
         X71RBE7cPnV5LcbuHSoZQlT5FXI5YtJUCV1lLQyfamoCzFbsZapN/1U10KpaDnDDom+M
         eFaaPgHjYVuVYOp0Y9XwbsbqtS9U9e26zbXhGuLHFA/yooOR33ZUNb9sQPV9UdhC6Vjr
         CVnQ==
X-Received: by 10.180.9.33 with SMTP id w1mr18697285wia.22.1414666266060;
        Thu, 30 Oct 2014 03:51:06 -0700 (PDT)
Received: from cizrna.lan (37-48-32-142.tmcz.cz. [37.48.32.142])
        by mx.google.com with ESMTPSA id l4sm4853632wjx.14.2014.10.30.03.51.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2014 03:51:04 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-omap@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 0/7] Per-user clock constraints
Date:   Thu, 30 Oct 2014 11:48:26 +0100
Message-Id: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43772
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

this fifth version of the series has just one change, suggested by Stephen:

* Initialize clk.ceiling_constraint to ULONG_MAX and warn about new floor
constraints being higher than the existing ceiling.

The first five patches are just cleanups that should be desirable on their own,
and that should make easier to review the actual per-user clock patch.

The sixth patch actually moves the per-clock data that was stored in struct
clk to a new struct clk_core and adds references to it from both struct clk and
struct clk_hw. struct clk is now ready to contain information that is specific
to a given clk consumer.

The seventh patch adds API for setting floor and ceiling constraints and stores
that information on the per-user struct clk, which is iterable from struct
clk_core.

They are based on top of 3.18-rc1.

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v5

Thanks,

Tomeu

Tomeu Vizoso (7):
  clk: Remove unused function __clk_get_prepare_count
  clk: Don't try to use a struct clk* after it could have been freed
  clk: Don't expose __clk_get_accuracy
  clk: change clk_debugfs_add_file to take a struct clk_hw
  clk: Change clk_ops->determine_rate to return a clk_hw as the best
    parent
  clk: Make clk API return per-user struct clk instances
  clk: Add floor and ceiling constraints to clock rates

 Documentation/clk.txt                   |   2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c   | 108 +++--
 arch/arm/mach-omap2/clock.h             |  11 +-
 arch/arm/mach-omap2/clock_common_data.c |   5 +-
 arch/mips/alchemy/common/clock.c        |  10 +-
 drivers/clk/at91/clk-programmable.c     |   4 +-
 drivers/clk/bcm/clk-kona.c              |   4 +-
 drivers/clk/clk-composite.c             |   9 +-
 drivers/clk/clk.c                       | 793 +++++++++++++++++++++-----------
 drivers/clk/clk.h                       |   5 +
 drivers/clk/clkdev.c                    |  73 ++-
 drivers/clk/hisilicon/clk-hi3620.c      |   2 +-
 drivers/clk/qcom/clk-rcg.c              |  20 +-
 drivers/clk/qcom/clk-rcg2.c             |  28 +-
 drivers/clk/sunxi/clk-factors.c         |   4 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c     |   4 +-
 include/linux/clk-private.h             |  41 +-
 include/linux/clk-provider.h            |  17 +-
 include/linux/clk.h                     |  18 +
 19 files changed, 773 insertions(+), 385 deletions(-)

-- 
1.9.3
