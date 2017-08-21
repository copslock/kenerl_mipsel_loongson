Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 22:38:13 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:59282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995048AbdHUUiEzvHs7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 22:38:04 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03AFCC047B8A;
        Mon, 21 Aug 2017 20:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 03AFCC047B8A
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB0B617C2A;
        Mon, 21 Aug 2017 20:37:52 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 21 Aug 2017 22:37:51 +0200
From:   =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: [PATCH RFC v3 0/9] KVM: allow dynamic kvm->vcpus array
Date:   Mon, 21 Aug 2017 22:35:21 +0200
Message-Id: <20170821203530.9266-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 21 Aug 2017 20:37:58 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

The only common part with v2 is [v3 5/9].

The crucial part of this series is adding a separate mechanism for
kvm_for_each_vcpu() [v3 8/9] and with that change, I think that the
dynamic array [v3 9/9] would be nicer if protected by RCU, like in v2:
The protection can be nicely hidden in kvm_get_vcpu().  I just had the
split done before implementing [v3 8/9] and presented it for
consideration.

Smoke tested on x86 only.


Radim Krčmář (9):
  KVM: s390: optimize detection of started vcpus
  KVM: arm/arm64: fix vcpu self-detection in vgic_v3_dispatch_sgi()
  KVM: remember position in kvm->vcpus array
  KVM: arm/arm64: use locking helpers in kvm_vgic_create()
  KVM: remove unused __KVM_HAVE_ARCH_VM_ALLOC
  KVM: rework kvm_vcpu_on_spin loop
  KVM: add kvm_free_vcpus and kvm_arch_free_vcpus
  KVM: implement kvm_for_each_vcpu with a list
  KVM: split kvm->vcpus into chunks

 arch/mips/kvm/mips.c                |  19 ++----
 arch/powerpc/kvm/book3s_32_mmu.c    |   3 +-
 arch/powerpc/kvm/book3s_64_mmu.c    |   3 +-
 arch/powerpc/kvm/book3s_hv.c        |   7 +-
 arch/powerpc/kvm/book3s_pr.c        |   5 +-
 arch/powerpc/kvm/book3s_xics.c      |   2 +-
 arch/powerpc/kvm/book3s_xics.h      |   3 +-
 arch/powerpc/kvm/book3s_xive.c      |  18 +++---
 arch/powerpc/kvm/book3s_xive.h      |   3 +-
 arch/powerpc/kvm/e500_emulate.c     |   3 +-
 arch/powerpc/kvm/powerpc.c          |  16 ++---
 arch/s390/include/asm/kvm_host.h    |   1 +
 arch/s390/kvm/interrupt.c           |   3 +-
 arch/s390/kvm/kvm-s390.c            |  77 ++++++++--------------
 arch/s390/kvm/kvm-s390.h            |   6 +-
 arch/s390/kvm/sigp.c                |   3 +-
 arch/x86/kvm/hyperv.c               |   3 +-
 arch/x86/kvm/i8254.c                |   3 +-
 arch/x86/kvm/i8259.c                |   7 +-
 arch/x86/kvm/ioapic.c               |   3 +-
 arch/x86/kvm/irq_comm.c             |  10 +--
 arch/x86/kvm/lapic.c                |   5 +-
 arch/x86/kvm/svm.c                  |   3 +-
 arch/x86/kvm/vmx.c                  |   5 +-
 arch/x86/kvm/x86.c                  |  34 ++++------
 include/linux/kvm_host.h            |  81 ++++++++++++-----------
 virt/kvm/arm/arch_timer.c           |  10 ++-
 virt/kvm/arm/arm.c                  |  25 ++++----
 virt/kvm/arm/pmu.c                  |   3 +-
 virt/kvm/arm/psci.c                 |   7 +-
 virt/kvm/arm/vgic/vgic-init.c       |  31 ++++-----
 virt/kvm/arm/vgic/vgic-kvm-device.c |  30 +++++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c    |   5 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c    |  22 ++++---
 virt/kvm/arm/vgic/vgic.c            |   3 +-
 virt/kvm/kvm_main.c                 | 124 +++++++++++++++++++++++-------------
 36 files changed, 278 insertions(+), 308 deletions(-)

-- 
2.13.3
