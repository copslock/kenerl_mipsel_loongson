Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 11:50:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42370 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025972AbcDAJtyKHR6a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 11:49:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u319nddu023037;
        Fri, 1 Apr 2016 11:49:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u319naCD023036;
        Fri, 1 Apr 2016 11:49:36 +0200
Message-Id: <cover.1459501014.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Fri, 1 Apr 2016 10:56:54 +0200
Subject: [PATCH v3 0/3] Add MIPS support to perf tools
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

A long time ago David Daney submitted patches to add MIPS support to
perf-tools.  Running out of out of time the the series the minor reviewer
comments were never dealt with so I now picked up the series and am posting
a version 3.

David Daney (3):
  MIPS: Add user stack and registers to perf.
  perf tools: Add support for MIPS userspace DWARF callchains.
  perf tools: Hook up MIPS unwind and dwarf-regs in the Makefile
---
 v3: Fixed issues raised by Jiri Olsa in the previous version.  The short
     review thread is archived at
     https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=cover.1428450297.git.ralf%40linux-mips.org

 arch/mips/Kconfig                            |  2 +
 arch/mips/include/uapi/asm/perf_regs.h       | 41 ++++++++++++++
 arch/mips/kernel/Makefile                    |  2 +-
 arch/mips/kernel/perf_regs.c                 | 67 ++++++++++++++++++++++
 tools/perf/arch/mips/Build                   |  2 +-
 tools/perf/arch/mips/Makefile                |  7 +++
 tools/perf/arch/mips/include/perf_regs.h     | 84 ++++++++++++++++++++++++++++
 tools/perf/arch/mips/util/Build              |  2 +
 tools/perf/arch/mips/util/dwarf-regs.c       | 37 ++++++++++++
 tools/perf/arch/mips/util/unwind-libunwind.c | 20 +++++++
 tools/perf/config/Makefile                   |  5 ++
 11 files changed, 267 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/uapi/asm/perf_regs.h
 create mode 100644 arch/mips/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/include/perf_regs.h
 create mode 100644 tools/perf/arch/mips/util/Build
 create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c

-- 
2.5.5
