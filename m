Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 12:52:21 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33750 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993233AbcHLKwOWQQK5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 12:52:14 +0200
Received: by mail-pa0-f65.google.com with SMTP id vy10so1330995pac.0
        for <linux-mips@linux-mips.org>; Fri, 12 Aug 2016 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y0QUuFrKnMaGHdwfKYvIgrIVQbGZ9ae9BE93k75vySg=;
        b=iW59YahooZHC2+3Loy2RjmYcoFGzJO90HBxAH8T2eyyhjYa5lQCPwRPJ5D/2QF+Ujz
         yeSWyvzpPrzlQuTKLxnDDZYl45ldp8K1RADbNGN/ZgMOQfawq2ISwACOtPkjUyJ0EIz/
         8tYnjYUbseA2Xs0a92QPtX0XKweeBpxke/vbM9YH/OynBlEps4s4qFOVV2NO05Xq2esA
         ZCxBr/nmAg6MCPwmEGoCdWXqTwhstTt3HAXs2d5hBUQ5bLcQOfdfJXZUbh496gsIPgla
         f10ZqDFgjIBlCGGZjlPZtP5lk3SZolLG9Rn1+TJBM8FZOkcmPYSvHokF9qb5VhWU5UxX
         L91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y0QUuFrKnMaGHdwfKYvIgrIVQbGZ9ae9BE93k75vySg=;
        b=RTPTZvUe+XgHw25QxZ0SvLUjgiHDW1aOxA5+N1aFSapxIxhnj6QjuYxekZinEnt623
         CqPcAoU3Mzexm4BDJKwzVo62E99Dp46wCEIqZUBZO0Bu786qE1i0BCS9DTer3S46dWtd
         AI0c+X99ekiD/eDRKmkxYfqBQPbuRaj0Vyfnkt4SB8toxHDUQmtRMe7+daTQNoM2Duyn
         8m6L9DSydR61rR7dk8dvXX/1mRoKmqPl24RWcSVTY6iE7K0mbaXbOHpdHpbXSwpS2MOc
         flhp/jNtgst3/JU0k1JVIG7PJ18f2oBcBi+b5sXbPAlNbHf+MnNmbB9ZPix6bAtOyvoF
         upAQ==
X-Gm-Message-State: AEkoouvBTGjz657CQLN+Cf/q4YGiyDtKfhwwbq3aRxMYREhQ/BNQl3UXshCx2hoAB3dwIA==
X-Received: by 10.66.132.105 with SMTP id ot9mr26366535pab.88.1470999128257;
        Fri, 12 Aug 2016 03:52:08 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id k78sm12034940pfa.78.2016.08.12.03.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 03:52:07 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Keguang Zhang <keguang.zhang@spreadtrum.com>
Subject: [PATCH 0/3] Refactor Loongson1 clock
Date:   Fri, 12 Aug 2016 18:51:45 +0800
Message-Id: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54502
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

From: Keguang Zhang <keguang.zhang@spreadtrum.com>

This patchset is to refactor Loongson1 clock,
and update Loongson1B clocks.

This applies on top of clk-next.

Thanks!

Kelvin Cheung (3):
  clk: Loongson1: Refactor Loongson1 clock
  clk: Loongson1: Update clocks of Loongson1B
  clk: Loongson1: Make use of GENMASK

 drivers/clk/Makefile                               |  2 +-
 drivers/clk/loongson1/Makefile                     |  2 +
 .../clk/{clk-ls1x.c => loongson1/clk-loongson1b.c} | 71 ++++++----------------
 drivers/clk/loongson1/clk.c                        | 52 ++++++++++++++++
 drivers/clk/loongson1/clk.h                        | 21 +++++++
 5 files changed, 93 insertions(+), 55 deletions(-)
 create mode 100644 drivers/clk/loongson1/Makefile
 rename drivers/clk/{clk-ls1x.c => loongson1/clk-loongson1b.c} (68%)
 create mode 100644 drivers/clk/loongson1/clk.c
 create mode 100644 drivers/clk/loongson1/clk.h

-- 
1.9.1
