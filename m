Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 04:56:18 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:34752 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006566AbbBYD4Qk1xSY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 04:56:16 +0100
Received: by iecrd18 with SMTP id rd18so450659iec.1
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 19:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bsrE4+KiE7tudJkoVX4majyf3V0+u9izyQIVRy1UxR0=;
        b=Wo31o6aPgIJeXLWtEe9wsaG8WjFqhA3g9dDLs8tj6BLxakMOnM66RF6KTWrfgV4MAw
         EXUBemZFYpFdOsKC/JaocldKRirYYxCnSp4UqfdN/HxVFIf0yyMbzHTAumS5lGeJOAbD
         zM7hTLjq0JB3GLQoRk8A1M3uQAsu9VgDKBMl9PUQ6EEzlvAn/jCkJNR5GWRRM6OqN7dH
         pZXAoNTq7Ct23uvfUJocrIpaJ6BMEPxRL4gg1A33XnQrxfviNBk6LzWZBpIgWhUzi2Qi
         TdX/LFXGwCBpUnwa4+Ly3TY3oe5tNSg9UCfENCauuujWpyuRHsfO1zEP23EI96NIri/p
         jLag==
X-Gm-Message-State: ALoCoQmhzZnpP65XpGxbD/ajA8C7wAvmn6dfpYOSwj1hJ++BgtdZmhfx5udKGScF1WHIE969S5go
X-Received: by 10.182.108.193 with SMTP id hm1mr1296422obb.43.1424836571000;
        Tue, 24 Feb 2015 19:56:11 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 26si416796yhb.6.2015.02.24.19.56.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 19:56:10 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 4vvYaXNu.1; Tue, 24 Feb 2015 19:56:10 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id A39F2220DB2; Tue, 24 Feb 2015 19:56:09 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/7] clk: Common clock support for IMG Pistachio
Date:   Tue, 24 Feb 2015 19:56:00 -0800
Message-Id: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

This series adds common clock support for the IMG Pistachio SoC.
Pistachio has two clock controllers (core and peripheral) and two
general control blocks (peripheral and top) which also contain
several clock gates.  Like the recently submitted pinctrl driver [1],
this driver is written so that it's hopefully easy to add support
for future IMG SoCs.

Tested on an IMG Pistachio BuB.  Based on 4.0-rc1 + my series adding
Pistachio platform support [2], which introduces the MACH_PISTACHIO
Kconfig symbol.  A branch with this series and the dependent patches
is available at [3].  I'd like this to go through the MIPS tree with
Mike's or Stephen's ACK if possible.

Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>

[1] https://lkml.org/lkml/2015/2/23/705
[2] https://lkml.org/lkml/2015/2/23/694
[3] https://github.com/abrestic/linux/tree/pistachio-clk-v1

Andrew Bresticker (7):
  clk: Add binding document for Pistachio clock controllers
  clk: Add basic infrastructure for Pistachio clocks
  clk: pistachio: Add PLL driver
  clk: pistachio: Register core clocks
  clk: pistachio: Register peripheral clocks
  clk: pistachio: Register system interface gate clocks
  clk: pistachio: Register external clock gates

 .../devicetree/bindings/clock/pistachio-clock.txt  | 123 +++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/pistachio/Makefile                     |   3 +
 drivers/clk/pistachio/clk-pistachio.c              | 329 +++++++++++++++++
 drivers/clk/pistachio/clk-pll.c                    | 401 +++++++++++++++++++++
 drivers/clk/pistachio/clk.c                        | 140 +++++++
 drivers/clk/pistachio/clk.h                        | 174 +++++++++
 include/dt-bindings/clock/pistachio-clk.h          | 183 ++++++++++
 8 files changed, 1354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/pistachio-clock.txt
 create mode 100644 drivers/clk/pistachio/Makefile
 create mode 100644 drivers/clk/pistachio/clk-pistachio.c
 create mode 100644 drivers/clk/pistachio/clk-pll.c
 create mode 100644 drivers/clk/pistachio/clk.c
 create mode 100644 drivers/clk/pistachio/clk.h
 create mode 100644 include/dt-bindings/clock/pistachio-clk.h

-- 
2.2.0.rc0.207.ga3a616c
