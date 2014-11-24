Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 14:04:08 +0100 (CET)
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:35345 "EHLO
        e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006860AbaKXNDn6zlDH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 14:03:43 +0100
Received: from /spool/local
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Nov 2014 13:03:38 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 13:03:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE3A8219006A
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:03:08 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com [9.149.37.252])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOD3aP047841442
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:03:36 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOD3ZTp008603
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 06:03:36 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOD3Zdm008593;
        Mon, 24 Nov 2014 06:03:35 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 456511224439; Mon, 24 Nov 2014 14:03:35 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 5/7] mips: Replace ACCESS_ONCE in gup with a barrier
Date:   Mon, 24 Nov 2014 14:03:28 +0100
Message-Id: <1416834210-61738-6-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112413-0009-0000-0000-0000021CB6D2
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44369
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
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Let's use a barrier instead of ACCESS_ONCE to avoid that issue.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/mips/mm/gup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index 06ce17c..cb2ca51 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -17,8 +17,8 @@
 
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 	pte_t pte;
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
 retry:
 	pte.pte_low = ptep->pte_low;
@@ -30,7 +30,9 @@ retry:
 
 	return pte;
 #else
-	return ACCESS_ONCE(*ptep);
+	pte = *ptep;
+	barrier();
+	return pte;
 #endif
 }
 
-- 
1.9.3
