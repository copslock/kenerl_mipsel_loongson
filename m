Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 08:17:25 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40104 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815793Ab2JWGRWIy5XS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 08:17:22 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2352864pad.36
        for <multiple recipients>; Mon, 22 Oct 2012 23:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JYoBjMs+SIu+cyTtQdZ28TZwqYv+8op8OaHVQHl9hX0=;
        b=jKv+r1JCN2umRvUuJ9SJ8mLSwYliLda2h+mSZNKY1JCYN/UisFnRytDw8j9JgS6gUB
         zMwQsvLli/InRdsbAJfM36Ca+2b1wGZyUfbPBNxnHdlmmzA84xQHUWXlooQnHk5772x2
         rEsT/HE/64QnE44mokRlPoRn/UAKp4Z/iZAqg2CtVIkrntDW2RsHIwRR23+e1Mppnu0J
         n/cVzLAx0kTjLkzNZu0C3JoNQnfVHXU4b0wLQnqsM58BWPQgmt1U/6vccEmmfh7CAmY6
         HT1qzhEX5GXGPdViJwDLKih+ivLsO4JG15+L3xIBHo2UCR54lZ2vhapwKyMeYKi2sdJj
         8fSA==
Received: by 10.68.209.200 with SMTP id mo8mr37027431pbc.102.1350973035194;
        Mon, 22 Oct 2012 23:17:15 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id bc8sm7185918pab.5.2012.10.22.23.17.09
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 23:17:14 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     mturquette@linaro.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 0/4] MIPS: Loongson1B: enable common clock infrastructure
Date:   Tue, 23 Oct 2012 14:16:59 +0800
Message-Id: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 34738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

These patches enable common clock infrastructure of Loongson1, and
include other minor fixes.

Kelvin Cheung (4):
  MIPS: Loongson1B: use common clock infrastructure instead of    
    private APIs
  MIPS: Loongson1B: improve ls1x_serial_setup()
  MIPS: Loongson1B: Update stmmac_mdio_bus_data
  MIPS: Loongson1B: Fix a typo

 arch/mips/include/asm/mach-loongson1/platform.h |    3 +-
 arch/mips/include/asm/mach-loongson1/regs-clk.h |    7 +-
 arch/mips/loongson1/Kconfig                     |    2 +-
 arch/mips/loongson1/common/clock.c              |  159 +----------------------
 arch/mips/loongson1/common/platform.c           |   10 +-
 arch/mips/loongson1/ls1b/board.c                |    5 +-
 6 files changed, 16 insertions(+), 170 deletions(-)
