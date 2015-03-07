Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 19:31:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61095 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007380AbbCGSbnRcoH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 19:31:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4DD3E6897D5E6;
        Sat,  7 Mar 2015 18:31:34 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 7 Mar
 2015 18:31:37 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sat, 7 Mar 2015
 10:31:29 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <macro@linux-mips.org>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 00/17] MIPS: Add cputime/clock/hrtick features
Date:   Sat, 7 Mar 2015 10:30:18 -0800
Message-ID: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 2.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

Some generic features are applicable to MIPS but currently missing. Some
need low-level support. This patch set is mainly for providing high
resolution cpu/task time accounting. Testing was done on Malta. Welcome
Tested-by's for other platforms.

Changes:
v2 - v1:
o Added plat dependency for clocksource versatile.
o Use common func for both read_sched_clock and sb1250_hpt_read in csrc-sb1250.

Deng-Cheng Zhu (17):
  MIPS: Add SCHED_HRTICK support
  MIPS: Fall back to generic implementation of cmpxchg64 on 32-bit
    platforms
  MIPS: Add support for full dynticks CPU time accounting
  clocksource: versatile: Add PLAT_VERSATILE dependency
  MIPS: Add sched_clock support
  MIPS: csrc-r4k: Implement read_sched_clock
  MIPS: csrc-bcm1480: Remove FSF mail address from GPL notice
  MIPS: csrc-bcm1480: Implement read_sched_clock
  MIPS: csrc-ioasic: Remove FSF mail address from GPL notice
  MIPS: csrc-ioasic: Implement read_sched_clock
  MIPS: sgi-ip27: Implement read_sched_clock
  MIPS: cevt-txx9: Implement read_sched_clock
  MIPS: jz4740: Implement read_sched_clock
  MIPS: csrc-sb1250: Extract hpt cycle acquisition from sb1250_hpt_read
  MIPS: csrc-sb1250: Remove FSF mail address from GPL notice
  MIPS: csrc-sb1250: Implement read_sched_clock
  MIPS: Add support for fine granularity task level IRQ time accounting

 arch/mips/Kconfig               |  6 ++++++
 arch/mips/include/asm/cmpxchg.h | 11 ++++++-----
 arch/mips/jz4740/time.c         |  8 ++++++++
 arch/mips/kernel/cevt-txx9.c    |  9 +++++++++
 arch/mips/kernel/csrc-bcm1480.c | 12 ++++++++----
 arch/mips/kernel/csrc-ioasic.c  | 13 +++++++++----
 arch/mips/kernel/csrc-r4k.c     |  8 ++++++++
 arch/mips/kernel/csrc-sb1250.c  | 23 +++++++++++++++++------
 arch/mips/sgi-ip27/ip27-timer.c |  8 ++++++++
 drivers/clocksource/Kconfig     |  2 +-
 10 files changed, 80 insertions(+), 20 deletions(-)

-- 
2.3.2
