Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:35:23 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:54698 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490949Ab0FIEfT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:19 +0200
Received: by pxi1 with SMTP id 1so2293665pxi.36
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TQ+XhTHeYqNn1TKEOHdulatP9F79edIrNmxkZr1+YbY=;
        b=EOLNMxCpYijiQFBLvLGrLDCYnDdfLu5I8IMhyeUZw+Prvg7LZGpg1LnQK90KFBKi+Y
         jh9+0dZNrkcxwey9bPXpdqMB/ozJnceOTzr1tmjuHdAzclYz0K5KplkgLQLv1KGe9dTZ
         /jXe3wakEIJh2mtgYXWCod6CJfmTUrox/n5Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qI1ag/VUY+pP9ZXr5/SkkvrO65145rMV1plwLWLthn1dYgGeGVNYehlXDxJRatLyOu
         mp9YqznaXpy9Of+RxU0ODQ1nYT7Rgpt/ql3gka7hbfTGAFZOAAan1vHcjv+/Ymne828d
         wxG/hMsBRV2m4/ppVuytGiotVPSaF8FyZGSCU=
Received: by 10.143.153.28 with SMTP id f28mr12734030wfo.330.1276058110565;
        Tue, 08 Jun 2010 21:35:10 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:10 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 0/7] MIPS performance event support v6
Date:   Wed,  9 Jun 2010 12:35:23 +0800
Message-Id: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
X-archive-position: 27092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6103

This patchset implements the low-level logic for the Linux performance
counter subsystem (Perf-events) on MIPS, which enables the collection of
all sorts of HW/SW performance events based on per-CPU or per-task.
For more information, please refer to tools/perf/Documentation/perf.txt.

Currently in the Oprofile module, MIPS PMUs are mainly categorized into 3
(mipsxx, loongson2 and rm9000). This patchset provides the skeleton code
together with the mipsxx specific code. The other 2 (and maybe more) can
be supported by adding new C files like the current perf_event_mipsxx.c.

To support mipsxx CPUs other than the implemented 24K/34K/74K/1004K, the
corresponding general event map, cache event map and raw event macros need
to be added. Please refer to init_hw_perf_events() for more info.

Tests were carried out on the Malta-R board. 24K/34K/74K/1004K cores and
SMVP/UP kernels have been basically tested. Any more tests are welcome.

To do this, you may want to compile the tool "perf" for your MIPS
platform. You can refer to the following URL:
http://www.linux-mips.org/archives/linux-mips/2010-04/msg00158.html

Please note: Before that patch is accepted, you can choose a "specific"
rmb() which is suitable for your platform -- an example is provided in
the description of that patch.

You also need to customize the CFLAGS and LDFLAGS in tools/perf/Makefile
for your libs, includes, etc.

In case you encounter the boot failure in SMVP kernel on multi-threading
CPUs, you may take a look at:
http://www.linux-mips.org/git?p=linux-mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020

CHANGES:
-----------------------------
v6 - v5:
o leaving the Oprofile framework changes to another patchset.
o changing the callchain support.
o re-defining local_xchg() to pass the build (see patch #7).
o following some of David Daney's suggestions:
  * CPU #if's removed from pmu.h
  * Copyright info modified
  * Removing the perf_irq redefinition
  * 64bit counters considered
  * Read/write funcs and register defs separated from event defs
  * Raw event support merged into the main part
v5 - v4:
o splitting up Perf-events patches (v4 patches 1~4 are now splitted into
v5 patches 1~7) for easier review.
o adding more info into the description of patches (especially how to test
this patchset).
o simplifying the 2 small functions mipspmu_get_pmu_id() and
mipspmu_get_max_events().
v4 - v3:
o placing the variable save_perf_irq properly (issue found by Wu Zhangjin)
o the patches 5~9 make Oprofile use Perf-events framework as backend.
v3 - v2:
o adding 1004K core support.
o slightly adjusting the code structure.
o adding more comments in the code.
o fixing some small coding style issues.
v2 - v1:
o Adjusting code structure as suggested by Wu Zhangjin. With this change,
hardware performance event support for loongson2 and rm9000 can be
conveniently implemented by adding and including new files like
perf_event_loongson2.c; Oprofile and Perf for MIPS are now sharing pmu.h;
Naming changes were made to some functions.
o Fixing the generic atomic64 issue reported by David Daney. Currently,
32bit kernel is using the generic version from lib. When Ralf Baechle's
common atomic64 version is ready, this may change.
o Adding raw event support. For more details, please refer to the code
comments for mipsxx_pmu_map_raw_event().
o Adding new software events - PERF_COUNT_SW_ALIGNMENT_FAULTS and
PERF_COUNT_SW_EMULATION_FAULTS.
o Fixing some small bugs.
o Adding new comments for the code.
o Making some code style changes.
v1:
o Using generic atomic64 operations from lib.
o SMVP/UP kernels are supported (not for SMTC).
o 24K/34K/74K cores are implemented.
o Currently working when Oprofile is _not_ available.
o Minimal software perf events are supported.
-----------------------------

Deng-Cheng Zhu (7):
  MIPS/Oprofile: extract PMU defines/helper functions for sharing
  MIPS: use generic atomic64 in non-64bit kernels
  MIPS: add support for software performance events
  MIPS: add support for hardware performance events (skeleton)
  MIPS/Perf-events: add callchain support
  MIPS: add support for hardware performance events (mipsxx)
  MIPS: define local_xchg from xchg_local to atomic_long_xchg

 arch/mips/Kconfig                       |   11 +
 arch/mips/include/asm/atomic.h          |    4 +
 arch/mips/include/asm/local.h           |    2 +-
 arch/mips/include/asm/perf_event.h      |   26 +
 arch/mips/include/asm/pmu.h             |  299 ++++++++++++
 arch/mips/kernel/Makefile               |    2 +
 arch/mips/kernel/perf_event.c           |  623 ++++++++++++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c    |  802 +++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c                |   18 +-
 arch/mips/kernel/unaligned.c            |    5 +
 arch/mips/math-emu/cp1emu.c             |    3 +
 arch/mips/mm/fault.c                    |   11 +-
 arch/mips/oprofile/op_model_loongson2.c |   18 +-
 arch/mips/oprofile/op_model_mipsxx.c    |  147 +------
 arch/mips/oprofile/op_model_rm9000.c    |   16 +-
 15 files changed, 1805 insertions(+), 182 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/include/asm/pmu.h
 create mode 100644 arch/mips/kernel/perf_event.c
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c
