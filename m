Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:01:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21861 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994850AbdHGXBlzdfSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:01:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B964F94415F70;
        Tue,  8 Aug 2017 00:01:30 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:01:35
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/7] MIPS: generic kernel config improvements
Date:   Mon, 7 Aug 2017 16:01:11 -0700
Message-ID: <20170807230119.10629-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59406
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

This series introduces support for filtering which board support is
enabled based upon the ISA, endianness or other configuration. This
allows us to only include board support in kernels that it makes sense
for - eg. there's no point including support for systems that have 32
bit CPUs in 64 bit kernels.

It then makes a few tweaks to generic_defconfig & prevents direct use of
generic_defconfig, which is almost certainly not what a user wants.

Applies atop mips-for-linux-next at 246edadb70f7.


Paul Burton (7):
  MIPS: generic: Allow filtering enabled boards by requirements
  MIPS: SEAD-3: Only include in 32 bit kernels by default
  MIPS: NI 169445: Only include in 32r2el kernels
  MIPS: Prevent direct use of generic_defconfig
  MIPS: Make CONFIG_MIPS_MT_SMP default y
  MIPS: generic: Don't explicitly disable CONFIG_USB_SUPPORT
  MIPS: generic: Bump default NR_CPUS to 16

 MAINTAINERS                                     |  1 +
 arch/mips/Kconfig                               |  1 +
 arch/mips/Makefile                              | 23 ++++++-
 arch/mips/configs/generic/board-ni169445.config |  3 +
 arch/mips/configs/generic/board-sead-3.config   |  2 +
 arch/mips/configs/generic_defconfig             |  3 +-
 arch/mips/configs/malta_defconfig               |  1 -
 arch/mips/configs/malta_kvm_defconfig           |  1 -
 arch/mips/configs/malta_kvm_guest_defconfig     |  1 +
 arch/mips/configs/maltasmvp_defconfig           |  1 -
 arch/mips/configs/maltasmvp_eva_defconfig       |  1 -
 arch/mips/tools/generic-board-config.sh         | 90 +++++++++++++++++++++++++
 12 files changed, 120 insertions(+), 8 deletions(-)
 create mode 100755 arch/mips/tools/generic-board-config.sh

-- 
2.14.0
