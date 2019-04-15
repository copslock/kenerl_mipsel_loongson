Return-Path: <SRS0=MCbt=SR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C1C10F0E
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208FF2075B
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 15:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfDOP2C (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:28:02 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:27069 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOP2C (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 15 Apr 2019 11:28:02 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 11:28:01 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 700823F7FD;
        Mon, 15 Apr 2019 17:22:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eflF7c8D4uKP; Mon, 15 Apr 2019 17:22:53 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9A5B73F67D;
        Mon, 15 Apr 2019 17:22:52 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:22:52 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC] MIPS: Install final length of TLB refill handler rather
 than 256 bytes
Message-ID: <20190415152252.GA7205@sx9>
References: <20190405160531.GF33393@sx9>
 <5b42742e-b9fb-996a-fbe4-918d48aa0a18@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b42742e-b9fb-996a-fbe4-918d48aa0a18@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Phil,

> There is a comment about the R4000 worst case:
> 
>  /* The worst case length of the handler is around 18 instructions for
>   * R3000-style TLBs and up to 63 instructions for R4000-style TLBs.
>   * Maximum space available is 32 instructions for R3000 and 64
>   * instructions for R4000.
> 
> So you need to check the handler generated for your cpu doesn't exceed
> your 32 instructions.

Do you mean like this:

> On 4/5/19 6:05 PM, Fredrik Noring wrote:
> > I have a separate patch that checks the R5900 handler length limit,
> > but it depends on R5900 support, which isn't merged (yet).

I have now attached this separate patch for reference, see below.

> Maybe you could modify the logic few lines earlier that check and
> panic("TLB refill handler space exceeded") and add a case for your cpu
> type. There you could set a handler_max_size = 0x80, 0x100 else.
> 
> Take my comment as RFC too, I'm just wondering :)

To check the length we would need to define CPU_R5900 first. :)

Are any MIPS kernel maintainers happy to review an initial R5900 patch
submission?

[ The patch in the original RFC is generic and it does not depend on
the availability of CPU_R5900, although it avoids clobbering the R5900
performance counter handler. ]

Fredrik

--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1399,6 +1399,10 @@ static void build_r4000_tlb_refill_handler(void)
 	 * unused.
 	 */
 	switch (boot_cpu_type()) {
+	case CPU_R5900:
+		if ((p - tlb_handler) > 32)
+			panic("TLB refill handler space exceeded");
+		/* Fallthrough */
 	default:
 		if (sizeof(long) == 4) {
 	case CPU_LOONGSON2:
