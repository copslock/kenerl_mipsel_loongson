Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 11:44:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26319 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009737AbbDQJo2vbYLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 11:44:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DE86EBAD8B439;
        Fri, 17 Apr 2015 10:44:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Apr 2015 10:44:24 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 17 Apr 2015 10:44:23 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>
CC:     James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: Add Pistachio Fast Debug Channel support
Date:   Fri, 17 Apr 2015 10:44:14 +0100
Message-ID: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches add support for the per-VPE Fast Debug Channels (FDC) [1]
in the interAptiv VPEs on Pistachio. I'd like to get these into v4.1 via
the MIPS tree as they're pretty simple and they just allow useful new
functionality (FDC console output etc) to be enabled on a new platform
(Pistachio), so the risk is minimal.

The first patch moves a workaround from the GIC IRQ driver to the Malta
platform code, since the problem doesn't affect Pistachio so it must be
Malta specific.

The second patch enables the Common Device Memory Maps (CDMM), and the
FDC IRQs on Pistachio to allow the FDC TTY driver to be discovered and
to work without polling.

[1] http://www.linux-mips.org/wiki/FDC

James Hogan (2):
  MIPS: Malta: Make GIC FDC IRQ workaround Malta specific
  MIPS: Pistachio: Support CDMM & Fast Debug Channel

 arch/mips/mti-malta/malta-time.c | 20 +++++++++++++-------
 arch/mips/pistachio/init.c       |  8 +++++++-
 arch/mips/pistachio/time.c       |  5 +++++
 drivers/irqchip/irq-mips-gic.c   | 10 ----------
 4 files changed, 25 insertions(+), 18 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-mips@linux-mips.org
-- 
2.0.5
