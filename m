Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 09:52:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11408 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992417AbcGGHvdDT256 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 09:51:33 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8A136D614ABBC;
        Thu,  7 Jul 2016 08:51:14 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 7 Jul 2016 08:51:16 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/3] Support for MIPSr6 CPU hotplug.
Date:   Thu, 7 Jul 2016 08:50:37 +0100
Message-ID: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

This series adds support for hotplug of MIPSr6 Virtual Processors such
as found in the I6400.

Patch 1 allows VPs other than VP0 within a MIPSr6 core to start when a
core is booted.

Patch 2 adds support for removing CPUs, allowing CPU hotpug to be used
with MIPSr6 devices.

Patch 3 is a tidy up to move the CPU hotplug config option into the
Kernel type menu within menuconfig.

Based atop 4.7-rc6


Matt Redfearn (3):
  MIPS: smp-cps: Allow booting of CPU other than VP0 within a core
  MIPS: smp-cps: Add support for CPU hotplug of MIPSr6 processors
  MIPS: Move CPU Hotplug config option into submenu

 arch/mips/Kconfig          | 20 ++++++++++----------
 arch/mips/kernel/smp-cps.c | 41 ++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 19 deletions(-)

-- 
2.7.4
