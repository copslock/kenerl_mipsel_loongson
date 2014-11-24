Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 14:05:23 +0100 (CET)
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:33483 "EHLO
        e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006865AbaKXNDpI0lp1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 14:03:45 +0100
Received: from /spool/local
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Nov 2014 13:03:38 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 13:03:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 47792219006F
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:03:09 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOD3aoR12321096
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:03:36 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOD3ZOt004095
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 06:03:36 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOD3Z2j004088;
        Mon, 24 Nov 2014 06:03:35 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 78AA01224439; Mon, 24 Nov 2014 14:03:35 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 6/7] arm64: Replace ACCESS_ONCE for spinlock code with barriers
Date:   Mon, 24 Nov 2014 14:03:29 +0100
Message-Id: <1416834210-61738-7-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112413-0017-0000-0000-000001F464B6
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44373
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

Change the spinlock code to access the lock with a barrier.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/arm64/include/asm/spinlock.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index c45b7b1..f72dc64 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -99,12 +99,15 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
+	arch_spinlock_t lockval = *lock;
+	barrier();
+	return !arch_spin_value_unlocked(lockval);
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	arch_spinlock_t lockval = ACCESS_ONCE(*lock);
+	arch_spinlock_t lockval = *lock;
+	barrier();
 	return (lockval.next - lockval.owner) > 1;
 }
 #define arch_spin_is_contended	arch_spin_is_contended
-- 
1.9.3
