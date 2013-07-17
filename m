Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jul 2013 12:00:15 +0200 (CEST)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62625 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823064Ab3GQKAE4XHKL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jul 2013 12:00:04 +0200
Received: by mail-pb0-f44.google.com with SMTP id uo1so1726282pbc.17
        for <multiple recipients>; Wed, 17 Jul 2013 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Gski+ArHpSihBb4cPMua6ET6KXkXgjSNv6qwcTzRVJY=;
        b=CSRjjo0DMpoCPQQHTSjPTDNIErLPFoLlcIUqwwIGP+PzICFDxpKlnQtZVoUgv9GW1Y
         11cRH3fLzJZwB7rS+efamdfX5cUq5y2sjU+Sx6AevpidoQf9sq00x73Fhbl7YPxQlRaP
         WGr/rVjBQAv96oz4APcklkecjQJjGdF7uxgmu3m2emz2g/G4M9ywxEb/crxkNsklfD63
         i0/fLIlZf45TeRxhQ3+CLN/viTQEej1KMInLWKMeCLWWX5RQAStkDmRUARF6KXGHhtov
         c0FSVxRPRtuxSKiDLMRTV4tdefcDNcqib88Sqpw91WU0f6JzZu5rd2ncTFEXuOzpWayu
         8Avw==
X-Received: by 10.68.171.99 with SMTP id at3mr6077905pbc.64.1374055197375;
        Wed, 17 Jul 2013 02:59:57 -0700 (PDT)
Received: from hades.local ([116.59.227.231])
        by mx.google.com with ESMTPSA id bg3sm6895762pbb.44.2013.07.17.02.59.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 02:59:56 -0700 (PDT)
Date:   Wed, 17 Jul 2013 17:59:47 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: tlbex: Fix typo in r3000 tlb store handler
Message-ID: <20130717175840-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37306
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

Should test against handle_tlbs_end, not handle_tlbs.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/mm/tlbex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 9ab0f90..605b6fc 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1803,7 +1803,7 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if (p >= handle_tlbs)
+	if (p >= handle_tlbs_end)
 		panic("TLB store handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
-- 
1.7.10.2
