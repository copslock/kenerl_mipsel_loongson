Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:36:04 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:41930
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbdLDUfxyzNt6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:35:53 +0100
Received: by mail-wm0-x242.google.com with SMTP id g75so8237954wme.0
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fAQTHTh6qoiNGRLp49PyJPT7ETd84UHys6MjFJs7v0I=;
        b=BnTne7m3kFiKpVj0QZIvPMXIyZdnl/2uZi0qlkJ/BHcEMFnw8JIHev/cud61lVHSAn
         5aXjg1+GCZKXPho/0HW/SPy7ebcgknyt7rduXjWc59bngPEfMbo4vDESZdlQTmFpuR7x
         ekriP5bAcKXqsJOft6bDcLcef64MQdxEnSHZZZc2OpbFI8epvIkz1fljEGo2ns/DryaM
         VKUpTmGkU3ZVEUoE0GCGBIzZuAOKZnvZSs0Caa3OgPGOI/H3OEimjipbPlvPxZGm/pJf
         09jMWj/luXhXzmJEWJxr7/sNPG8rf6x6jj/g1PpxyRrzbfsLVy+XAFin6kxvZSBJfP9v
         xQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fAQTHTh6qoiNGRLp49PyJPT7ETd84UHys6MjFJs7v0I=;
        b=h5psIkP6Ki/jzyjoM0mSTdazcW0LCa3B4uOZm6Sxdmef6MhkNQY8MnO+CvvYPbDaKz
         13uE05AZgMQF+m9KjnarWI/NEnFQHs+G3N2HjIvO45SDDo2LVapMcohV+T5N2LGoWioT
         erswlNtD+4+AeHK5DX2rlNn7hKWYO728UKfnDyMk+JSaoiOCgtcePqEi06xppGpFjAZz
         MihufOAA2e/vS67U2fPEpwMINKenCs3ZH3iZJ/5JsehMObWq/WAPADfyeWvQXp1CjftW
         LorO25bW0lnLQrgWyvYIcBKtIj1C5XpVtGXPGxZqD4xuwoFiPxoVXR6ynh4AKpWxdl0t
         Pn3g==
X-Gm-Message-State: AJaThX5JPMT+WEkt0h8+591MR+98dpNs9J7glqLsivNN3jiO7sia4lsk
        cd2oVe/6HfY2EsKQHLNz5VIhKg==
X-Google-Smtp-Source: AGs4zMYnSiGpwGaWnzrTisJ47whHsMAD038xCbxodVLnrujCrRWXz1Jh0R9nfcNQRYdHLhOXQXaRvQ==
X-Received: by 10.80.194.145 with SMTP id o17mr31973704edf.59.1512419748418;
        Mon, 04 Dec 2017 12:35:48 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:35:46 -0800 (PST)
From:   Christoffer Dall <cdall@kernel.org>
To:     kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: [PATCH v3 00/16] Move vcpu_load and vcpu_put calls to arch code
Date:   Mon,  4 Dec 2017 21:35:22 +0100
Message-Id: <20171204203538.8370-1-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cdall@kernel.org
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

From: Christoffer Dall <christoffer.dall@linaro.org>

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

Based on v4.15-rc1

Patches also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put-v3

Changes since v2:
 - Clarified commit message on patch 1
 - Initialized ret to -EINVAL at declaration on patch 9
 - Added David Hildenbrand's reviewed-by tag

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
 arch/x86/kvm/x86.c            | 106 ++++++++++++++++++++++++++++++------------
 include/linux/kvm_host.h      |   2 +-
 virt/kvm/arm/arch_timer.c     |   4 --
 virt/kvm/arm/arm.c            |  68 ++++++++++++++++++---------
 virt/kvm/arm/vgic/vgic-init.c |  11 -----
 virt/kvm/kvm_main.c           |  17 ++-----
 13 files changed, 322 insertions(+), 144 deletions(-)

-- 
2.14.2
