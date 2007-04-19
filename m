Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2007 10:33:53 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:56863 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021411AbXDSJdv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Apr 2007 10:33:51 +0100
Received: by ug-out-1314.google.com with SMTP id 40so549257uga
        for <linux-mips@linux-mips.org>; Thu, 19 Apr 2007 02:32:51 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=i75iwh4QmXnq6O4XlHDO84RlHIJ1WdUoQVhb43+VZ3qzR3S++za0gIvQALa+FEBVrplMFflgZpfD42OS8OsV4+HRmQY3+hdI2Gm0hO0YGbi3d0tAfVGfCuCY217eWsnHm7RMTD4VrvCZLL00wotk/o0p5lWrL3VGVUGz3DbbcvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=j2dxyVeLS3K61wK4OXQR/uk8RL6igC+nGQMdek9MS394X2c4H0yR+//hjMoJpa5EY7iv1JqSqV1Hv14eyLb6t6LHJ+S7tWAeLFY73S6bFbWI52Euo+49Bk32HSV6832ZMmx+mYPny5TYvbca83+wlMyWLOuScWPQ9sYXvmRoTfQ=
Received: by 10.67.10.18 with SMTP id n18mr1926106ugi.1176975170959;
        Thu, 19 Apr 2007 02:32:50 -0700 (PDT)
Received: from localhost ( [59.95.36.145])
        by mx.google.com with ESMTP id 34sm2788392uga.2007.04.19.02.32.47;
        Thu, 19 Apr 2007 02:32:50 -0700 (PDT)
Date:	Thu, 19 Apr 2007 15:05:16 +0530
From:	Milind Arun Choudhary <milindchoudhary@gmail.com>
To:	Kernel Janitors <kernel-janitors@lists.osdl.org>,
	MIPS <linux-mips@linux-mips.org>
Cc:	Andrw Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	thomas.koeller@baslerweb.com, ralf@linux-mips.org
Subject: [KJ][PATCH]SPIN_LOCK_UNLOCKED cleanup in arch/mips
Message-ID: <20070419093516.GA9486@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Return-Path: <milindchoudhary@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milindchoudhary@gmail.com
Precedence: bulk
X-list: linux-mips

SPIN_LOCK_UNLOCKED cleanup,use DEFINE_SPINLOCK instead 

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>
---
 excite_setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/basler/excite/excite_setup.c b/arch/mips/basler/excite/excite_setup.c
index 42f0eda..2f0e4c0 100644
--- a/arch/mips/basler/excite/excite_setup.c
+++ b/arch/mips/basler/excite/excite_setup.c
@@ -63,7 +63,7 @@ volatile void __iomem * const ocd_base = (void *) (EXCITE_ADDR_OCD);
 volatile void __iomem * const titan_base = (void *) (EXCITE_ADDR_TITAN);
 
 /* Protect access to shared GPI registers */
-spinlock_t titan_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(titan_lock);
 int titan_irqflags;
 
 
-- 
Milind Arun Choudhary
