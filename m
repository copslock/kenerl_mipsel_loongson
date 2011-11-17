Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 17:28:50 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51218 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904046Ab1KQQ2q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 17:28:46 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAHGSjrA004003;
        Thu, 17 Nov 2011 16:28:45 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAHGSiNR003997;
        Thu, 17 Nov 2011 16:28:44 GMT
Date:   Thu, 17 Nov 2011 16:28:44 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 1/6] MIPS: lantiq: reorganize xway code
Message-ID: <20111117162844.GC26457@linux-mips.org>
References: <1321453698-2598-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321453698-2598-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14574

On Wed, Nov 16, 2011 at 03:28:13PM +0100, John Crispin wrote:

> -	if (insert_resource(&iomem_resource, &ltq_cgu_resource) < 0)
> -		panic("Failed to insert cgu memory\n");

panic strings should not end in \n.

> +void __iomem *ltq_remap_resource(struct resource *res)
>  {
> -	struct clk *clk;
> +	__iomem void *ret = NULL;

void __iomem *ret = NULL;

diff --git a/arch/mips/lantiq/devices.h b/arch/mips/lantiq/devices.h
index 2947bb1..a03c23f 100644
--- a/arch/mips/lantiq/devices.h
+++ b/arch/mips/lantiq/devices.h
@@ -14,6 +14,10 @@

 #define IRQ_RES(resname, irq) \
        {.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
+#define MEM_RES(resname, adr_start, adr_size) \
+	{ .name = resname, .flags = IORESOURCE_MEM, \
+         .start = ((adr_start) & ~KSEG1), \
+         .end = ((adr_start + adr_size - 1) & ~KSEG1) }

Generally you're much better off by using physical addresses
as the kernel internal currency.  Don't make assumptions on the
value of the KSEG constants or that its value can be used or
turned into a bitmask.

  Ralf
