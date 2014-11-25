Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 13:41:30 +0100 (CET)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:55014 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013759AbaKYMivK383K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 13:38:51 +0100
Received: from /spool/local
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Nov 2014 12:38:45 -0000
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 25 Nov 2014 12:38:42 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 51ED017D8056
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:57 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPCcgMi7078220
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:42 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAPCcftS026129
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 05:38:41 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAPCce1U026117;
        Tue, 25 Nov 2014 05:38:41 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id D7E141224439; Tue, 25 Nov 2014 13:38:40 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2 10/10] KVM: s390: change ipte lock from barrier to READ_ONCE
Date:   Tue, 25 Nov 2014 13:38:37 +0100
Message-Id: <1416919117-50652-11-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112512-0021-0000-0000-000001E7A929
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

Now that we have the READ_ONCE solution, we can change the ipte lock
from a barrier solution to READ_ONCE. The barrier and the explanation
of the bug was introduced in commit 1365039d0cb3 ("KVM: s390: Fix
ipte locking")

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6dc0ad9..8f195fa 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -229,12 +229,10 @@ static void ipte_lock_simple(struct kvm_vcpu *vcpu)
 		goto out;
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		while (old.k) {
 			cond_resched();
-			old = *ic;
-			barrier();
+			old = READ_ONCE(*ic);
 		}
 		new = old;
 		new.k = 1;
@@ -253,8 +251,7 @@ static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 		goto out;
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		new = old;
 		new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
@@ -269,12 +266,10 @@ static void ipte_lock_siif(struct kvm_vcpu *vcpu)
 
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		while (old.kg) {
 			cond_resched();
-			old = *ic;
-			barrier();
+			old = READ_ONCE(*ic);
 		}
 		new = old;
 		new.k = 1;
@@ -288,8 +283,7 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		new = old;
 		new.kh--;
 		if (!new.kh)
-- 
1.9.3
