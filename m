Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 20:43:53 +0100 (CET)
Received: from mail-vc0-f201.google.com ([209.85.220.201]:44134 "EHLO
        mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013552AbaKLTnwMiQKU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 20:43:52 +0100
Received: by mail-vc0-f201.google.com with SMTP id id10so192921vcb.2
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 11:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hmb1QOjqU8U7pNtwaqLJ5B9jRpEpg39bnWhf+/MTMME=;
        b=CDrewNkQdHM6iiScl+dZzxDjTiRKhiKn946J0M2YJghnB7dPdOqjjgYmMe8vYoptr5
         bbN1RGsATjUYUyu+f5bCc7+S5bDh3iYAuhnIlEy9bByYkdA7ieEsEjdCZF/Azu3Xuxsd
         wMz40fMcuTppsJwxYXt+BRAOn4d+0LYZMBg6PpWlAj0ZkQEOLv74KbQ3uWGiVXZwPJcY
         up2QUg8llHBgTE6Otvgq8eXkdDGHFgMHKWXApwHt8hmkPmuHH9YhpRZtiLxGirjn13HQ
         U7JQ8MIqWOp3lu0uCMJhcOA9imEr3cNZi0qZ1SYvCiopXKtopViFp3aQo8n8TnHjJLij
         SA6g==
X-Gm-Message-State: ALoCoQmyxHk9ka57+6vp++n36F/e1qdnfrsYA15pNYFQVtf8qlbNCuwgJ72KeeAGdeuJd2V3DDQf
X-Received: by 10.236.98.71 with SMTP id u47mr38073691yhf.30.1415821426245;
        Wed, 12 Nov 2014 11:43:46 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si962781yho.7.2014.11.12.11.43.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 11:43:46 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ITh2pWoo.1; Wed, 12 Nov 2014 11:43:46 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 6C2A7220B2A; Wed, 12 Nov 2014 11:43:44 -0800 (PST)
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
Subject: [PATCH V5 0/4] MIPS: GIC device-tree support
Date:   Wed, 12 Nov 2014 11:43:35 -0800
Message-Id: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44070
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

Changes from v4:
 - don't probe clocksource from irqchip; just WARN() if device-tree
   is incorrect

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

 .../bindings/interrupt-controller/mips-gic.txt     | 55 +++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/clocksource/Kconfig                        |  1 +
 drivers/clocksource/mips-gic-timer.c               | 41 ++++++++--
 drivers/irqchip/irq-mips-gic.c                     | 92 ++++++++++++++++++++--
 .../dt-bindings/interrupt-controller/mips-gic.h    |  9 +++
 6 files changed, 187 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/mips-gic.h

-- 
2.1.0.rc2.206.gedb03e5
