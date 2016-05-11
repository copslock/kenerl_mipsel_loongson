Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 14:51:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028946AbcEKMvgnD3S2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 14:51:36 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 9BA70583D6FD8;
        Wed, 11 May 2016 13:51:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:51:30 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:51:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Robert Richter <rric@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, <oprofile-list@lists.sf.net>
Subject: [PATCH v2 0/5] MIPS: Add feature probing ready for KVM/VZ
Date:   Wed, 11 May 2016 13:50:48 +0100
Message-ID: <1462971053-25622-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

This patchset adds probing of various architectural features which will
be useful for supporting KVM with VZ (MIPS hardware assisted
virtualisation extensions).

Changes in v2:
- Patch 2 changed to handle MIPS32r3+, which can also have a WG bit to
  allow bits 31:30 to be written. The feature provided is now just the
  presence of the WG bit rather than the extension of CP0_EBase to
  64-bits (which is implied if WG is present on MIPS64).

It is based on the mips-for-linux-next~ of the day (commit
0fc44314a7d).

James Hogan (5):
  MIPS: Define & use CP0_EBase bit definitions
  MIPS: Add defs & probing of extended CP0_EBase
  MIPS: Add defs & probing of BadInstr[P] registers
  MIPS: Add defs & probing of [X]ContextConfig
  MIPS: Add perf counter feature

 arch/mips/include/asm/cpu-features.h | 20 ++++++++++++++++
 arch/mips/include/asm/cpu.h          |  5 ++++
 arch/mips/include/asm/mipsregs.h     | 22 +++++++++++++++++-
 arch/mips/kernel/cpu-probe.c         | 45 +++++++++++++++++++++++++++++++++++-
 arch/mips/kernel/perf_event_mipsxx.c |  4 +---
 arch/mips/kvm/trap_emul.c            |  3 ++-
 arch/mips/netlogic/xlp/nlm_hal.c     |  2 +-
 arch/mips/netlogic/xlr/setup.c       |  2 +-
 arch/mips/oprofile/op_model_mipsxx.c |  4 +---
 9 files changed, 96 insertions(+), 11 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jayachandran C <jchandra@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: oprofile-list@lists.sf.net
-- 
2.4.10
