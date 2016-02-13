Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 22:58:32 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33796 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012138AbcBMV6aQYv1i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:30 +0100
Received: by mail-lf0-f65.google.com with SMTP id 78so5751871lfy.1;
        Sat, 13 Feb 2016 13:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cz796i2mGK7eiTdbJcO/mw10x5wDpBH3guRF6ImPwoY=;
        b=dDjB1UXJ7gOl6BaWO/T/Q/64S9Pjll8lwqL9BypIVsQul2yCZVMA/MhQ4VkaswmR2b
         N9+UlTMN/E/2V2Hlygi4we0VIjs+9NmYMU6DBmb41fyJJMS+asvvd63+7+OHRqiHf8US
         V5y/v3KWg/BZUbtSGrrkIMLu8LHP8MezP2yMqUiAEP72pCJCNaRNIQrFzJVQ3Y6ci0BX
         ngSgek6WtlZ/GAUCVlaQiB+qGAtk3pYuSukVPLictjcAiqIrVJlZmDYDnoWlyzvIe7tJ
         BAOGjjZ8Nbvrykcj0gerbPvIY6KMtGvcKb1XdWXxISt0c/qOw7skbSQdj6umGfSn0q6P
         cJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cz796i2mGK7eiTdbJcO/mw10x5wDpBH3guRF6ImPwoY=;
        b=PYHhNcMlBVZUuS1Y9R6QEiI2W00zJvDDD5ajygyb/RpGyPag2GrTZNAXBNEtdeC2Sd
         DxWrc39cfzhtADvPf7Xf4cHoAJhFZoL77opn4AZOSuxa7rhRiYCiGXX1XKKAtuIeKHq0
         Wswc5gRL0gtF5E/XKzistvclQfGhD2qlzRiwKJ5AHTk0hxjUenaJataJ/fouEo2iL6Yg
         N3Jxwh8Dip7BO0tSS6Q+hoXfg1oMO71cVeuKVKD38p89dGTKPyH8eM7l4iiGHe7I67VM
         0v5EkCG9D5w89V24DcW2ITenqFHe+RiF6SfC6a48vwfgI6WL8sY1kZrxD6R1gJIKkj94
         oqAg==
X-Gm-Message-State: AG10YOTECHub1lEv/mtcfEVglM80Ax0Zayk+IhDedXiOqD/MIVZGaS3+HU5iCbZ7S8dsUg==
X-Received: by 10.25.16.214 with SMTP id 83mr3635119lfq.13.1455400704892;
        Sat, 13 Feb 2016 13:58:24 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:24 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH 00/10] MIPS: ath79: update devicetree support for AR9132
Date:   Sun, 14 Feb 2016 00:58:07 +0300
Message-Id: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Alban Bedel (1):
  MIPS: ath79: Fix the ar913x reference clock rate

Antony Pavlov (8):
  dt-bindings: clock: qca,ath79-pll: fix copy-paste typos
  MIPS: dts: qca: ar9132: fix typo: "ppl" -> "pll"
  MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
  MIPS: dts: qca: ar9132: use short references for uart, usb and spi nodes
  MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: use "ref" for reference clock name
  MIPS: ath79: update devicetree support for AR9132
  MIPS: ath79: setup.c: disable platform code for OF boards
  WIP: MIPS: ath79: add tl-wr1043nd{,no-dt}_defconfig

Weijie Gao (1):
  MIPS: ath79: Fix the ar724x clock calculation

 .../devicetree/bindings/clock/qca,ath79-pll.txt    |   6 +-
 arch/mips/ath79/clock.c                            | 160 +++++++++++++--------
 arch/mips/ath79/setup.c                            |  15 +-
 arch/mips/boot/dts/qca/ar9132.dtsi                 |  16 ++-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |  88 ++++++------
 arch/mips/configs/tl-wr1043nd-no-dt_defconfig      | 100 +++++++++++++
 arch/mips/configs/tl-wr1043nd_defconfig            |  98 +++++++++++++
 include/dt-bindings/clock/ath79-clk.h              |  20 +++
 8 files changed, 382 insertions(+), 121 deletions(-)
 create mode 100644 arch/mips/configs/tl-wr1043nd-no-dt_defconfig
 create mode 100644 arch/mips/configs/tl-wr1043nd_defconfig
 create mode 100644 include/dt-bindings/clock/ath79-clk.h

-- 
2.7.0
