Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 14:13:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15259 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991697AbcIHMNog8urw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 14:13:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 43B124C80CE7F;
        Thu,  8 Sep 2016 13:13:25 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 8 Sep 2016 13:13:28 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/2] MIPS: KVM: Partial EVA support
Date:   Thu, 8 Sep 2016 13:13:01 +0100
Message-ID: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55069
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

These patches fix a couple of problems when using MIPS KVM on a host
kernel with Enhanced Virtual Addressing (EVA) enabled.

Patch 1 fixes the HVA error codes like s390 does, due to PAGE_OFFSET
potentially being as low as 0.

Patch 2 allows MMIO to be emulated from TLB refill exceptions as well as
address error exceptions (since EVA configurations may make KSeg1
addresses TLB mapped to user mode).

It isn't complete as there are still a couple of cases where KVM tries
to directly access guest memory using normal loads and stores (which
doesn't work with EVA's overlapping usermode & kernel mode address
spaces). That really needs fixing properly anyway to handle the
potential for TLB invalidations (and the resulting refills & page
faults).

For KVM to work on EVA hosts also requires some MIPS architecture
changes, as found in my recent "MIPS: General EVA fixes & cleanups"
patchset.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org

James Hogan (2):
  MIPS: KVM: Override HVA error values for EVA
  MIPS: KVM: Emulate MMIO via TLB miss for EVA

 arch/mips/include/asm/kvm_host.h | 14 ++++++++++++++
 arch/mips/kvm/trap_emul.c        | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

-- 
git-series 0.8.10
