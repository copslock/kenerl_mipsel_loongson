Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2017 23:57:38 +0200 (CEST)
Received: from sauhun.de ([88.99.104.3]:36726 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993539AbdEUV53vNjps (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 May 2017 23:57:29 +0200
Received: from localhost (p54B335A2.dip0.t-ipconnect.de [84.179.53.162])
        by pokefinder.org (Postfix) with ESMTPSA id 7B9462C349E;
        Sun, 21 May 2017 23:57:29 +0200 (CEST)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 0/3] gpio: move include files out of include/linux/i2c
Date:   Sun, 21 May 2017 23:57:24 +0200
Message-Id: <20170521215727.1243-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, largely include/linux/platform_data because that is what most
of the moved include files contain.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (3):
  gpio: max732x: move header file out of I2C realm
  gpio: pcf857x: move header file out of I2C realm
  gpio: adp5588: move header file out of I2C realm

 arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
 arch/arm/mach-pxa/balloon3.c                   | 2 +-
 arch/arm/mach-pxa/littleton.c                  | 2 +-
 arch/arm/mach-pxa/stargate2.c                  | 2 +-
 arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
 arch/mips/ath79/mach-pb44.c                    | 2 +-
 drivers/gpio/gpio-adp5588.c                    | 2 +-
 drivers/gpio/gpio-max732x.c                    | 2 +-
 drivers/gpio/gpio-pcf857x.c                    | 2 +-
 drivers/input/keyboard/adp5588-keys.c          | 2 +-
 include/linux/{i2c => platform_data}/adp5588.h | 0
 include/linux/{i2c => platform_data}/max732x.h | 0
 include/linux/{i2c => platform_data}/pcf857x.h | 0
 15 files changed, 12 insertions(+), 12 deletions(-)
 rename include/linux/{i2c => platform_data}/adp5588.h (100%)
 rename include/linux/{i2c => platform_data}/max732x.h (100%)
 rename include/linux/{i2c => platform_data}/pcf857x.h (100%)

-- 
2.11.0
