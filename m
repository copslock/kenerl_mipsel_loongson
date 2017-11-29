Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:41:34 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:42400
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990591AbdK2QlYg3AWa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:24 +0100
Received: by mail-wm0-x241.google.com with SMTP id l141so7613060wmg.1
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E4qWHSBw5zi93TV6hbPcQPs7J39Ga5nBDckovdyREQQ=;
        b=dXnO0XvOK1yHP/zoK8+/by3CkYVUngza4+qEph7Vp0DUZF5IsWbnUS2v/3LZA8rVzC
         nDLOs5vUqJGCutn/Ukpf3TXaS2Q7y0o3VrmUkuX/aZ0UK3krnYtuW1/djKPuN9sM/ERv
         MQmFJXwWOxXwk4lCDnes3IMyGPA+8jwqzQMuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E4qWHSBw5zi93TV6hbPcQPs7J39Ga5nBDckovdyREQQ=;
        b=WSeFAzE2VJ817UJMkrbpG5nXVgRcfufLt5GLshDMWOdWInnwz480F/o0Z4csGQiUYa
         Vp3TWIqNzgxfSevdc5+JiM2l6FNtON/zI843vT6FIeWHLtEDolg4ai9nXLvbyGvE2Xlx
         XZ/sbFsWB0/C7F8sV4Z0E563p4aBQSg1rT4jmQ7/45ZTVAKdOxzrYic4iOZlV2v9DtnU
         vqR7QK1V6kx+qcMzq9+hJPJJ3hisXGuAXFAc15dpVOcRhQjyn2q5ePZgF2uHg3W/lL7f
         smWHSPpooJ5P4+3Q3nfXpXlUPcSrLTu3U6R5dbVyXwXdMcQnR014kh6+dZbCjY+Rik1f
         x7pA==
X-Gm-Message-State: AJaThX4O+2H4vf0c9iDLaVId9zy2FfMexirDKVWaGBFCSJ1NHR7U4DlF
        Mx5klPRdRxMMYKYXBVVEeK3NxQ==
X-Google-Smtp-Source: AGs4zMbeA1q771wCTAFJlxa0p2plb06mdhLLfPP9mKWfkrMtZa8qAbTf0/kiOt6zHj46+umbOkUxVQ==
X-Received: by 10.28.1.14 with SMTP id 14mr3093619wmb.51.1511973679034;
        Wed, 29 Nov 2017 08:41:19 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:18 -0800 (PST)
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: [PATCH v2 00/16] Move vcpu_load and vcpu_put calls to arch code
Date:   Wed, 29 Nov 2017 17:41:00 +0100
Message-Id: <20171129164116.16167-1-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christoffer.dall@linaro.org
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

Some architectures may decide to do different things during
kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
arm64 is about to do significant work in vcpu load/put when running a
vcpu, but it's problematic to do this for any other vcpu ioctl than
KVM_RUN.

Further, while it may be possible to call kvm_arch_vcpu_load() for a
number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
to reason about, especially after my optimization series, because a lot
of things can now happen, where we have to consider if we're really in
the process of running a vcpu or not.

This series will first move the vcpu_load() and vcpu_put() calls in the
arch generic dispatch function into each case of the switch statement
and then, one-by-one, pushed the calls down into the architecture
specific code making the changes for each ioctl as required.

Patches also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put-v2

Changes since v1:
 - Fix PPC and S390 bugs from v1
 - Take the mutex in the main disaptcher function and make vcpu_load a
   void, which simplifies the patches overall.
 - Add a patch that moves vcpu_load for arm/arm64 after the first-run
   init function.

Thanks,
-Christoffer

Christoffer Dall (16):
  KVM: Take vcpu->mutex outside vcpu_load
  KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
  KVM: Move vcpu_load to arch-specific
    kvm_arch_vcpu_ioctl_set_guest_debug
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
  KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
  KVM: arm/arm64: Move vcpu_load call after kvm_vcpu_first_run_init

 arch/arm64/kvm/guest.c        |  12 +++--
 arch/mips/kvm/mips.c          |  58 +++++++++++++++--------
 arch/powerpc/kvm/book3s.c     |  24 +++++++++-
 arch/powerpc/kvm/booke.c      |  51 +++++++++++++++-----
 arch/powerpc/kvm/powerpc.c    |  19 +++++---
 arch/s390/kvm/kvm-s390.c      |  90 +++++++++++++++++++++++++++--------
 arch/x86/kvm/vmx.c            |   4 +-
 arch/x86/kvm/x86.c            | 107 ++++++++++++++++++++++++++++++------------
 include/linux/kvm_host.h      |   2 +-
 virt/kvm/arm/arch_timer.c     |   4 --
 virt/kvm/arm/arm.c            |  68 ++++++++++++++++++---------
 virt/kvm/arm/vgic/vgic-init.c |  11 -----
 virt/kvm/kvm_main.c           |  17 ++-----
 13 files changed, 323 insertions(+), 144 deletions(-)

-- 
2.7.4
