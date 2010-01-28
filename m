Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 18:00:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57125 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492465Ab0A1RAm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 18:00:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0SH0mRx008168;
        Thu, 28 Jan 2010 18:00:50 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0SH0jGI008158;
        Thu, 28 Jan 2010 18:00:46 +0100
Date:   Thu, 28 Jan 2010 18:00:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 3/3] MIPS: deal with larger physical offsets
Message-ID: <20100128170036.GE6950@linux-mips.org>
References: <201001281522.37939.florian@openwrt.org>
 <4B61BD4D.5060406@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B61BD4D.5060406@ru.mvista.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18308

On Thu, Jan 28, 2010 at 07:37:33PM +0300, Sergei Shtylyov wrote:

> Florian Fainelli wrote:
> >AR7 has a larger physical offset than other MIPS based
> >systems and therefore needs to setup its handlers beyond
> >the usual KSEG0 range. When running the kernel in mapped
> >mode this modification is also required. Remove function
> >comment which is now incorrect.
> >
> >Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> >Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
> >Signed-off-by: Florian Fainelli <florian@openwrt.org>
> >---
> >diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> >index 574608e..14d515f 100644
> >--- a/arch/mips/kernel/traps.c
> >+++ b/arch/mips/kernel/traps.c
> ...]
> >@@ -1283,9 +1279,18 @@ void __init *set_except_vector(int n, void *addr)
> > 	exception_handlers[n] = handler;
> > 	if (n == 0 && cpu_has_divec) {
> >-		*(u32 *)(ebase + 0x200) = 0x08000000 |
> >-					  (0x03ffffff & (handler >> 2));
> >-		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
> >+		unsigned long jump_mask = ~((1 << 28) - 1);
> >+		u32 *buf = (u32 *)(ebase + 0x200);
> >+		unsigned int k0 = 26;
> >+		if((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
> 
>  Missing space after *if* (should be easy for Ralf to fix manually
> though). You should run the patch thru scripts/checkpatch.pl first.

Just did that.  Thanks for nitpicking :-)

  Ralf
