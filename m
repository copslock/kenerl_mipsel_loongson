Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2011 00:06:16 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:41130 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491041Ab1IHWGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2011 00:06:10 +0200
Received: by bkat2 with SMTP id t2so293363bka.36
        for <multiple recipients>; Thu, 08 Sep 2011 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=0QL0/FnMtUiP/KIYyDDz4eZI3sxW0zd4hj32cWZugqs=;
        b=oceT+Z7JMHfbJSj6E1YNmzSlx4mOcaxRxrJZHLenVuT4N9au73NzbTCbMFIzs9wL42
         TQ4OQLi/1NswedLYHdCqZAUc73XZrZGP0adOrD13gOe4ApdnFEmiNHJ2hiGmBeHlzC7e
         KnoBhP/J2N9mC2JgwiPwet/8QW+iEkIstFE4M=
Received: by 10.204.151.85 with SMTP id b21mr882166bkw.8.1315519564875;
        Thu, 08 Sep 2011 15:06:04 -0700 (PDT)
Received: from localhost (84-231-27-196.elisa-mobile.fi [84.231.27.196])
        by mx.google.com with ESMTPS id t18sm1318919bkb.9.2011.09.08.15.06.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 15:06:03 -0700 (PDT)
Date:   Fri, 9 Sep 2011 01:06:00 +0300
From:   "Maxin B. John" <maxin.john@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: mm: tlbex.c: Fix compiler warnings
Message-ID: <20110908220559.GA3040@maxin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxin.john@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4263

 CC      arch/mips/mm/tlbex.o
cc1: warnings being treated as errors
arch/mips/mm/tlbex.c: In function 'build_r3000_tlb_modify_handler':
arch/mips/mm/tlbex.c:1769: error: 'wr.r1' is used uninitialized in this function
arch/mips/mm/tlbex.c:1769: error: 'wr.r2' is used uninitialized in this function
arch/mips/mm/tlbex.c:1769: error: 'wr.r3' is used uninitialized in this function
make[2]: *** [arch/mips/mm/tlbex.o] Error 1
make[1]: *** [arch/mips/mm] Error 2
make: *** [arch/mips] Error 2

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b6e1cff..ab51b83 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1764,6 +1764,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
+	memset(&wr, 0, sizeof(wr));
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_modifiable(&p, &r, wr.r1, wr.r2,  wr.r3, label_nopage_tlbm);
