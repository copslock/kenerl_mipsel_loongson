Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:29:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11994 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVS3eVI0UP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:29:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0C6CAF95B4C69;
        Tue, 22 Sep 2015 19:29:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:29:28 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:29:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Subject: [PATCH 0/3] MIPS GIC fixes
Date:   Tue, 22 Sep 2015 11:29:08 -0700
Message-ID: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series fixes a couple of problems with the MIPS GIC support,
impacting systems with the 64 bit CM3 and those with multithreading and
non-contiguous numbering for VP(E)s across cores.

Paul Burton (3):
  MIPS: CM: provide a function to map from CPU to VP ID
  irqchip: mips-gic: convert CPU numbers to VP IDs
  irqchip: mips-gic: fix pending & mask reads for MIPS64 with 32b GIC

 arch/mips/include/asm/mips-cm.h | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-mips-gic.c  | 12 ++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.5.3
