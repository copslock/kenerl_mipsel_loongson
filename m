Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:21:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34797 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861043AbaGQIVW27Xau (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:21:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 88E59E737E1E3
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:21:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:15 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:14 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>
Subject: [PATCH 0/7] Misc GIC fixes
Date:   Thu, 17 Jul 2014 09:20:52 +0100
Message-ID: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41257
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

These patches address a number of issues with the existing GIC IRQ code.

The patchset is based on 3.16-rc5

Jeffrey Deans (7):
  MIPS: GIC: move GIC interrupt bitmap declarations
  MIPS: GIC: Move GIC_NUM_INTRS into platform irq.h
  MIPS: GIC: Remove GIC_FLAG_IPI
  MIPS: GIC: Prevent array overrun
  MIPS: GIC: Generalise check for pending interrupts
  MIPS: Malta: Fix dispatching of GIC interrupts
  MIPS: GIC: Fix GICBIS macro

 arch/mips/include/asm/gic.h            | 41 +++++++++++++---------------------
 arch/mips/include/asm/mach-malta/irq.h |  1 +
 arch/mips/include/asm/mach-sead3/irq.h |  1 +
 arch/mips/kernel/irq-gic.c             | 38 ++++++++++++++++++++++++-------
 arch/mips/mti-malta/malta-int.c        | 27 +++++++++++++++-------
 5 files changed, 66 insertions(+), 42 deletions(-)

-- 
2.0.0
