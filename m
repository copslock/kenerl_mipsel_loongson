Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:04:23 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:51716 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492352Ab0E0NET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:04:19 +0200
Received: by pzk3 with SMTP id 3so3858148pzk.26
        for <multiple recipients>; Thu, 27 May 2010 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0u0BbGyJsncnIjkRXgITKF9CYjrjxu8TMGY1djLQkvI=;
        b=CzAYL7ZPGfj/4jLuVKJmx4kmDbyB8F3faCsoEdZdrKtjYoE2mespTbCosZX9SbCRUV
         5Cl6AKvGffjkQkVCuc3aTBNvUrBBRrS9EXXw1nZDKvZMIburF8cweM0BeElTdmepDdu9
         1FhM8TUOjfIAFqPqvyPSitX59DbnYOP7j6S5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=p/HcIr5LEHWIkBpZ1f3aNVxX2NKQ4NEPr3FBC0KSvRjrlJJ1fEVgjaM4F0aer1klq7
         NXBjFPAp1of1gIynxp5qamTFbLBFdNAo+WoUECZnl1DLDpTmnk3ZZN2tuBatgJTkhD8h
         n1YOUzdotsthi58j2e428GKJ6xPMMoVcjPUfU=
Received: by 10.142.2.28 with SMTP id 28mr6811256wfb.207.1274965449983;
        Thu, 27 May 2010 06:04:09 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.04.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:04:09 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 00/12] MIPS performance event support v5
Date:   Thu, 27 May 2010 21:03:28 +0800
Message-Id: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

The patches 1~7 (can be applied/built/tested independently) of this
package implement the low-level logic for the Linux performance counter
subsystem (Perf-events) on MIPS, which enables the collection of all sorts
of HW/SW performance events based on per-CPU or per-task. For more
information, please refer to tools/perf/Documentation/perf.txt.

And No. 8~12 make Oprofile use Perf-events framework as backend. This
effort makes the bug-fixes shared by different pmu users/clients (for now,
Oprofile & Perf-events), and make them coexist in the system without
locking issues, and make their results comparable.

The whole patchset was tested on the Malta-R board. 24K/34K/74K/1004K
cores and SMVP/UP kernels have been basically tested. Welcome any more
tests against these cores for Perf-events and all mipsxx CPUs for
Oprofile.

To test the functionality of Perf-event, you may want to compile the tool
"perf" for your MIPS platform. You can refer to the following URL:
http://www.linux-mips.org/archives/linux-mips/2010-04/msg00158.html

Please note: Before that patch is accepted, you can choose a "specific"
rmb() which is suitable for your platform -- an example is provided in
the description of that patch.

You also need to customize the CFLAGS and LDFLAGS in tools/perf/Makefile
for your libs, includes, etc.

In case you encounter the boot failure in SMVP kernel on multi-threading
CPUs, you may take a look at:
http://www.linux-mips.org/git?p=linux-mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020

Note:
1) To support mipsxx CPUs other than 24K/34K/74K/1004K, the corresponding
general event map, cache event map and raw event macros need to be added.
Please refer to init_hw_perf_events() for more info. Please note that,
even before this is done, Oprofile with the new framework can still work
on *ALL* mipsxx CPUs. For those CPUs not yet having "precise" raw event
implementation (refer to patch #7), the unchecked raw events are used.
2) To support other CPUs which have different PMU than mipsxx, such as
RM9000 and LOONGSON2, additional files perf_event_$cpu.c need to be
created.

So, the patches 1~7 can be reviewed and applied (if OK, hope so) without
affecting the existing Oprofile and other parts --- only a new kernel
facility is brought in :-) And the patches 8~12 can be applied after
perf_event_rm9000.c and perf_event_loongson2.c are added in, because 8~12
removed all the old Oprofile interfaces and replaced with new ones, which
will call into the rm9000/loongson2 Perf-events backend on corresponding
CPUs.

CHANGES:
-----------------------------
v5 - v4:
- splitting up Perf-events patches (v4 patches 1~4 are now splitted into
v5 patches 1~7) for easier review.
- adding more info into the description of patches (especially how to test
this patchset).
- simplifying the 2 small functions mipspmu_get_pmu_id() and
mipspmu_get_max_events().
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

Deng-Cheng Zhu (12):
  MIPS/Oprofile: extract PMU defines/helper functions for sharing
  MIPS: use generic atomic64 in non-64bit kernels
  MIPS: add support for software performance events
  MIPS: add support for hardware performance events (skeleton)
  MIPS/Perf-events: add callchain support
  MIPS: add support for hardware performance events (mipsxx)
  MIPS/Perf-events: add raw event support for mipsxx 24K/34K/74K/1004K
  MIPS: move mipsxx pmu helper functions to Perf-events
  MIPS/Perf-events: replace pmu names with numeric IDs
  MIPS/Perf-events: allow modules to get pmu number of counters
  MIPS/Oprofile: use Perf-events framework as backend
  MIPS/Oprofile: remove old files and update Kconfig/Makefile

 arch/mips/Kconfig                       |   13 +-
 arch/mips/include/asm/atomic.h          |    4 +
 arch/mips/include/asm/perf_event.h      |   28 +
 arch/mips/include/asm/pmu.h             |  119 ++++
 arch/mips/kernel/Makefile               |    2 +
 arch/mips/kernel/perf_event.c           |  647 +++++++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c    | 1039 +++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c                |   18 +-
 arch/mips/kernel/unaligned.c            |    5 +
 arch/mips/math-emu/cp1emu.c             |    3 +
 arch/mips/mm/fault.c                    |   11 +-
 arch/mips/oprofile/Makefile             |    7 -
 arch/mips/oprofile/common.c             |  237 ++++++--
 arch/mips/oprofile/op_impl.h            |   39 --
 arch/mips/oprofile/op_model_loongson2.c |  155 -----
 arch/mips/oprofile/op_model_mipsxx.c    |  397 ------------
 arch/mips/oprofile/op_model_rm9000.c    |  138 ----
 17 files changed, 2061 insertions(+), 801 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/include/asm/pmu.h
 create mode 100644 arch/mips/kernel/perf_event.c
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c
 delete mode 100644 arch/mips/oprofile/op_impl.h
 delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
 delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c
 delete mode 100644 arch/mips/oprofile/op_model_rm9000.c
