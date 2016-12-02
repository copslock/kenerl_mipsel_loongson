Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 10:49:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35794 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993014AbcLBJtfSpMP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 10:49:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 43108ADA4F8FA;
        Fri,  2 Dec 2016 09:49:26 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 09:49:28 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <kexec@lists.infradead.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/6] Kexec fixes and updates for MIPS platforms
Date:   Fri, 2 Dec 2016 10:49:05 +0100
Message-ID: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

This patch series tries to bring the support for MIPS up to date and make it more
generic (fix little-endian support, simplify code for 32/64 bit handling), as well
as to clean up some existing incorrect code (patches 1-4).

Patches 5 & 6 add new functionality - passing external DTBs and initrd, especially
the DTB support is required for platforms that use a recently introduced generic
kernel infrastructure.

Note that patch 5 (and 6, as it depends on patch 5) require changes in the kernel
that are currently pending review:
https://patchwork.linux-mips.org/patch/14615/

Core dump support is currently broken on all MIPS kernels and is also pending
review:
https://patchwork.linux-mips.org/patch/14587/
https://patchwork.linux-mips.org/patch/14586/

Patches 1-4 can be safely added without waiting for kernel patches to be merged,
but patches 5-6 should be held until the kernel patches are accepted in case changes
are requested.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

Marcin Nowakowski (6):
  mips: remove incorrect arch_usage string
  mips: use arch_options for both 32 and 64 bit variants
  mips: move arch option parsing from elf loader to common arch code
  mips: crashdump: add little-endian support
  mips: add dtb loading support
  mips: add option to load initrd from a specified file

 kexec/arch/mips/Makefile               | 13 +++++
 kexec/arch/mips/crashdump-mips.c       | 22 +++++---
 kexec/arch/mips/include/arch/options.h | 11 ++--
 kexec/arch/mips/kexec-elf-mips.c       | 96 +++++++++++++++++++---------------
 kexec/arch/mips/kexec-mips.c           | 46 +++++++++++++---
 kexec/arch/mips/kexec-mips.h           | 13 ++++-
 6 files changed, 142 insertions(+), 59 deletions(-)

-- 
2.7.4
