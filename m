Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 13:32:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35239 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009567AbbCWMcQVyaf- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 13:32:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 43263F888AA7E;
        Mon, 23 Mar 2015 12:32:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 23 Mar 2015 12:32:09 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.138) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 23 Mar 2015 12:32:09 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] GIC counter fixes
Date:   Mon, 23 Mar 2015 12:32:00 +0000
Message-ID: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

Here are a few patches to ensure the GIC counter is running before we attempt
to use it since the default value on a MIPS core can be '1' which means
the GIC counter will be stopped after a CPU reset. These patches are based
on 4.0-rc1.

Markos Chandras (3):
  irqchip: irq-mips-gic: Add new functions to start/stop the GIC counter
  clocksource: mips-gic-timer: Ensure GIC counter is running
  MIPS: Malta: malta-time: Ensure GIC counter is running

 arch/mips/mti-malta/malta-time.c     |  4 +++-
 drivers/clocksource/mips-gic-timer.c |  3 +++
 drivers/irqchip/irq-mips-gic.c       | 21 +++++++++++++++++++++
 include/linux/irqchip/mips-gic.h     |  2 ++
 4 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.3.3
