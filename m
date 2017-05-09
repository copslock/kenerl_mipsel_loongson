Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2017 12:05:35 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.135]:59063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993948AbdEIKF1AOPKq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2017 12:05:27 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LqY9V-1dcOx23knJ-00e7Zh; Tue, 09 May 2017 12:05:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.16-stable 11/14] MIPS: Fix a warning for virt_to_page
Date:   Tue,  9 May 2017 12:04:59 +0200
Message-Id: <20170509100502.1358298-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170509100502.1358298-1-arnd@arndb.de>
References: <20170509100502.1358298-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Kujrc62gdGYyW+7JwWFYLMRM5RXZuDYDrsFN8VktU6v/pTJfGTu
 WCYRNYBU5EQ2T7FEiHzun/RPmHt0zrUdutrehwOmIT5ZZ7mwt/qxiJQj41wNfZ28UxZTdWv
 O8FTp/6LiIKbufdU4DhxYyof8bvRatQ0QebvxmG2blB/ryNz1Z40SrjeRqViUcrnkWn6oYN
 TeS3doN60kLiqFYHV4NVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YeXBJDQ8A4Q=:PIwFHhR0wP3RiOcQ9g1Fl8
 v8/YqmwyoS2ObZKNDBHzHMJQTxBIEIZvYa4Ux6tK5kqrY0gI5TjWCsgJ22ICllEuZKzrmm69c
 EVobHvm5sRrZQfgn0TsGqedhY542ExPzLtm8nSouj2G12pOoUx/TM7c9JuMx9z2EdhjzkOOhN
 icRVhpnHDgrsace1DT8QifsZ7tIhcvMQhrX5Q/IB7uHA09FpOXLpaRCNVZF0PmtfixvQbBooT
 sKmFgaCWgUhmO7WgU7449Qvo+BiMFMX5Q6CpWq/0FjS/4dygGS9CnDQwiMtrbfp3mIYLgdRfs
 Yazx6A5qbBEDh16jAMuA898gdfqmo1m+ml13/oerpbgX35otCMmYYo+8NUXSdc/2egFFZY20M
 r7QACG5vDJktHatyTS7ebTMWOrS92lVB0xVN1fZ1en3pMkj7Vxv9AQpDUvu2QqRzlwel9UBl1
 IdnnYSpYMrNnVeKIZ1mHAvlRQUibJmLBcu7+kSO3BcXzFy0StS1Wk7R4k3B84+FzuvCZQyfuM
 EGPhRlDIRP3jpeKyXLQmvwy2uNUmQOx2dgFQIXBIGQrVHNZO5kjzNJhUA+8lpC66rnl9nNDKS
 fjOP+8d6YZz/AVbhcvoLNxqU+dPhMUFbsqiDiBVgnt/MhGB5O0dUeWyxUqWwwBKMyqRrwaLZP
 JpdrNF/EyDsSmp7H2JxZD7QwMM2pyo+qHrpUgW/Lu859Jb7NaDwOhsN/ZNiLbiydj0FI=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

commit 4d5b3bdc0ecb0cf5b1e1598eeaaac4b5cb33868d upstream.

Compiling mm/highmem.c gives a warning: passing argument 1 of
'virt_to_phys' makes pointer from integer without a cast

Fixed by casting to void*

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7337/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/page.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5699ec3a71af..fd0347da36df 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -223,7 +223,8 @@ static inline int pfn_valid(unsigned long pfn)
 
 #endif
 
-#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
+#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys((void *)     \
+								  (kaddr))))
 
 extern int __virt_addr_valid(const volatile void *kaddr);
 #define virt_addr_valid(kaddr)						\
-- 
2.9.0
