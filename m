Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 16:56:49 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49456 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838164Ab3GRKp7UfYLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 12:45:59 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl14so3037043pab.20
        for <multiple recipients>; Thu, 18 Jul 2013 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=EA+ykVqBhamyPl4nAm6Rmhbve9Z8daMF0j9jM1jrbGU=;
        b=Gh4HBqreYZAUJZdieRAJJ3bAYdGq7Dbl1hzDSFLi3yo+fiWbKT8C2qvgpFFMneyypn
         t5SKZ9iXIIIAQFbBo8CzIIwCqxwShU+zikUnrigE9jqHAh9rC0TilfLs+3yWB/sht4QT
         uoCvXsNHiPdhoFKcqgIi5wIIa6ZpiL13cJf8l9o0CRjYQxK8vu1B6p1mRFMbn16KHQin
         o3PnGiaqgY7TV+CW/p0qYOGNwvezIvCZXyLPuqHXmpW0cCkAHIcybpjuBrz+I9FG82Um
         LhAzCRt9S3VWbztIky5Ix6dpY2zyvuy1Rnu2BQ0bK9SSQugGEJwtATDxt7kePgEcrf/r
         uXPw==
X-Received: by 10.68.189.228 with SMTP id gl4mr11537613pbc.57.1374144352897;
        Thu, 18 Jul 2013 03:45:52 -0700 (PDT)
Received: from hades (111-243-154-117.dynamic.hinet.net. [111.243.154.117])
        by mx.google.com with ESMTPSA id ib9sm13037893pbc.43.2013.07.18.03.45.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 03:45:52 -0700 (PDT)
Date:   Thu, 18 Jul 2013 18:45:47 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, "Jayachandran C." <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH v2 1/2] MIPS: tlbex: Fix typo in r3000 tlb store handler
Message-ID: <20130718184440-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37312
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

commit 6ba045f (MIPS: Move generated code to .text for microMIPS)
causes a panic at boot. The handler builder should test against
handle_tlbs_end, not handle_tlbs.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Jayachandran C <jchandra@broadcom.com>
Acked-by: Jayachandran C. <jchandra@broadcom.com>
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
