Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 15:56:01 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:44386 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492122Ab0EENz5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 15:55:57 +0200
Received: by pvg7 with SMTP id 7so310699pvg.36
        for <multiple recipients>; Wed, 05 May 2010 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=U3jh5kmvVrdQTTJBSvNoPXt/HeLXy10vqdIBQA1Amlw=;
        b=kgrd6TR97GGBJj/ZBMpq4OVpCdUHwYUPzP3UeIFcyiutTxJ8bXbrPBAkOBzYNPdjfp
         ogbbiK9XOBAYgBje1RvPjsu8cLnCNoh7jLl5MtapiMBDm5vM5YYyNNn5CetchhYhG0sA
         ljf+23hasHr/Zm5/VxewFzQ2H7cI+wvuj0rLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bgRDphPLANsdHAsvMqomQJroasvgsgvVkhrEqtz+mgMB1S1NMh9LxIHpzuNCR1AeU/
         37L9/2ynCxebiv+T/N7y8q8xiq5Z0youDsFRALwIw4SWIfbxFhKG5UOeZTnT7mbzKDSn
         33BTRIb5J86QY+auu6Rk+hjA3yPf0KT67ovrE=
Received: by 10.142.119.20 with SMTP id r20mr4827063wfc.15.1273067749728;
        Wed, 05 May 2010 06:55:49 -0700 (PDT)
Received: from localhost.localdomain ([114.84.73.209])
        by mx.google.com with ESMTPS id 23sm6598217pzk.2.2010.05.05.06.55.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 06:55:49 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v3 0/4] MIPS performance event support v3
Date:   Wed,  5 May 2010 21:55:30 +0800
Message-Id: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch series implemented the low-level logic for the Linux
performance counter subsystem on MIPS, which enables the collection of
all sorts of HW/SW performance events based on per-CPU or per-task. For
more information, please refer to tools/perf/Documentation/perf.txt.

Development tests were carried out on the Malta-R board. 24K/34K/74K/1004K
cores and SMVP/UP kernels have been basically tested.

CHANGES:
-----------------------------
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

Deng-Cheng Zhu (4):
  MIPS/Oprofile: extract PMU defines/helper functions for sharing
  MIPS: use generic atomic64 in non-64bit kernels
  MIPS: add support for software performance events
  MIPS: add support for hardware performance events

 arch/mips/Kconfig                       |   11 +
 arch/mips/include/asm/atomic.h          |    4 +
 arch/mips/include/asm/perf_event.h      |   28 +
 arch/mips/include/asm/pmu.h             |  244 +++++++++
 arch/mips/kernel/Makefile               |    2 +
 arch/mips/kernel/perf_event.c           |  604 +++++++++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c    |  869 +++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c                |   18 +-
 arch/mips/kernel/unaligned.c            |    5 +
 arch/mips/math-emu/cp1emu.c             |    3 +
 arch/mips/mm/fault.c                    |   11 +-
 arch/mips/oprofile/op_model_loongson2.c |   23 +-
 arch/mips/oprofile/op_model_mipsxx.c    |  164 +------
 arch/mips/oprofile/op_model_rm9000.c    |   16 +-
 14 files changed, 1797 insertions(+), 205 deletions(-)
 create mode 100644 arch/mips/include/asm/perf_event.h
 create mode 100644 arch/mips/include/asm/pmu.h
 create mode 100644 arch/mips/kernel/perf_event.c
 create mode 100644 arch/mips/kernel/perf_event_mipsxx.c
