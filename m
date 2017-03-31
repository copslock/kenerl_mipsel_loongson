Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 11:01:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11912 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991786AbdCaJBCwm5Nq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 11:01:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E285439D8E1C3;
        Fri, 31 Mar 2017 10:00:53 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 10:00:56 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] MIPS: Xilfpga: Switch to generic kernel
Date:   Fri, 31 Mar 2017 10:00:40 +0100
Message-ID: <20170331090042.29168-1-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Couple of patches that convert the MIPSfpga platform to using
the generic kernels

Based on v4.11-rc4.

Regards,
ZubairLK

Zubair Lutfullah Kakakhel (2):
  MIPS: generic: Add support for MIPSfpga
  MIPS: Xilfpga: Switch to using generic defconfigs

 arch/mips/Kbuild.platforms                     |  1 -
 arch/mips/Kconfig                              | 24 ---------
 arch/mips/Makefile                             |  4 ++
 arch/mips/boot/dts/xilfpga/Makefile            |  2 +-
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts       |  8 +++
 arch/mips/configs/generic/board-xilfpga.config | 19 +++++++
 arch/mips/configs/xilfpga_defconfig            | 75 --------------------------
 arch/mips/generic/Kconfig                      |  6 +++
 arch/mips/generic/vmlinux.its.S                | 25 +++++++++
 arch/mips/xilfpga/Kconfig                      |  9 ----
 arch/mips/xilfpga/Makefile                     |  7 ---
 arch/mips/xilfpga/Platform                     |  3 --
 arch/mips/xilfpga/init.c                       | 44 ---------------
 arch/mips/xilfpga/intc.c                       | 22 --------
 arch/mips/xilfpga/time.c                       | 41 --------------
 15 files changed, 63 insertions(+), 227 deletions(-)
 create mode 100644 arch/mips/configs/generic/board-xilfpga.config
 delete mode 100644 arch/mips/configs/xilfpga_defconfig
 delete mode 100644 arch/mips/xilfpga/Kconfig
 delete mode 100644 arch/mips/xilfpga/Makefile
 delete mode 100644 arch/mips/xilfpga/Platform
 delete mode 100644 arch/mips/xilfpga/init.c
 delete mode 100644 arch/mips/xilfpga/intc.c
 delete mode 100644 arch/mips/xilfpga/time.c

-- 
2.10.2
