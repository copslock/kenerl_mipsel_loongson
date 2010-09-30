Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 11:09:00 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:58704 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491091Ab0I3JI4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 11:08:56 +0200
Received: by pxi4 with SMTP id 4so584044pxi.36
        for <multiple recipients>; Thu, 30 Sep 2010 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mk37V1fkLNzuRRmHvyHG8/q5Lf3w9jXzmIpMMwC/qiU=;
        b=fuAjaGAtqlJEHyTB6P16kOoUW+ChPd/qfC60RC5Px9Ii19Zd6i6+XVbyv7VM0D5wGV
         SmkuP+kR4lPX3Q8bTRR6kXfVU2UjNOb1O0xaOnXOOb4d9FqwL4bCAeCg61Au1FVpgqfX
         ZXxn0G2Iyi/lD5jZVDJbAnO3ytqTFZIzTgko8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wNJxTp6UU7c2kzTEqLmh2tX0TvgnxDuq/jfhi8tFzpD50ZsbPQyHMjtUo5aI+j8K60
         DXUXHyuC/H8bs9NXAp0NOcBT5uGK8u+3PsykjNLA86WKORiVxpXD/Gkgi2u7JHA1qGnJ
         N1IAoWlvEdneUsHJk/aQepTi/qK5d5wfNIGgs=
Received: by 10.114.131.13 with SMTP id e13mr3721392wad.81.1285837729458;
        Thu, 30 Sep 2010 02:08:49 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id c10sm16210348wam.1.2010.09.30.02.08.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 02:08:36 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, dengcheng.zhu@gmail.com
Subject: [PATCH v7 0/6] MIPS performance event support v7
Date:   Thu, 30 Sep 2010 17:09:14 +0800
Message-Id: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 27895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24017

The following changes were made since v6:
o Remove the conditional code in mipspmu_get_irq(), a new member (irq) is
added to the struct mips_pmu.
o Remove function code from pmu.h, keep them duplicated in Oprofile and
Perf-events. The duplication would be resolved by the idea of using
Perf-events as the Oprofile backend. I'll submit a separate patchset to
do this after this one gets merged.
o The atomic64_read/set/... are replaced with local64_read/set/..., in
order to keep aligned with the changes of the Perf-events core.
o The patch order is adjusted.

v6: http://www.linux-mips.org/archives/linux-mips/2010-06/msg00143.html

Deng-Cheng Zhu (6):
  MIPS: define local_xchg from xchg_local to atomic_long_xchg
  MIPS/Oprofile: extract PMU defines for sharing
  MIPS: add support for software performance events
  MIPS: add support for hardware performance events (skeleton)
  MIPS/Perf-events: add callchain support
  MIPS: add support for hardware performance events (mipsxx)

 arch/mips/Kconfig                       |   10 +
 arch/mips/include/asm/local.h           |    2 +-
 arch/mips/include/asm/perf_event.h      |   25 +
 arch/mips/include/asm/pmu.h             |   94 +++
 arch/mips/kernel/Makefile               |    2 +
 arch/mips/kernel/perf_event.c           |  600 ++++++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c    | 1020 +++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c                |   18 +-
 arch/mips/kernel/unaligned.c            |    6 +
 arch/mips/math-emu/cp1emu.c             |    3 +
 arch/mips/mm/fault.c                    |   11 +-
 arch/mips/oprofile/op_model_loongson2.c |   18 +-
 arch/mips/oprofile/op_model_mipsxx.c    |   21 +-
 arch/mips/oprofile/op_model_rm9000.c    |   16 +-
 14 files changed, 1789 insertions(+), 57 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/include/asm/pmu.h
 create mode 100644 arch/mips/kernel/perf_event.c
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c
