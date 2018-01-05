Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 11:31:55 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:39801 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAEKbtEd9gu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 11:31:49 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 10:31:30 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 5 Jan 2018 02:31:19 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/6] irqchip/mips-gic: Enable & use VEIC mode if available
Date:   Fri, 5 Jan 2018 10:31:04 +0000
Message-ID: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1515148289-298553-16961-111618-10
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188674
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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


This series enables the MIPS GIC driver to make use of the EIC mode
supported in some MIPS cores. In this mode, the cores 6 interrupt lines
are switched to represent a vector number, 0..63. Currently all GIC
interrupts are routed to a single CPU interrupt pin, but this is
inefficient since we end up checking both local and shared interrupt
flag registers for both local and shared interrupts. This introduces
additional latency into the interrupt paths. With EIC mode this can be
improved by using separate vectors for local and shared interrupts.

This series is based on 4.15-rc6 and has been tested on Boston, Malta &
SEAD3 MIPS platforms implementing a GIC with and without EIC mode
supported in hardware.



Matt Redfearn (6):
  MIPS: Move ehb() to barrier.h
  MIPS: CPS: Introduce mips_gic_enable_eic
  MIPS: Generic: Support GIC in EIC mode
  irqchip/mips-gic: Always attempt to enable EIC mode
  irqchip/mips-gic: Use separate vector for shared interrupts in EIC
    mode
  irqchip/mips-gic: Separate local interrupt handling.

 arch/mips/generic/irq.c            | 18 +++++++++---------
 arch/mips/include/asm/barrier.h    | 13 +++++++++++++
 arch/mips/include/asm/mips-gic.h   | 22 ++++++++++++++++++++++
 arch/mips/include/asm/mipsmtregs.h |  8 --------
 drivers/irqchip/irq-mips-gic.c     | 34 +++++++++++++++++++++++-----------
 5 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.7.4
