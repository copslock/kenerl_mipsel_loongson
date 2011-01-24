Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 13:27:13 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:36696 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490996Ab1AXM1K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 13:27:10 +0100
Received: by pzk30 with SMTP id 30so739031pzk.36
        for <multiple recipients>; Mon, 24 Jan 2011 04:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=MZFlsxy02Bss/LtBAeBwAxpd6h8bnVbXzrSGPi2ctnM=;
        b=PIaFPTso0wF3/BmUgG98HCZAnGBOAIIxiIKmlZiFx9pW4iMw6F5pj8oBo4sA/soU6h
         801CXmH4bE93msrOqJbw0RRahQk0bNpJV5m+2/Nm+E/sy6J3fdSemsYcEqqAKHpduCL8
         jgD2QMQP/EbR1C5+XR4PyahBecMYxKQjeK9Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cAT2nckWjjg0HmXcp4Gp4RYegQiyzz9XDvIaJCQO+GrEfQ7CsMqaLBoQtGngd21daJ
         SvoRWfOjicUJpfmeadAdWWalNfGN0VRCUC3QCqm4xJZx+FdL7uPonSdCbezaZ9M9Zl9r
         ReeNPmlLxrDrWq8hcwiuMpz7HdRmX6GlNJZm4=
Received: by 10.142.172.3 with SMTP id u3mr3541393wfe.374.1295872023457;
        Mon, 24 Jan 2011 04:27:03 -0800 (PST)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id c3sm3739186wfa.14.2011.01.24.04.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Jan 2011 04:27:00 -0800 (PST)
Date:   Mon, 24 Jan 2011 21:08:13 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix build error when CONFIG_SWAP is not set
Message-Id: <20110124210813.ba743fc5.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.3 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

In file included from
linux-2.6/arch/mips/include/asm/tlb.h:21,
                 from mm/pgtable-generic.c:9:
include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
include/asm-generic/tlb.h:76: error: implicit declaration of function
'release_pages'
include/asm-generic/tlb.h: In function 'tlb_remove_page':
include/asm-generic/tlb.h:105: error: implicit declaration of function
'page_cache_release'
make[1]: *** [mm/pgtable-generic.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 include/linux/swap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4d55932..92c1be6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -8,6 +8,7 @@
 #include <linux/memcontrol.h>
 #include <linux/sched.h>
 #include <linux/node.h>
+#include <linux/pagemap.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
-- 
1.7.3.5
