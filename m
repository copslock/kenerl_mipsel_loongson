Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 11:47:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18394 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991061AbdBFKrMU-x5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 11:47:12 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id AF99F3E4D7DDC;
        Mon,  6 Feb 2017 10:47:02 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 6 Feb 2017 10:47:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Corbet <corbet@lwn.net>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 0/4] KVM: MIPS: Hypercalls
Date:   Mon, 6 Feb 2017 10:46:45 +0000
Message-ID: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56651
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

This series implements some basic hypercalls for MIPS KVM, as used by
the MIPS paravirtual platform support in Linux and provided by Cavium's
VZ KVM implementation.

- Patch 1 hooks up trap & emulate to some minimal hypercall
  infrastructure without any hypercalls implemented yet. VZ support when
  it comes will also hook into the same infrastructure.

- Patches 2-3 implement GET_CLOCK_FREQ and EXIT_VM hypercalls.

- Patch 4 implements the console output hypercall by using
  KVM_EXIT_HYPERCALL (i.e. delegating the hypercall to userland). Its
  unclear if there is a more preferable approach to this, so comments
  particularly appreciated here.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org

James Hogan (4):
  KVM: MIPS: Implement HYPCALL emulation
  KVM: MIPS: Implement GET_CLOCK_FREQ hypercall
  KVM: MIPS: Implement EXIT_VM hypercall
  KVM: MIPS: Implement console output hypercall

 Documentation/virtual/kvm/hypercalls.txt | 27 +++++++-
 arch/mips/include/asm/kvm_host.h         | 11 +++-
 arch/mips/include/uapi/asm/inst.h        |  2 +-
 arch/mips/kvm/Makefile                   |  1 +-
 arch/mips/kvm/emulate.c                  |  3 +-
 arch/mips/kvm/hypcall.c                  | 94 +++++++++++++++++++++++++-
 arch/mips/kvm/mips.c                     |  3 +-
 arch/mips/kvm/trap_emul.c                |  4 +-
 8 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kvm/hypcall.c

-- 
git-series 0.8.10
