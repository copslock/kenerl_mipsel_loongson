Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 09:58:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37728 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993014AbcLBI6kv7q20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 09:58:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EDF4AC4939B4B;
        Fri,  2 Dec 2016 08:58:31 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 08:58:34 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/4] Kexec fixes for SMP
Date:   Fri, 2 Dec 2016 09:58:27 +0100
Message-ID: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55917
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

Existing kexec code for SMP has been developed and tested on Cavium Octeon CPUs
and doesn't work properly on all platforms.

This series does some minor cleanups in the kexec code (patches 1 & 2), then
makes the current implementation conditional on a new kconfig symbol that is
enabled on Cavium Octeon CPUs.

Finally a new handler for kexec on SMP systems is added to generic platforms.

This patch series should be applied on top of the earlier kexec cleanup
patch series, most notably it won't apply without
https://patchwork.linux-mips.org/patch/14615/

Marcin Nowakowski (4):
  MIPS: kexec: remove SMP_DUMP
  MIPS: Kconfig: fix indentation for kexec-related entries
  MIPS: kexec: make current SMP handling conditional
  MIPS: kexec: add SMP hooks for generic platform

 arch/mips/Kconfig                  | 19 ++++++++++++-------
 arch/mips/generic/kexec.c          |  7 +++++++
 arch/mips/include/asm/kexec.h      |  2 ++
 arch/mips/include/asm/smp.h        |  6 ------
 arch/mips/kernel/crash.c           | 10 ++++++++--
 arch/mips/kernel/machine_kexec.c   |  4 +++-
 arch/mips/kernel/relocate_kernel.S |  6 +++---
 arch/mips/kernel/smp.c             | 17 -----------------
 8 files changed, 35 insertions(+), 36 deletions(-)

-- 
2.7.4
