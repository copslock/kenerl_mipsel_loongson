Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 00:20:37 +0100 (CET)
Received: from mail-qg0-f74.google.com ([209.85.192.74]:35468 "EHLO
        mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012206AbaJ2XUAtAw2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 00:20:00 +0100
Received: by mail-qg0-f74.google.com with SMTP id q107so284220qgd.5
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 16:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qb6dYwyeuehILyeqdbSjab8Khp3XTu/WqoBkYggY9so=;
        b=drxSiNUrjVzYF4qbhHiXTCFc0gpZVv2zo5uLgmzLmJgtdmfYRxzK8Ft1wiYAg5snKj
         r91fYL7b/d/gRHvrJCqIeuizvQPHosH2AC20/PKzaZZVo0+oeoEvfJ4KOlxyP0m5C3bT
         xb0Z6TM437PSlOadYK+cEm4ItNLeeemuHc4F0kq/fDk1zgxIRg2oC8GkGu7piKkUgBE+
         T35pd7X9AesJT5lFvlwiNyREVlUazYjmQvQyAmnhhQAzUmPD9pmW2JkMOUdjMJMaWR+f
         8EA4BhDkRE7eYOcAtO/gS7MYdBnffDJpG4GUxboAdzPuY5MvtdUIEaA5s5Vch3JQwFTA
         lkCg==
X-Gm-Message-State: ALoCoQnbotIwsYN5uIYnemk4Nb8TPCSEPffRr6NjkoOxqH2PADVDDYJJCtY1o6jsaURdRs045JZs
X-Received: by 10.236.8.100 with SMTP id 64mr3835422yhq.25.1414624793390;
        Wed, 29 Oct 2014 16:19:53 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si350856yhd.1.2014.10.29.16.19.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 16:19:53 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id A7RvuGHj.1; Wed, 29 Oct 2014 16:19:53 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id AB8352205C1; Wed, 29 Oct 2014 16:19:51 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/4] MIPS: GIC device-tree support
Date:   Wed, 29 Oct 2014 16:19:46 -0700
Message-Id: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43733
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

This series add support for mapping and routing GIC interrupts as well
as setting up the GIC timer through device-tree.  Patches 1 adds the
"mti" vendor prefix, patch 2 adds the GIC binding document, and patches
3 and 4 add device-tree support for the GIC irqchip and clocksource drivers,
respectively.

Based on next-20141028, which includes part 1 [0] and part 2 [1] of my
GIC cleanup series.

Changes from v3:
 - dropped the CPU name from the compatible string
 - replaced available-cpu-vectors property with reserved-cpu-vectors
 - made reg property optional
 - probed GIC timer from GIC irqchip driver

Changes from v2:
 - added back third cell to specifier to differentiate between shared and
   local interrupts
 - added timer sub-node and it's properties
 - changed compatible string to include CPU version
 - rebased on GIC cleanup series

Changes from v1:
 - updated bindings to drop third interrupt cell and remove CPU interrupt
   controller as the parent of the GIC
 - moved GIC to drivers/irqchip/
 - other minor fixes/cleanups

[0] https://lkml.org/lkml/2014/9/18/487
[1] https://lkml.org/lkml/2014/10/20/481

Andrew Bresticker (4):
  of: Add vendor prefix for MIPS Technologies, Inc.
  of: Add binding document for MIPS GIC
  irqchip: mips-gic: Add device-tree support
  clocksource: mips-gic: Add device-tree support

 .../bindings/interrupt-controller/mips-gic.txt     | 55 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/clocksource/Kconfig                        |  1 +
 drivers/clocksource/mips-gic-timer.c               | 35 ++++++--
 drivers/irqchip/irq-mips-gic.c                     | 99 ++++++++++++++++++++--
 .../dt-bindings/interrupt-controller/mips-gic.h    |  9 ++
 include/linux/irqchip/mips-gic.h                   |  3 +
 7 files changed, 191 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/mips-gic.h

-- 
2.1.0.rc2.206.gedb03e5
