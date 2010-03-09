Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 22:03:51 +0100 (CET)
Received: from mail1.pearl-online.net ([62.159.194.147]:42774 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492282Ab0CIVDq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 22:03:46 +0100
Received: from Mobile0.Peter (unknown [95.157.15.72])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 1A7B82012A;
        Tue,  9 Mar 2010 22:04:44 +0100 (CET)
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id o29MLZoJ001217;
        Tue, 9 Mar 2010 22:21:35 GMT
Received: from Opal.Peter (localhost [127.0.0.1])
        by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id o29L3S5s001017;
        Tue, 9 Mar 2010 22:03:28 +0100
Received: from localhost (pf@localhost)
        by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id o29L3SqJ001013;
        Tue, 9 Mar 2010 22:03:28 +0100
X-Authentication-Warning: Opal.Peter: pf owned process doing -bs
Date:   Tue, 9 Mar 2010 22:03:27 +0100 (CET)
From:   peter fuerst <post@pfrst.de>
X-Sender: pf@Opal.Peter
To:     Florian Fainelli <florian@openwrt.org>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET
In-Reply-To: <201003091546.01281.florian@openwrt.org>
Message-ID: <Pine.LNX.4.21.1003092137280.898-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi Florian, thats funny!

On Tue, 9 Mar 2010, Florian Fainelli wrote:

  > Date: Tue, 9 Mar 2010 15:46:01 +0100
  > From: Florian Fainelli <florian@openwrt.org>
  > To: linux-mips@linux-mips.org
  > Cc: ralf@linux-mips.org
  > Subject: [PATCH] MIPS: make CAC_ADDR and UNCAC_ADDR account for
  >     PHYS_OFFSET
  > 
  > On AR7, ...
  > 
  > Signed-off-by: Regards, Florian Fainelli <florian@openwrt.org>
  > ---
  > diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
  > index ac32572..7b11df5 100644
  > --- a/arch/mips/include/asm/page.h
  > +++ b/arch/mips/include/asm/page.h
  > @@ -188,8 +188,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  >  #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
  >  				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
  >  
  > -#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
  > -#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
  > +#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE + 	\
  > +								PHYS_OFFSET)
  > +#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET +	\
  > +								PHYS_OFFSET)
  >  
  >  #include <asm-generic/memory_model.h>
  >  #include <asm-generic/getorder.h>
  > 

I assume, you don't want "+" PHYS_OFFSET in both defines.

Two years and a month ago almost the same patch (which used to work on
the machine that needed it :) was submitted:

  --- a/linux-2.6.24/include/asm-mips/page.h	Fri Jan 25 12:23:51 2008
  +++ b/linux-2.6.24/include/asm-mips/page.h	Wed Feb  6 23:26:31 2008
  @@ -184,8 +184,8 @@
   #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
   				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
  
  -#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
  -#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
  +#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + PHYS_OFFSET + UNCAC_BASE)
  +#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET - PHYS_OFFSET)
  
   #include <asm-generic/memory_model.h>
   #include <asm-generic/page.h>

But correct versions of these macros seem to be essential for very
"exotic" systems only ;-)


kind regards

peter
