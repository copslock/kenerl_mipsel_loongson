Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 22:38:52 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:59418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995050AbdHUUiMiZOo7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 22:38:12 +0200
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63EB3C047B8C;
        Mon, 21 Aug 2017 20:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 63EB3C047B8C
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=rkrcmar@redhat.com
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1C8B5CC21;
        Mon, 21 Aug 2017 20:37:58 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 21 Aug 2017 22:37:58 +0200
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
Subject: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
Date:   Mon, 21 Aug 2017 22:35:22 +0200
Message-Id: <20170821203530.9266-2-rkrcmar@redhat.com>
In-Reply-To: <20170821203530.9266-1-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 21 Aug 2017 20:38:04 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59742
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

We can add a variable instead of scanning all online VCPUs to know how
many are started.  We can't trivially tell which VCPU is the last one,
though.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 39 +++++++++++++++------------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a409d5991934..be0d0bdf585b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -735,6 +735,7 @@ struct kvm_arch{
 	struct mutex ipte_mutex;
 	struct ratelimit_state sthyi_limit;
 	spinlock_t start_stop_lock;
+	unsigned started_vcpus;
 	struct sie_page2 *sie_page2;
 	struct kvm_s390_cpu_model model;
 	struct kvm_s390_crypto crypto;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9f23a9e81a91..1534778a3c66 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3414,25 +3414,17 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
-	int i, online_vcpus, started_vcpus = 0;
-
 	if (!is_vcpu_stopped(vcpu))
 		return;
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
 	spin_lock(&vcpu->kvm->arch.start_stop_lock);
-	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
-	for (i = 0; i < online_vcpus; i++) {
-		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
-			started_vcpus++;
-	}
-
-	if (started_vcpus == 0) {
+	if (vcpu->kvm->arch.started_vcpus == 0) {
 		/* we're the only active VCPU -> speed it up */
 		__enable_ibs_on_vcpu(vcpu);
-	} else if (started_vcpus == 1) {
+	} else if (vcpu->kvm->arch.started_vcpus == 1) {
 		/*
 		 * As we are starting a second VCPU, we have to disable
 		 * the IBS facility on all VCPUs to remove potentially
@@ -3441,6 +3433,8 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 		__disable_ibs_on_all_vcpus(vcpu->kvm);
 	}
 
+	vcpu->kvm->arch.started_vcpus++;
+
 	atomic_andnot(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 	/*
 	 * Another VCPU might have used IBS while we were offline.
@@ -3453,16 +3447,12 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 {
-	int i, online_vcpus, started_vcpus = 0;
-	struct kvm_vcpu *started_vcpu = NULL;
-
 	if (is_vcpu_stopped(vcpu))
 		return;
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
 	spin_lock(&vcpu->kvm->arch.start_stop_lock);
-	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
 	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
 	kvm_s390_clear_stop_irq(vcpu);
@@ -3470,19 +3460,20 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 	__disable_ibs_on_vcpu(vcpu);
 
-	for (i = 0; i < online_vcpus; i++) {
-		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i])) {
-			started_vcpus++;
-			started_vcpu = vcpu->kvm->vcpus[i];
-		}
-	}
+	vcpu->kvm->arch.started_vcpus--;
+
+	if (vcpu->kvm->arch.started_vcpus == 1) {
+		struct kvm_vcpu *started_vcpu;
 
-	if (started_vcpus == 1) {
 		/*
-		 * As we only have one VCPU left, we want to enable the
-		 * IBS facility for that VCPU to speed it up.
+		 * As we only have one VCPU left, we want to enable the IBS
+		 * facility for that VCPU to speed it up.
 		 */
-		__enable_ibs_on_vcpu(started_vcpu);
+		kvm_for_each_vcpu(i, started_vcpu, vcpu->kvm)
+			if (!is_vcpu_stopped(started_vcpu)) {
+				__enable_ibs_on_vcpu(started_vcpu);
+				break;
+			}
 	}
 
 	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
-- 
2.13.3
