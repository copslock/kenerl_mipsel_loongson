Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 06:39:27 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35551 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbcISEjVLrtkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 06:39:21 +0200
Received: by mail-pf0-f195.google.com with SMTP id 6so3687686pfl.2
        for <linux-mips@linux-mips.org>; Sun, 18 Sep 2016 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=I6BYCDWLqjfW78WdAfkdsURSlCFOJuWMWa7BwxBvuuY=;
        b=iDGgJGOgJFJUhl7Md4O0P90ewR+YVTkK1PI/YNZ27gnt9euVn718hjT78oKFZ3EL4D
         I2NUhy//u1lDvUCMAKme0Mktaya8JCmZxIf46YZHch6vvM3e8nncxajZbdnUDdMYxfM3
         oAJ9CPx9jPP3sCKMzYeJ0Le/pUE+hosNOHEmiX3lacuooA1UP5jrZYBDJ7nftnfqIvfI
         gldcjrbg7M/af1G23eL0Q5dLHcN5ueZt9OwP1RLMUE1jVF9lwAqDYzofe9py7YBbMMGJ
         U0BdaEQMIJ2k6U5OtZokUvQOXfjBQRAbedYatUFOm3DE3Uog0zFT2Jm71KGkWvOeWeMP
         WVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I6BYCDWLqjfW78WdAfkdsURSlCFOJuWMWa7BwxBvuuY=;
        b=cn2jt2jMjYUSDVB3c+z9IL5UCT+YafdXfsUf+b9CnuvErVEkPpdWhaCztBWX4io6Zx
         wlDRwfA67wxxTVIgLJACABV/8ymNUdkwzXA27xC3ozdtrhU1BlA37LFfuigs9rwWa5UV
         fdIjjFQQCc08aJl+SdaDm6YrpXLu2RPxv2iueaHUmhOTv/hnKA7eXt//5DmBmPaZzb19
         8wGxXBbAQeKCuJnupuMMhqn+MvNB6jq+qT4SsfhdSUgNUk97dL5aWJwGuMH4FzMqShdB
         WfNM7cNOkPOuVjqt/W3rnJw4Qa3ZWO8z1XOoem0YjPCqvNCohabTJiLHDxLMVOOfzugw
         Uitw==
X-Gm-Message-State: AE9vXwOEe2npbDoa5HB2h53YnblkA0nWo9VvQ61QvGmvOG9JItEjxI+m1kAyfYKHyS+2Fg==
X-Received: by 10.98.31.133 with SMTP id l5mr29898908pfj.178.1474259955108;
        Sun, 18 Sep 2016 21:39:15 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id p7sm19598950paa.3.2016.09.18.21.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Sep 2016 21:39:14 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 0/3] Refactor Loongson1 clock
Date:   Mon, 19 Sep 2016 12:38:53 +0800
Message-Id: <1474259936-9657-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55161
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patchset is to refactor Loongson1 clock,
and update Loongson1B clocks.

This applies on top of clk-next.

Thanks!

Changelog:
v1:
   Rebase the patch on clk: ls1x: Migrate to clk_hw based OF
   and registration APIs.

Kelvin Cheung (3):
  clk: Loongson1: Refactor Loongson1 clock
  clk: Loongson1: Update clocks of Loongson1B
  clk: Loongson1: Make use of GENMASK

 drivers/clk/Makefile                               |  2 +-
 drivers/clk/loongson1/Makefile                     |  2 +
 .../clk/{clk-ls1x.c => loongson1/clk-loongson1b.c} | 74 +++++-----------------
 drivers/clk/loongson1/clk.c                        | 43 +++++++++++++
 drivers/clk/loongson1/clk.h                        | 19 ++++++
 5 files changed, 82 insertions(+), 58 deletions(-)
 create mode 100644 drivers/clk/loongson1/Makefile
 rename drivers/clk/{clk-ls1x.c => loongson1/clk-loongson1b.c} (67%)
 create mode 100644 drivers/clk/loongson1/clk.c
 create mode 100644 drivers/clk/loongson1/clk.h

-- 
1.9.1
