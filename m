Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:18:57 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44531 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820509Ab3F2USUt863d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:20 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id 32AC6402E2;
        Sat, 29 Jun 2013 20:18:08 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 00/10] MIPS: BCM63XX: improve BMIPS support
Date:   Sat, 29 Jun 2013 22:17:42 +0200
Message-Id: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

This patchset aims at unifying the different BMIPS support code to allow
building a kernel that runs on multiple BCM63XX SoCs which might have
different BMIPS flavours on them, regardless of SMP support enabled in
the kernel.

The first few patches clean up BMIPS itself and prepare it for multi-cpu
support, while the latter add support to BCM63XX for running a SMP kernel
with support for all SoCs, even those that do not have a SMP capable
CPU.

This patchset is runtime tested on BCM6348, BCM6328 and BCM6368, to
verify that it actually does what it claims it does.

Lacking hardware, it is only build tested for BMIPS4380 and BMIPS5000.

Jonas Gorski (10):
  MIPS: bmips: fix compilation for BMIPS5000
  MIPS: allow asm/cpu.h to be included from assembly
  MIPS: bmips: add macros for testing the current bmips CPU
  MIPS: bmips: change compile time checks to runtime checks
  MIPS: bmips: merge CPU options into one option
  MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
  MIPS: bmips: add a helper function for registering smp ops
  MIPS: BCM63XX: always register bmips smp ops
  MIPS: BCM63XX: change the guard to a BMIPS4350 check
  MIPS: BCM63XX: disable SMP also on BCM3368

 arch/mips/Kconfig             |   78 ++++++-------
 arch/mips/bcm63xx/Kconfig     |    8 ++
 arch/mips/bcm63xx/prom.c      |   14 +--
 arch/mips/include/asm/bmips.h |   52 ++++++---
 arch/mips/include/asm/cpu.h   |    3 +
 arch/mips/kernel/bmips_vec.S  |   55 ++++++++--
 arch/mips/kernel/smp-bmips.c  |  241 ++++++++++++++++++++++-------------------
 7 files changed, 264 insertions(+), 187 deletions(-)

-- 
1.7.10.4
