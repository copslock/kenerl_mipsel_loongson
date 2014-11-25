Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 13:39:10 +0100 (CET)
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:38095 "EHLO
        e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006658AbaKYMismPX0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 13:38:48 +0100
Received: from /spool/local
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Nov 2014 12:38:42 -0000
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 25 Nov 2014 12:38:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6DEA61B08069
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:55 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPCcejJ14745976
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:40 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAPCcdUF019993
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 05:38:40 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAPCcdPf019985;
        Tue, 25 Nov 2014 05:38:39 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id A96DE1224458; Tue, 25 Nov 2014 13:38:39 +0100 (CET)
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
Subject: [PATCHv2 04/10] x86/spinlock: Replace ACCESS_ONCE with READ_ONCE/ASSIGN_ONCE
Date:   Tue, 25 Nov 2014 13:38:31 +0100
Message-Id: <1416919117-50652-5-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112512-0017-0000-0000-000001F84C60
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44433
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

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Change the spinlock code to replace ACCESS_ONCE with READ_ONCE
and ASSIGN_ONCE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/x86/include/asm/spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 9295016..af6e673 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -92,7 +92,7 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 		unsigned count = SPIN_THRESHOLD;
 
 		do {
-			if (ACCESS_ONCE(lock->tickets.head) == inc.tail)
+			if (ASSIGN_ONCE(inc.tail, lock->tickets.head))
 				goto out;
 			cpu_relax();
 		} while (--count);
@@ -105,7 +105,7 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	arch_spinlock_t old, new;
 
-	old.tickets = ACCESS_ONCE(lock->tickets);
+	old.tickets = READ_ONCE(lock->tickets);
 	if (old.tickets.head != (old.tickets.tail & ~TICKET_SLOWPATH_FLAG))
 		return 0;
 
@@ -162,14 +162,14 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
+	struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 
 	return tmp.tail != tmp.head;
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
+	struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 
 	return (__ticket_t)(tmp.tail - tmp.head) > TICKET_LOCK_INC;
 }
-- 
1.9.3
