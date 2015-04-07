Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 02:06:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55087 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27024611AbbDHAGIyDs4N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Apr 2015 02:06:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t38067fw014786;
        Wed, 8 Apr 2015 02:06:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t38065Mb014785;
        Wed, 8 Apr 2015 02:06:05 +0200
Message-Id: <cover.1428450297.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
Date:   Wed, 08 Apr 2015 01:58:45 +0200
Subject: [PATCH 0/2] perf tools: Add MIPS userspace DWARF callchains.
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46830
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

This is a refresh of a David Daney's patch set to implement MIPS support
for perf.  It has been posted before but not received any comments or
(N)Acks.

This series depends on

  http://patchwork.linux-mips.org/patch/5246/

which currently is pending for 4.1 in the MIPS tree so I'd like to upstream
these two patches through the MIPS tree as well.

David's original patches are archived at:

  http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1368817238-11548-1-git-send-email-ddaney.cavm%40gmail.com
  http://patchwork.linux-mips.org/patch/5249/
  http://patchwork.linux-mips.org/patch/5250/

Cheers,

  Ralf

David Daney (2):
  perf tools: Add support for MIPS userspace DWARF callchains.
  perf tools: Hook up MIPS unwind and dwarf-regs in the Makefile

 tools/perf/Makefile                      |  3 ++
 tools/perf/arch/mips/Makefile            |  7 +++
 tools/perf/arch/mips/include/perf_regs.h | 84 ++++++++++++++++++++++++++++++++
 tools/perf/arch/mips/util/dwarf-regs.c   | 37 ++++++++++++++
 tools/perf/arch/mips/util/unwind.c       | 20 ++++++++
 tools/perf/config/Makefile               | 10 ++++
 6 files changed, 161 insertions(+)
 create mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/include/perf_regs.h
 create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/mips/util/unwind.c

-- 
1.9.3
