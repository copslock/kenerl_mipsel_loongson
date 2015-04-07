Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 21:44:31 +0200 (CEST)
Received: from mail-qk0-f201.google.com ([209.85.220.201]:33664 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014198AbbDGTo3cLJhO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 21:44:29 +0200
Received: by qkbx191 with SMTP id x191so7949030qkb.0
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 12:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tz10POap153yKs9Z0MNCxqFBcvP0sLttnob1s/8g7tA=;
        b=RCV68fHE+jiYfjfPDly0HLOWx8ezEQSaKsYF28n4MbPkBcCggOA9rUpY6Cl5+/Hmhv
         OGgu3d2VuzMTMZA9HLTB9xACrzeZ6pD8V9lRo6IXZCEcfMIxYWEIw0h7EnTNZ4Cmt1Oi
         KxNlbWBCTs4jl0u0c5Q0I6EktcG/7JTIxTUBmPWe11agSWCoH4e3up+xHYL5cZWze6lh
         YfnTCWXg+dSgky+vLTXRI2yRmb0ghYsaSyqSu4t2Gpb9FsItDnU6BaEk/KhiW3V7SIu7
         0yuPrHeBQuCDLsytNHfTfxd7wJChAKc63i4fwaIGVdwumVBaJftvUbxoc8RM5esNQbp9
         fhhQ==
X-Gm-Message-State: ALoCoQnmHkdSYnIl1gsuGHUY6acmXbjn+B33UHta+b5lejeEhUOIz1RGRNuBPssg1g61Xx8/u9YR
X-Received: by 10.182.149.230 with SMTP id ud6mr27002463obb.36.1428435864786;
        Tue, 07 Apr 2015 12:44:24 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id f100si384863yhp.7.2015.04.07.12.44.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 12:44:24 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id KIKvQyaY.1; Tue, 07 Apr 2015 12:44:24 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 6CC52220445; Tue,  7 Apr 2015 12:44:23 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V3 0/2] pinctrl: Support for IMG Pistachio
Date:   Tue,  7 Apr 2015 12:44:20 -0700
Message-Id: <1428435862-14354-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46813
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

This series adds support for the system pin and GPIO controller on the IMG
Pistachio SoC.  Pistachio's system pin controller manages 99 pins, 90 of
which are MFIOs which can be muxed between multiple functions or used
as GPIOs.  The GPIO control for the 90 MFIOs is broken up into banks
of 16.  Pistachio also has a second pin controller, the RPU pin controller,
which will be supported by a future patchset through an extension to this
driver.

Tested on an IMG Pistachio BuB.  Based on mips-for-linux-next.

Changes from v2:
 - Removed module stuff that ends up being compiled out.
Changes from v1:
 - Documented pin + function generic binding.
 - Changed compatible string to "img,pistachio-system-pinctrl".
 - Addressed some review comments.
 - A couple of bug fixes.

Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>

Andrew Bresticker (2):
  pinctrl: Add Pistachio SoC pin control binding document
  pinctrl: Add Pistachio SoC pin control driver

 .../bindings/pinctrl/img,pistachio-pinctrl.txt     |  217 +++
 drivers/pinctrl/Kconfig                            |    6 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-pistachio.c                | 1502 ++++++++++++++++++++
 4 files changed, 1726 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-pistachio.c

-- 
2.2.0.rc0.207.ga3a616c
