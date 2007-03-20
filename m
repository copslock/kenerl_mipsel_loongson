Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 16:22:09 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.233]:49904 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022189AbXCTQWH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 16:22:07 +0000
Received: by qb-out-0506.google.com with SMTP id e12so6015256qba
        for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 09:21:05 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZrkEfXrzKsi3jPEV9xu79MUi1JBD6WsUMb1Z5BD2+k/ft9a/6vU8QQONL560ebAYCG2UryM83p/geQgBIkUV249X5ZlhvlPn3kwvpFUhOsTqd1KSbgoh+sRuttUvAAEmmOCCkr1mcGgksLGtBBS9g4DaMiNp5CLzFH1fdXiwkKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NSBMgrEgwhEvLmDOmi6yP0IGuGtlQhwQcXfUfYDvtazVNFh3oNLKQbRHAuz/5dSeuOsZOD1Z/rqatP9jL39pK8w2O7POvkcPc7SawvwCAe+U6km399SuZTJAM1BEZKDnN08oBzePY625+fCzXxiltkqzZLW9uK1F0e5SiBjDCYA=
Received: by 10.100.121.12 with SMTP id t12mr5174332anc.1174407665220;
        Tue, 20 Mar 2007 09:21:05 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Tue, 20 Mar 2007 09:21:05 -0700 (PDT)
Message-ID: <cda58cb80703200921r2744b87ch257c09eeb97528d5@mail.gmail.com>
Date:	Tue, 20 Mar 2007 17:21:05 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] Always include PHYS_OFFSET in PAGE_OFFSET
Cc:	mbizon@freebox.fr, post@pfrst.de,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <45FEB353.5020001@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45FEB353.5020001@innova-card.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf,

On 3/19/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
>
> For platforms that use PHYS_OFFSET and do not use a mapped kernel,
> this patch automatically adds PHYS_OFFSET into PAGE_OFFSET.
> Therefore for these platforms there are no more needs to change
> PAGE_OFFSET.
>

This patch is actually useless. I didn't notice that spaces.h must be
totaly rewritten by platforms when they need to customize one value.
Why, I dunno ?

Why not doing something like:

-- >8 --
diff --git a/include/asm-mips/mach-generic/spaces.h
b/include/asm-mips/mach-generic/spaces.h
index 0ae9997..beec80e 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -16,13 +16,18 @@
 #define CAC_BASE               0x80000000
 #define IO_BASE                        0xa0000000
 #define UNCAC_BASE             0xa0000000
+
+#ifndef MAP_BASE
 #define MAP_BASE               0xc0000000
+#endif

 /*
  * This handles the memory map.
  * We handle pages at KSEG0 for kernels with 32 bit address space.
  */
+#ifndef PAGE_OFFSET
 #define PAGE_OFFSET            0x80000000UL
+#endif

 /*
  * Memory above this physical address will be considered highmem.
@@ -38,11 +43,13 @@
 /*
  * This handles the memory map.
  */
+#ifndef PAGE_OFFSET
 #ifdef CONFIG_DMA_NONCOHERENT
 #define PAGE_OFFSET    0x9800000000000000UL
 #else
 #define PAGE_OFFSET    0xa800000000000000UL
 #endif
+#endif

 /*
  * Memory above this physical address will be considered highmem.
-- >8 --

and doing in platform's spaces.h:

        [ redefine a couple of constants]

        #include <asm/mach-generic/spaces.h>

AFAIK, {CAC,UNCAC,IO}_BASE are likely to be the same for all platforms, no ?

Does that need some cleanup ? if so I'm your man ;)
-- 
               Franck
