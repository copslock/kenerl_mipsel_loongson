Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jul 2013 12:01:48 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54590 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824770Ab3GQKBqOz1lM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jul 2013 12:01:46 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so1657590pdj.8
        for <multiple recipients>; Wed, 17 Jul 2013 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5x4TZyTQIR+JwivSz4s2GpgVdwcd74Ryl0x/YLsOgXM=;
        b=wxELLum1n+gWwCtim/kv49FiNntQWkjFQBumUBP3mU9aNzQiyKIXhLggfQ1P55Sjyv
         RXGqib5pRLoeEtPjV3B4hPzjBMekMwbAJAXlxen0Sl+ysQOwNC8pWVY2jRd/9+z0E2q5
         0dZPkZ3OT38kY2CXwbt1c9UM4lfHLMM6fvlSa2/QqVJUdcJiEF3r3yuNCVLFWm0yYypt
         6as9MWi8KbiBOMOz833XddXuOiLn+u7VmvVrHXnV4S1RoxOtyCRdAeqeK895ITN3YXTf
         06Log6B0erGiTmqbJ+Xia3GHXzblICR7ws3i52CEMoaEbJO/Tcr2DaZo3uhuMPpB2vmb
         9N1A==
X-Received: by 10.66.27.143 with SMTP id t15mr2937752pag.171.1374055299660;
        Wed, 17 Jul 2013 03:01:39 -0700 (PDT)
Received: from hades.local ([116.59.227.231])
        by mx.google.com with ESMTPSA id om2sm6935106pbb.34.2013.07.17.03.01.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 03:01:39 -0700 (PDT)
Date:   Wed, 17 Jul 2013 18:01:29 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: tlbex: Guard tlbmiss_handler_setup_pgd
Message-ID: <20130717180052-tung7970@googlemail.com>
References: <20130717175840-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130717175840-tung7970@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37307
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
