Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:02:08 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46194 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010963AbaJIPCGqBScI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:02:06 +0200
Received: by mail-wi0-f177.google.com with SMTP id fb4so2055184wid.16
        for <multiple recipients>; Thu, 09 Oct 2014 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=x86pQi9jzW+gxmv6xKD7kmrffCM2DCvD5F6CHxXsqa4=;
        b=RySX48IzneLyPcqM1xtuv1KmIvdddVIRYLdeF/xr5KrtQ8jKoNtxMNWYU4P0CEOchE
         X3M+ntMoQWwWCaGk/sDx/MkmrmfiKylwR9DI9w5vYyz4uvxXEaSxNbroNurydDr9OOhQ
         g6ff2v2uyLJIU3kIoroiI0neYRPKk9AzSpSmSvjlR42MzmmgT7N/+9yywzFBm4ugHTxL
         ObJtjpjtwsu2OP3SVufEQHXiz3aLeSFVdSCUDY2/WF3PKXaybJfCbfjdNQnf/2cGYC/G
         ZVgoeIsmRbAnYDd23aCDKwYBzfvcRejpurTFpNjs4rSL8wwNA4Yf+7Uff6206Cf+ojsI
         WnyA==
X-Received: by 10.194.118.201 with SMTP id ko9mr19104828wjb.9.1412866921405;
        Thu, 09 Oct 2014 08:02:01 -0700 (PDT)
Received: from cizrna.lan (37-48-37-161.tmcz.cz. [37.48.37.161])
        by mx.google.com with ESMTPSA id b6sm5847591wiy.22.2014.10.09.08.01.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 08:01:59 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alex Elder <elder@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-omap@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 0/8] Per-user clock constraints
Date:   Thu,  9 Oct 2014 17:01:08 +0200
Message-Id: <1412866903-6970-1-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43133
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

this third version of the series is basically just a rebase on top of linux-next 20141009.

The first six patches are just cleanups that should be desirable on their own,
and that should make easier to review the actual per-user clock patch.

The seventh patch actually moves the per-clock data that was stored in struct
clk to a new struct clk_core and adds references to it from both struct clk and
struct clk_hw. struct clk is now ready to contain information that is specific
to a given clk consumer.

The eighth patch adds API for setting floor and ceiling constraints and stores
that information on the per-user struct clk, which is iterable from struct
clk_core.

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v3

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
 drivers/clk/clk.c                       | 748 ++++++++++++++++++++------------
 drivers/clk/clk.h                       |   5 +
 drivers/clk/clkdev.c                    |  24 +-
 drivers/clk/hisilicon/clk-hi3620.c      |   2 +-
 drivers/clk/qcom/clk-rcg.c              |  20 +-
 drivers/clk/qcom/clk-rcg2.c             |  28 +-
 drivers/clk/sunxi/clk-factors.c         |   4 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c     |   4 +-
 include/linux/clk-private.h             |  40 +-
 include/linux/clk-provider.h            |  30 +-
 include/linux/clk.h                     |  18 +
 19 files changed, 717 insertions(+), 366 deletions(-)

-- 
1.9.3
