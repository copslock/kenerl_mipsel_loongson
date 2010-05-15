Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:37:40 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:38796 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab0EOPhg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:37:36 +0200
Received: by pxi1 with SMTP id 1so1894720pxi.36
        for <multiple recipients>; Sat, 15 May 2010 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WYKwiTIWFWB75FWXY2nA3daw/hGN64rXQHkI9VCFkb8=;
        b=L2x/6C3u5C8XFro2jPHIEwozp3BmfcUTXrjSAHzBEHJk3KvwO6tY/AwElIlHOaxyJk
         /NnH8M3CxI0Y8obqFRfD3g0pwKrMd63MOUVpYwzC0F9SmTwu5cH6pWrg9N+QicEC90N0
         Wm7/V/fqCYNW5FbodRJZLvcy8VhcI8D/UbsjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ro9x7DPDj37b79vNB/l59T8bfXR9dYyYDdna4sC5JL04jxjjIl2FCmdt3uz38ne3BR
         qmY2mQVhWSBkEj2apMoD0XPjUDYF9hxwYh6aLo63hG3VrBaJknBJzxwrWXFz6CMfs96N
         WiMFhIZyLchtmZ2dOUHEWLqNjXbIO2I72B8gE=
Received: by 10.114.188.3 with SMTP id l3mr2339092waf.150.1273937847831;
        Sat, 15 May 2010 08:37:27 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.37.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:37:27 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 0/9] MIPS performance event support v4
Date:   Sat, 15 May 2010 23:36:46 +0800
Message-Id: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

The patches 1~4 (can be applied/built/tested independently) of this
package implement the low-level logic for the Linux performance counter
subsystem (Perf-events) on MIPS, which enables the collection of all sorts
of HW/SW performance events based on per-CPU or per-task. For more
information, please refer to tools/perf/Documentation/perf.txt.

And No. 5~9 make Oprofile use Perf-events framework as backend. This
effort makes the bug-fixes shared by different pmu users/clients (for now,
Oprofile & Perf-events), and make them coexist in the system without
locking issues, and make their results comparable.

The whole patchset was tested on the Malta-R board. 24K/34K/74K/1004K
cores and SMVP/UP kernels have been basically tested. Welcome any more
tests against these cores for Perf-events and all mipsxx CPUs for
Oprofile.

Note:
1) To support mipsxx CPUs other than 24K/34K/74K/1004K, the general event
map, the cache event map and the raw event macros need to be done. Please
refer to init_hw_perf_events() for more info.
2) To support other CPUs which have different PMU than mipsxx, such as
RM9000 and LOONGSON2, additional files perf_event_$cpu.c need to be
created.

So, the patches 1~4 can be reviewed and applied (if OK, hope so) without
affecting the existing Oprofile and other parts --- only a new kernel
facility is brought in :-) And the patches 5~9 can be applied after
perf_event_rm9000.c and perf_event_loongson2.c are added in, because 5~9
removed all the old Oprofile interfaces and replaced with new ones, which
will call into the rm9000/loongson2 Perf-events backend on corresponding
CPUs.

CHANGES:
-----------------------------
v4 - v3:
- placing the variable save_perf_irq properly (issue found by Wu Zhangjin)
- the patches 5~9 make Oprofile use Perf-events framework as backend.
v3 - v2:
- adding 1004K core support.
- slightly adjusting the code structure.
- adding more comments in the code.
- fixing some small coding style issues.
v2 - v1:
- Adjusting code structure as suggested by Wu Zhangjin. With this change,
hardware performance event support for loongson2 and rm9000 can be
conveniently implemented by adding and including new files like
perf_event_loongson2.c; Oprofile and Perf for MIPS are now sharing pmu.h;
Naming changes were made to some functions.
- Fixing the generic atomic64 issue reported by David Daney. Currently,
32bit kernel is using the generic version from lib. When Ralf Baechle's
common atomic64 version is ready, this may change.
- Adding raw event support. For more details, please refer to the code
comments for mipsxx_pmu_map_raw_event().
- Adding new software events - PERF_COUNT_SW_ALIGNMENT_FAULTS and
PERF_COUNT_SW_EMULATION_FAULTS.
- Fixing some small bugs.
- Adding new comments for the code.
- Making some code style changes.
v1:
- Using generic atomic64 operations from lib.
- SMVP/UP kernels are supported (not for SMTC).
- 24K/34K/74K cores are implemented.
- Currently working when Oprofile is _not_ available.
- Minimal software perf events are supported.
-----------------------------

Deng-Cheng Zhu (9):
  MIPS/Oprofile: extract PMU defines/helper functions for sharing
  MIPS: use generic atomic64 in non-64bit kernels
  MIPS: add support for software performance events
  MIPS: add support for hardware performance events
  MIPS: move mipsxx pmu helper functions to perf events
  MIPS/perf-events: replace pmu names with numeric IDs
  MIPS/perf-events: allow modules to get pmu number of counters
  MIPS/Oprofile: use perf-events framework as backend
  MIPS/Oprofile: remove old files and update Kconfig/Makefile

 arch/mips/Kconfig                       |   13 +-
 arch/mips/include/asm/atomic.h          |    4 +
 arch/mips/include/asm/perf_event.h      |   28 +
 arch/mips/include/asm/pmu.h             |  119 ++++
 arch/mips/kernel/Makefile               |    2 +
 arch/mips/kernel/perf_event.c           |  652 +++++++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c    | 1039 +++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c                |   18 +-
 arch/mips/kernel/unaligned.c            |    5 +
 arch/mips/math-emu/cp1emu.c             |    3 +
 arch/mips/mm/fault.c                    |   11 +-
 arch/mips/oprofile/Makefile             |    7 -
 arch/mips/oprofile/common.c             |  235 ++++++--
 arch/mips/oprofile/op_impl.h            |   39 --
 arch/mips/oprofile/op_model_loongson2.c |  155 -----
 arch/mips/oprofile/op_model_mipsxx.c    |  397 ------------
 arch/mips/oprofile/op_model_rm9000.c    |  138 ----
 17 files changed, 2065 insertions(+), 800 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/include/asm/pmu.h
 create mode 100644 arch/mips/kernel/perf_event.c
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c
 delete mode 100644 arch/mips/oprofile/op_impl.h
 delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
 delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c
 delete mode 100644 arch/mips/oprofile/op_model_rm9000.c
