Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 01:12:56 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:60788 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011607AbaJ2AMyw7dGM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 01:12:54 +0100
Received: by mail-ie0-f202.google.com with SMTP id tr6so294346ieb.5
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 17:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QaW3yHCfrQ48mFZ1Nsbfsp/cD6qPHs+yPD+WujB6Qdw=;
        b=VQyIjZoUs8vHzFfrtg5vmeRpYgtVB/PLJBiAO01JFRw4/nt+Ch2k2g2+/KrfimKxMQ
         6dpax3IzrrCFq1VzGs0rZJxMzbV1pxlLS0wl2IEz69liOAePOicfanZSiB6TA7vyB9zf
         f6l56Gh/WmtDUYKWH7/LY4A4r6hfoIeW2OGPc/UihEOqaxQDj5cFbkalpIg4MbOUpUho
         VxYSjbpR31RithLvUZRk33WLuGvZbYBdlUgQpYVyhAPRkIecQ3RP0yXTo93brQ/KhfCc
         BjoyXV08S62gFdfK3H4HeJ5XXbIRB7GYo7sFU+zMsVtuCmiB+gIUwpWSONCwZb26mrDJ
         tYSg==
X-Gm-Message-State: ALoCoQkw1VsCRvz8dhps/hQTf4YImOEsFNIwvAR6urS81kRETRCp8KP73IntElPxqE7lTxPsh3tX
X-Received: by 10.182.92.234 with SMTP id cp10mr4957160obb.49.1414541567621;
        Tue, 28 Oct 2014 17:12:47 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si201720yhd.1.2014.10.28.17.12.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 17:12:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id wPYM9Wc7.1; Tue, 28 Oct 2014 17:12:47 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0FE52220E88; Tue, 28 Oct 2014 17:12:45 -0700 (PDT)
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
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] MIPS: GIC device-tree support
Date:   Tue, 28 Oct 2014 17:12:38 -0700
Message-Id: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43665
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

 .../bindings/interrupt-controller/mips-gic.txt     | 55 +++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/clocksource/Kconfig                        |  1 +
 drivers/clocksource/mips-gic-timer.c               | 37 ++++++++---
 drivers/irqchip/irq-mips-gic.c                     | 71 ++++++++++++++++++++--
 .../dt-bindings/interrupt-controller/mips-gic.h    |  9 +++
 6 files changed, 162 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/mips-gic.h

-- 
2.1.0.rc2.206.gedb03e5
