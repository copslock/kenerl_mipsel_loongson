Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 18:12:08 +0200 (CEST)
Received: from e06smtp05.uk.ibm.com ([195.75.94.101]:54097 "EHLO
        e06smtp05.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026771AbcEIQMH0Bfr- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 18:12:07 +0200
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Mon, 9 May 2016 17:12:01 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 9 May 2016 17:12:00 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 93FD62190046
        for <linux-mips@linux-mips.org>; Mon,  9 May 2016 17:11:35 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u49GBxeb63635490
        for <linux-mips@linux-mips.org>; Mon, 9 May 2016 16:11:59 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u49GBwLX017590
        for <linux-mips@linux-mips.org>; Mon, 9 May 2016 10:11:59 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u49GBw7M017583;
        Mon, 9 May 2016 10:11:58 -0600
Received: from bahia.huguette.org (icon-9-164-183-85.megacenter.de.ibm.com [9.164.183.85])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 96EB0220219;
        Mon,  9 May 2016 18:11:56 +0200 (CEST)
Subject: [PATCH v6 1/2] KVM: remove NULL return path for vcpu ids >=
 KVM_MAX_VCPUS
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Mon, 09 May 2016 18:11:54 +0200
Message-ID: <146281031018.17210.8148336192033754193.stgit@bahia.huguette.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16050916-0021-0000-0000-00001AF90BF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

Commit c896939f7cff ("KVM: use heuristic for fast VCPU lookup by id") added
a return path that prevents vcpu ids to exceed KVM_MAX_VCPUS. This is a
problem for powerpc where vcpu ids can grow up to 8*KVM_MAX_VCPUS.

This patch simply reverses the logic so that we only try fast path if the
vcpu id can be tried as an index in kvm->vcpus[]. The slow path is not
affected by the change.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 include/linux/kvm_host.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5276fe0916fc..23bfe1bd159c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -447,12 +447,13 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 
 static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 {
-	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu = NULL;
 	int i;
 
-	if (id < 0 || id >= KVM_MAX_VCPUS)
+	if (id < 0)
 		return NULL;
-	vcpu = kvm_get_vcpu(kvm, id);
+	if (id < KVM_MAX_VCPUS)
+		vcpu = kvm_get_vcpu(kvm, id);
 	if (vcpu && vcpu->vcpu_id == id)
 		return vcpu;
 	kvm_for_each_vcpu(i, vcpu, kvm)
