Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 20:44:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15283 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007242AbbEZSoikGivT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 20:44:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BA1BB3E68527B;
        Tue, 26 May 2015 19:44:31 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 19:42:32 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 19:42:31 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2 0/7] Clocksource changes for Pistachio CPUFreq
Date:   Tue, 26 May 2015 15:39:01 -0300
Message-ID: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

The purpose of this patchset is to support CPUFreq on Pistachio SoC.
However, given Pistachio uses the MIPS GIC clocksource and clockevent
drivers (clocked from the CPU), adding CPUFreq support needs some work.

This patchset changes the MIPS GIC clockevent driver to update
the frequency of the per-cpu clockevents using a clock notifier.

Then, we add a clocksource driver for IMG Pistachio SoC, based on the
general purpose timers. The SoC only provides four timers, so we can't
use them to implement the four clockevents and the clocksource.

However, we can use one of these timers to provide a clocksource and
a sched clock. Given the general purpose timers are clocked from the
peripheral system clock tree, they are not affected by CPU rate changes.

Patches 1 to 3 are just style cleaning and preparation work. Patch 4
adds the clockevent frequency update.

Patches 5 and 6 add the new clocksource driver.

Patch 7 introduces an option to enable the timer based clocksource
on Pistachio.

For CPUFreq to really work, clk driver changes are needed to support
MIPS PLL clock rate change. Patches for this will be posted soon.

This series apply on v4.1-rc5. As always, comments and feedback are welcome!

Changes since v1
----------------

Addressed review comments by Andrew:
   * Fix typo
   * Fix style issues
   * Use readl/writel accessors instead of raw variants
   * Drop spurious comment and of_device_id table
   * Add a pistachio_ prefix to clocksource functions

Ezequiel Garcia (7):
  clocksource: mips-gic: Enable the clock before using it
  clocksource: mips-gic: Add missing error returns checks
  clocksource: mips-gic: Split clocksource and clockevent initialization
  clocksource: mips-gic: Update clockevent frequency on clock rate
    changes
  clocksource: Add Pistachio SoC general purpose timer binding document
  clocksource: Add Pistachio clocksource-only driver
  mips: pistachio: Allow to enable the external timer based clocksource

 .../bindings/timer/img,pistachio-gptimer.txt       |  28 +++
 arch/mips/Kconfig                                  |   1 +
 arch/mips/pistachio/Kconfig                        |  13 ++
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/mips-gic-timer.c               |  65 ++++++-
 drivers/clocksource/time-pistachio.c               | 194 +++++++++++++++++++++
 7 files changed, 297 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
 create mode 100644 arch/mips/pistachio/Kconfig
 create mode 100644 drivers/clocksource/time-pistachio.c

-- 
2.3.3
