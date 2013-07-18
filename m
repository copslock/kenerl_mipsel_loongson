Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 16:56:01 +0200 (CEST)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:57048 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838172Ab3GRKrtO4wOV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 12:47:49 +0200
Received: by mail-pb0-f43.google.com with SMTP id md12so3010133pbc.2
        for <multiple recipients>; Thu, 18 Jul 2013 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5x4TZyTQIR+JwivSz4s2GpgVdwcd74Ryl0x/YLsOgXM=;
        b=x8ItLZY12w8ddxUpL+JPKUU7x1SUwj+yTPQwRAqRY7xLDaBp9+HGx7oOFx0LkQundL
         cI9y3ySKrU3pnNT/kdyu9yzJvRAeQA6oDjwl2oHokQ2AZsSWhuXEqKZDJ+b/9bTk0vu+
         uRA2Mk7S1Ujct+SObh5vqU35N9M42YL3zNck/tO/zTUgJXFnH9bDMriLSXsL6HGNPNrB
         FVJVSSIbrRyhAIR5dRuZ7I300nfQYdHy7kdG5REEjo9LrN21EN01oIi9cIfGKX//D9Xu
         0niE6g7TC+N+3eFC0KhZl4U3oLOytZACFBHT+gZ0ZzURuI0xzBk+akuGeXk39w6Ly5ky
         5qiQ==
X-Received: by 10.68.243.65 with SMTP id ww1mr11629607pbc.62.1374144462827;
        Thu, 18 Jul 2013 03:47:42 -0700 (PDT)
Received: from hades (111-243-154-117.dynamic.hinet.net. [111.243.154.117])
        by mx.google.com with ESMTPSA id z14sm13177224pbt.0.2013.07.18.03.47.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 03:47:42 -0700 (PDT)
Date:   Thu, 18 Jul 2013 18:47:37 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, "Jayachandran C." <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH v2 2/2] MIPS: tlbex: Guard tlbmiss_handler_setup_pgd
Message-ID: <20130718184656-tung7970@googlemail.com>
References: <20130718184440-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130718184440-tung7970@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

tlbmiss_handler_setup_pgd* are only referenced when
CONFIG_MIPS_PGD_C0_CONTEXT is defined.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/mm/tlb-funcs.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/tlb-funcs.S b/arch/mips/mm/tlb-funcs.S
index 30a494d..79bca31 100644
--- a/arch/mips/mm/tlb-funcs.S
+++ b/arch/mips/mm/tlb-funcs.S
@@ -16,10 +16,12 @@
 
 #define FASTPATH_SIZE	128
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 LEAF(tlbmiss_handler_setup_pgd)
 	.space		16 * 4
 END(tlbmiss_handler_setup_pgd)
 EXPORT(tlbmiss_handler_setup_pgd_end)
+#endif
 
 LEAF(handle_tlbm)
 	.space		FASTPATH_SIZE * 4
-- 
1.7.10.2
