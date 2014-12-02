Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2014 08:56:05 +0100 (CET)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48964 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006697AbaLBH4DhxFZe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Dec 2014 08:56:03 +0100
Received: by mail-wg0-f42.google.com with SMTP id z12so16408968wgg.29
        for <multiple recipients>; Mon, 01 Dec 2014 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=nHdF7bwo9V9vBHwxhRJNVX1axDNQZbDvvJh+XwmhzUk=;
        b=lqe06t5PCuYCFhvNwfAaAVjhoMAPnpULR/QuKSBXA+xge9aKJmUfwJ0vG1MfVNMEaJ
         TFwKyg1Mf70Izoqw11SRrBR200e5WdLOkyWgcm5caheux9WLqmIuNmsU1Z0ZghyVR/Sj
         JUHSfYSbhmpH+2zvl0C35p1TEle5eoemR2Uc6Kdgns7BfWLW6w+JXdYGv98a3kwJAnY3
         pfudYsGEaDzsPg1XInqfGaZmfpzKvtbUlxH7iucjrBQo1xwN51XplhFhhZHNEWZsqcG9
         LWFVZCUWddQ8vjqt+lv8DB3GXZhV0NnAdDRvMRpUvnmf7dDPL0gmskEMCY8xPQo8QWEN
         rM0Q==
X-Received: by 10.194.193.38 with SMTP id hl6mr55638451wjc.38.1417506958189;
        Mon, 01 Dec 2014 23:55:58 -0800 (PST)
Received: from cizrna.lan (37-48-45-211.tmcz.cz. [37.48.45.211])
        by mx.google.com with ESMTPSA id vy7sm30775533wjc.27.2014.12.01.23.55.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2014 23:55:56 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alex Elder <elder@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-omap@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v7 0/7] Per-user clock constraints
Date:   Tue,  2 Dec 2014 08:54:17 +0100
Message-Id: <1417506933-8915-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44541
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

this seventh version of the series has added just a few fixes for new
implementations in linux-next of the determine_rate callback.

A rough test module was used to test this:

http://cgit.collabora.com/git/user/tomeu/linux.git/commit/?h=per-user-clk-constraints-v7&id=3d87d46d98f74b6f53eadf0d28785a3cd85c2178

The first five patches are just cleanups that should be desirable on their own,
and that should make easier to review the actual per-user clock patch.

The sixth patch actually moves the per-clock data that was stored in struct
clk to a new struct clk_core and adds references to it from both struct clk and
struct clk_hw. struct clk is now ready to contain information that is specific
to a given clk consumer.

The seventh patch adds API for setting floor and ceiling constraints and stores
that information on the per-user struct clk, which is iterable from struct
clk_core.

They are based on top of linux-next 20141201.

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v7

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

 Documentation/clk.txt                   |   4 +-
 arch/arm/mach-omap2/cclock3xxx_data.c   | 108 +++--
 arch/arm/mach-omap2/clock.h             |  11 +-
 arch/arm/mach-omap2/clock_common_data.c |   5 +-
 arch/arm/mach-omap2/dpll3xxx.c          |   8 +-
 arch/arm/mach-omap2/dpll44xx.c          |   8 +-
 arch/mips/alchemy/common/clock.c        |  18 +-
 drivers/clk/at91/clk-programmable.c     |   6 +-
 drivers/clk/bcm/clk-kona.c              |   6 +-
 drivers/clk/clk-composite.c             |  18 +-
 drivers/clk/clk.c                       | 807 +++++++++++++++++++++-----------
 drivers/clk/clk.h                       |   5 +
 drivers/clk/clkdev.c                    |  80 +++-
 drivers/clk/hisilicon/clk-hi3620.c      |   4 +-
 drivers/clk/mmp/clk-mix.c               |   6 +-
 drivers/clk/qcom/clk-pll.c              |   3 +-
 drivers/clk/qcom/clk-rcg.c              |  30 +-
 drivers/clk/qcom/clk-rcg2.c             |  34 +-
 drivers/clk/sunxi/clk-factors.c         |   6 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c     |   6 +-
 include/linux/clk-private.h             |  41 +-
 include/linux/clk-provider.h            |  26 +-
 include/linux/clk.h                     |  28 ++
 include/linux/clk/ti.h                  |   8 +-
 24 files changed, 873 insertions(+), 403 deletions(-)

-- 
1.9.3
