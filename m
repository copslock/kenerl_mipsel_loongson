Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 12:51:47 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52995 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbdCJLvfVVaV0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 12:51:35 +0100
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cmJ52-00088t-Kn; Fri, 10 Mar 2017 11:51:33 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cmJ4z-0003dt-RC; Fri, 10 Mar 2017 11:51:29 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "James Hogan" <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        "Paolo Bonzini" <pbonzini@redhat.com>, linux-mips@linux-mips.org
Date:   Fri, 10 Mar 2017 11:46:22 +0000
Message-ID: <lsq.1489146382.184042691@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 182/370] KVM: MIPS: Flush KVM entry code from icache
 globally
In-Reply-To: <lsq.1489146380.780052105@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.42-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 32eb12a6c11034867401d56b012e3c15d5f8141e upstream.

Flush the KVM entry code from the icache on all CPUs, not just the one
that built the entry code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kvm/kvm_mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -343,8 +343,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 	       mips32_GuestExceptionEnd - mips32_GuestException);
 
 	/* Invalidate the icache for these ranges */
-	local_flush_icache_range((unsigned long)gebase,
-				(unsigned long)gebase + ALIGN(size, PAGE_SIZE));
+	flush_icache_range((unsigned long)gebase,
+			   (unsigned long)gebase + ALIGN(size, PAGE_SIZE));
 
 	/* Allocate comm page for guest kernel, a TLB will be reserved for mapping GVA @ 0xFFFF8000 to this page */
 	vcpu->arch.kseg0_commpage = kzalloc(PAGE_SIZE << 1, GFP_KERNEL);
