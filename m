Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 06:35:14 +0100 (CET)
Received: from gateway31.websitewelcome.com ([192.185.144.91]:42997 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbdJaFfHmbve0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 06:35:07 +0100
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4D75427FDED
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 00:35:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9PCceNfFfHEIm9PCceTxzX; Tue, 31 Oct 2017 00:35:06 -0500
Received: from [189.145.38.148] (port=59716 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.87)
        (envelope-from <garsilva@embeddedor.com>)
        id 1e9PCb-001aVz-Fc; Tue, 31 Oct 2017 00:35:05 -0500
Date:   Tue, 31 Oct 2017 00:35:03 -0500
From:   "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Julia Lawal <julia.lawall@lip6.fr>
Subject: [PATCH] MIPS: microMIPS: Fix incorrect mask in insn_table_MM
Message-ID: <20171031053503.GA5164@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.38.148
X-Source-L: No
X-Exim-ID: 1e9PCb-001aVz-Fc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.38.148]:59716
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Return-Path: <garsilva@embeddedor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: garsilva@embeddedor.com
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

It seems that this is a typo error and the proper bit masking is
"RT | RS" instead of "RS | RS".

This issue was detected with the help of Coccinelle.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 arch/mips/mm/uasm-micromips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index c28ff53..cdb5a19 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -80,7 +80,7 @@ static const struct insn const insn_table_MM[insn_invalid] = {
 	[insn_jr]	= {M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS},
 	[insn_lb]	= {M(mm_lb32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
 	[insn_ld]	= {0, 0},
-	[insn_lh]	= {M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM},
+	[insn_lh]	= {M(mm_lh32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
 	[insn_ll]	= {M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM},
 	[insn_lld]	= {0, 0},
 	[insn_lui]	= {M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM},
-- 
2.7.4
