Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B9DC4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF62521855
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 16:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfDEQMg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:12:36 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:32974 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEQMg (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 5 Apr 2019 12:12:36 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 12:12:36 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5EB3F3F6AD;
        Fri,  5 Apr 2019 18:05:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JTOSpaMso9mb; Fri,  5 Apr 2019 18:05:31 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7EEA73F668;
        Fri,  5 Apr 2019 18:05:31 +0200 (CEST)
Date:   Fri, 5 Apr 2019 18:05:31 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [RFC] MIPS: Install final length of TLB refill handler rather than
 256 bytes
Message-ID: <20190405160531.GF33393@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The R5900 TLB refill handler is limited to 128 bytes, corresponding
to 32 instructions.

Installing a 256 byte TLB refill handler for the R5900 at address
0x80000000 overwrites the performance counter handler at address
0x80000080, according to the TX79 manual[1]:

        Table 5-2. Exception Vectors for Level 1 exceptions

             Exceptions      |      Vector Address
                             |   BEV = 0  |   BEV = 1
        ---------------------+------------+-----------
        TLB Refill (EXL = 0) | 0x80000000 | 0xBFC00200
        TLB Refill (EXL = 1) | 0x80000180 | 0xBFC00380
        Interrupt            | 0x80000200 | 0xBFC00400
        Others               | 0x80000180 | 0xBFC00380
        ---------------------+------------+-----------

        Table 5-3. Exception Vectors for Level 2 exceptions

             Exceptions      |      Vector Address
                             |   DEV = 0  |   DEV = 1
        ---------------------+------------+-----------
        Reset, NMI           | 0xBFC00000 | 0xBFC00000
        Performance Counter  | 0x80000080 | 0xBFC00280
        Debug, SIO           | 0x80000100 | 0xBFC00300
        ---------------------+------------+-----------

Reference:

[1] "TX System RISC TX79 Core Architecture" manual, revision 2.0,
    Toshiba Corporation, p. 5-7, https://wiki.qemu.org/File:C790.pdf

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
Hi MIPS maintainers,

Reading through the TX79 manual I noticed that the installation of
the TLB refill handler seems to overwrite the performance counter
handler. Is there any particular reason to not install the actual
lengths of the handlers, such as memory boundaries or alignments?

I have a separate patch that checks the R5900 handler length limit,
but it depends on R5900 support, which isn't merged (yet).

Fredrik
---
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1462,9 +1462,9 @@ static void build_r4000_tlb_refill_handler(void)
 	pr_debug("Wrote TLB refill handler (%u instructions).\n",
 		 final_len);
 
-	memcpy((void *)ebase, final_handler, 0x100);
-	local_flush_icache_range(ebase, ebase + 0x100);
-	dump_handler("r4000_tlb_refill", (u32 *)ebase, (u32 *)(ebase + 0x100));
+	memcpy((void *)ebase, final_handler, 4 * final_len);
+	local_flush_icache_range(ebase, ebase + 4 * final_len);
+	dump_handler("r4000_tlb_refill", (u32 *)ebase, (u32 *)(ebase + 4 * final_len));
 }
 
 static void setup_pw(void)
