Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 15:41:18 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:54807 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011915AbaJTNlQlgh0G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 15:41:16 +0200
Received: by mail-wi0-f175.google.com with SMTP id d1so7179260wiv.8
        for <multiple recipients>; Mon, 20 Oct 2014 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1xi3aVbKsj0xPno7vNUsynu8UA6HUZ9E7/CC+6gV4+c=;
        b=WfclLQAarXr6klFSQqT6hp5ibznK8wrXZDt0umvFA7c3zwZGRRS+C4e4AheTr4Y6+v
         8m9CD1S6Skzyc1wqGlzxf1LVzMm+gtZqt7QZcl/CNxA5m7Mlms8VA2S7urNlF9qyqToR
         OFWFVngPDNL90nHmmBEAlAWGTBthjbPi9DmwDa4OkKjLY9BhsdI4g9KlaaOZPHGBIjJ+
         v42vF8AnOOZ2FphBD4KKLnVzjD5XCHJQOpUugg589rdR8KTbuDAl7fFR00RhxxHFgbBR
         vKjbF+moi6OQ7XcE+wlEhEHEwrQtptkytukkRMx4n1HgOSV6jDAef5SLBmB9UfYzUMyo
         iKpg==
X-Received: by 10.180.205.171 with SMTP id lh11mr20397287wic.66.1413812471355;
        Mon, 20 Oct 2014 06:41:11 -0700 (PDT)
Received: from cizrna.lan (37-48-34-187.tmcz.cz. [37.48.34.187])
        by mx.google.com with ESMTPSA id pc8sm11927091wjb.36.2014.10.20.06.41.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 06:41:09 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-omap@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 0/8] Per-user clock constraints
Date:   Mon, 20 Oct 2014 15:40:00 +0200
Message-Id: <1413812442-24956-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43353
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

this fourth version of the series is mainly intended to address many good
comments from Stephen Boyd, most notably:

* Make sure that best_parent_p is populated with the current parent before
calling clk_ops.determine_rate()

* Make sure we don't lose information about the caller in of_clk_get_*

* Refresh the effective rate after a per-user clk is removed

* Store requested rate and re-apply it when constraints are updated

The first six patches are just cleanups that should be desirable on their own,
and that should make easier to review the actual per-user clock patch.

The seventh patch actually moves the per-clock data that was stored in struct
clk to a new struct clk_core and adds references to it from both struct clk and
struct clk_hw. struct clk is now ready to contain information that is specific
to a given clk consumer.

The eighth patch adds API for setting floor and ceiling constraints and stores
that information on the per-user struct clk, which is iterable from struct
clk_core.

They are based on top of 3.18-rc1.

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v4

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

 Documentation/clk.txt                   |   2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c   | 108 +++--
 arch/arm/mach-omap2/clock.h             |  11 +-
 arch/arm/mach-omap2/clock_common_data.c |   5 +-
 arch/mips/alchemy/common/clock.c        |  17 +-
 drivers/clk/at91/clk-programmable.c     |   4 +-
 drivers/clk/bcm/clk-kona.c              |   4 +-
 drivers/clk/clk-composite.c             |   9 +-
 drivers/clk/clk.c                       | 788 +++++++++++++++++++++-----------
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
 19 files changed, 771 insertions(+), 389 deletions(-)

-- 
1.9.3
