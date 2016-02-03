Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:27:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33263 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007574AbcBCD1BgZdBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:27:01 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 735F3910C427D;
        Wed,  3 Feb 2016 03:26:55 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:26:55 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:26:55 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joshua Kinard <kumba@gentoo.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ingo Molnar <mingo@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Petri Gynther" <pgynther@google.com>
Subject: [PATCH 0/3] Imagination Technologies MIPS P6600 CPU Support
Date:   Wed, 3 Feb 2016 03:26:36 +0000
Message-ID: <1454469999-17818-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51644
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

This series introduces support for probing the Imagination Technologies
P6600 CPU, a high end multi-core out-of-order MIPS64r6 CPU with features
such as SIMD & hardware supported virtualization.

We already have support in place for the required CM/CPS features so
this simply adds the PRID, probes for it & adds various switch cases.

Paul Burton (3):
  MIPS: Add P6600 PRID & cpu_type_enum values
  MIPS: Add P6600 cases to CPU switch statements
  MIPS: Probe the P6600 core

 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/include/asm/cpu.h          | 3 ++-
 arch/mips/kernel/cpu-probe.c         | 5 +++++
 arch/mips/kernel/perf_event_mipsxx.c | 6 ++++++
 arch/mips/kernel/spram.c             | 1 +
 arch/mips/kernel/traps.c             | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/mm/sc-mips.c               | 1 +
 8 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.7.0
