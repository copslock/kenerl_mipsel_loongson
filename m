Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:57:23 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34229
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdKYU5QxVut6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:16 +0100
Received: by mail-wm0-x243.google.com with SMTP id y82so23786538wmg.1
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zJaQtdegKG90+ublPjiiCPHII8+I/tB8qHGuKJMjffA=;
        b=PviCQ0d8oAI49kNNAUhzTrzq84sWjshrfqOC1PbnLIIc5v56DHCckDJizkXwx2fei6
         LPQoZCLS4wOyyTzhjAZrKvvs33CIEXpOefTc0TLgc0I4euXgkpNxdSo5TkAcuFVh2hQn
         3yHmKgcOoib9TCCLvMZB7ZZFVG1cXHkKTwgDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zJaQtdegKG90+ublPjiiCPHII8+I/tB8qHGuKJMjffA=;
        b=lRbNciZ0fwG5DVa/hrBZa5szO3VBAnNFwesBokrjahh73pHR5eTwXmcEMIbK8+Lda/
         lGSVW/QBT3JJND6bvgt2eYgw5Jn+HLsSeIPcIpCh5YoQycT1BkOR2KccMg2Zm9rdxL5F
         KOWb0tuqKq9r3vnYrsYBMhJCuOxOd+KvuZpH6yBbuNExcHZBZFHCYunFA/Mkn79ZU92U
         7xwFxdoz0SBFZnoGRFtzSZADKoi6DsjO6zooCSAB8RAh4/vISiRfEzAFAyOcDB8ccuUO
         o+1cZoSZEPQJ5V5kh9AP4UZzNiJHkxpgXYDGTOhmEL+mMbizhT/dww6HgfisfT1hHErW
         UD5Q==
X-Gm-Message-State: AJaThX6d+Qff47NU3xAp1BA2TWiiEFuhM5/x+Ty3vhgk4f3oTqW27RWa
        aNgFEeqLZMJcVe8fY7NkPukwXg==
X-Google-Smtp-Source: AGs4zMYgN7Xo3i2RmwFeYuDIDDsiDMqc29tvlXvTKso2L1/WvrkaczDz3oifagSgv93+WsUo0kViwg==
X-Received: by 10.28.169.198 with SMTP id s189mr12358463wme.65.1511643431388;
        Sat, 25 Nov 2017 12:57:11 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:10 -0800 (PST)
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
Subject: [PATCH 00/15] Move vcpu_load and vcpu_put calls to arch code
Date:   Sat, 25 Nov 2017 21:57:03 +0100
Message-Id: <20171125205718.7731-1-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61077
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

Thanks,
-Christoffer

Christoffer Dall (15):
  KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
  KVM: Factor out vcpu->pid adjustment for KVM_RUN
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

 arch/arm64/kvm/guest.c     |  17 +++++--
 arch/mips/kvm/mips.c       |  72 +++++++++++++++++++--------
 arch/powerpc/kvm/book3s.c  |  38 +++++++++++++-
 arch/powerpc/kvm/booke.c   |  65 +++++++++++++++++++-----
 arch/powerpc/kvm/powerpc.c |  24 ++++++---
 arch/s390/kvm/kvm-s390.c   | 119 +++++++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c         | 121 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/kvm_host.h   |   2 +
 virt/kvm/arm/arm.c         |  91 +++++++++++++++++++++++++---------
 virt/kvm/kvm_main.c        |  43 +++++++---------
 10 files changed, 463 insertions(+), 129 deletions(-)

-- 
2.14.2
