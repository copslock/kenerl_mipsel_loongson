Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 16:15:28 +0200 (CEST)
Received: from e06smtp08.uk.ibm.com ([195.75.94.104]:39378 "EHLO
        e06smtp08.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006613AbcDUOP0qQkVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 16:15:26 +0200
Received: from localhost
        by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 15:15:19 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp08.uk.ibm.com (192.168.101.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 15:15:09 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: david@gibson.dropbear.id.au;james.hogan@imgtec.com;linux-mips@linux-mips.org;qemu-ppc@nongnu.org;mingo@redhat.com;pbonzini@redhat.com;rkrcmar@redhat.com;paulus@samba.org;kvm@vger.kernel.org;linux-kernel@vger.kernel.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id AB2A51B08067;
        Thu, 21 Apr 2016 15:15:52 +0100 (BST)
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LEF7m148431276;
        Thu, 21 Apr 2016 14:15:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1A1952043;
        Thu, 21 Apr 2016 14:13:20 +0100 (BST)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CE7F252045;
        Thu, 21 Apr 2016 14:13:20 +0100 (BST)
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 0746222046A;
        Thu, 21 Apr 2016 16:15:05 +0200 (CEST)
Subject: [PATCH v4 1/2] KVM: remove NULL return path for vcpu ids >=
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
Date:   Thu, 21 Apr 2016 16:15:05 +0200
Message-ID: <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
In-Reply-To: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042114-0033-0000-0000-000012611B53
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53169
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
