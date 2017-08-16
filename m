Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2017 21:41:18 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:35996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994842AbdHPTlDMJlRU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Aug 2017 21:41:03 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7AECC00DB96;
        Wed, 16 Aug 2017 19:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com B7AECC00DB96
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 480C968D5E;
        Wed, 16 Aug 2017 19:40:49 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 16 Aug 2017 21:40:48 +0200
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
Subject: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date:   Wed, 16 Aug 2017 21:40:35 +0200
Message-Id: <20170816194037.9460-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 16 Aug 2017 19:40:56 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59599
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

The goal is to increase KVM_MAX_VCPUS without worrying about memory
impact of many small guests.

This is a second out of three major "dynamic" options:
 1) size vcpu array at VM creation time
 2) resize vcpu array when new VCPUs are created
 3) use a lockless list/tree for VCPUs

The disadvantage of (1) is its requirement on userspace changes and
limited flexibility because userspace must provide the maximal count on
start.  The main advantage is that kvm->vcpus will work like it does
now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
allow dynamic kvm->vcpus array",
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html

The main problem of (2), this series, is that we cannot extend the array
in place and therefore require some kind of protection when moving it.
RCU seems best, but it makes the code slower and harder to deal with.
The main advantage is that we do not need userspace changes.

The third option wasn't explored yet.  It would solve the ugly
kvm_for_each_vcpu() of (2), but kvm_get_vcpu() would become linear.
(We could mitigate it by having list of vcpu arrays and A lockless
 sequentially growing "tree" would be logarithmic and not that much more
 complicated to implement.)

Which option do you think is the best?

Thanks.

Radim Krčmář (2):
  KVM: remove unused __KVM_HAVE_ARCH_VM_ALLOC
  KVM: RCU protected dynamic vcpus array

 arch/mips/kvm/mips.c       |  8 +++--
 arch/powerpc/kvm/powerpc.c |  6 ++--
 arch/s390/kvm/kvm-s390.c   | 27 ++++++++++++-----
 arch/x86/kvm/hyperv.c      |  3 +-
 arch/x86/kvm/vmx.c         |  3 +-
 arch/x86/kvm/x86.c         |  5 ++--
 include/linux/kvm_host.h   | 73 +++++++++++++++++++++++++++++-----------------
 virt/kvm/arm/arm.c         | 10 +++----
 virt/kvm/kvm_main.c        | 72 +++++++++++++++++++++++++++++++++++++--------
 9 files changed, 144 insertions(+), 63 deletions(-)

-- 
2.13.3
