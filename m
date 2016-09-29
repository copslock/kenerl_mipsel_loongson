Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2016 14:13:33 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:16209 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991344AbcI2MNY5a1Ni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Sep 2016 14:13:24 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id A8AF8FD3D77FF;
        Thu, 29 Sep 2016 13:13:15 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL03.hh.imgtec.org (10.44.0.22) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Sep 2016 13:13:18 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [GIT PULL 0/6] KVM: MIPS: Updates for v4.9
Date:   Thu, 29 Sep 2016 13:13:07 +0100
Message-ID: <1475151193-28505-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55291
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

Hi Paolo, Radim,

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.9_1

for you to fetch changes up to bf18db4e7bd99f3a65bcc43225790b16af733321:

  KVM: MIPS: Drop dubious EntryHi optimisation (2016-09-29 12:40:12 +0100)

Thanks
James

----------------------------------------------------------------
MIPS KVM updates for v4.9

- A couple of fixes in preparation for supporting MIPS EVA host kernels.
- MIPS SMP host & TLB invalidation fixes.

----------------------------------------------------------------
James Hogan (6):
      KVM: MIPS: Override HVA error values for EVA
      KVM: MIPS: Emulate MMIO via TLB miss for EVA
      KVM: MIPS: Drop other CPU ASIDs on guest MMU changes
      KVM: MIPS: Split kernel/user ASID regeneration
      KVM: MIPS: Invalidate TLB by regenerating ASIDs
      KVM: MIPS: Drop dubious EntryHi optimisation

 arch/mips/include/asm/kvm_host.h | 17 +++++++++
 arch/mips/kvm/emulate.c          | 78 ++++++++++++++++++++++++++++++++--------
 arch/mips/kvm/mips.c             | 30 ++++++++++++++++
 arch/mips/kvm/mmu.c              | 16 +++++++--
 arch/mips/kvm/trap_emul.c        | 18 ++++++++++
 5 files changed, 143 insertions(+), 16 deletions(-)

-- 
2.7.3
