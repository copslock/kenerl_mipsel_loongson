Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GHcpRw008866
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 10:38:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GHcp0r008865
	for linux-mips-outgoing; Tue, 16 Jul 2002 10:38:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from clearcore.com (clrsrv@[208.141.182.168])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GHcgRw008855
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 10:38:43 -0700
Received: (qmail 5492 invoked from network); 16 Jul 2002 17:43:33 -0000
Received: from clrsrv.clearcore.com (HELO clearcore.net) (192.168.1.1)
  by clrsrv.clearcore.com with SMTP; 16 Jul 2002 17:43:33 -0000
Message-ID: <3D345B45.50001@clearcore.net>
Date: Tue, 16 Jul 2002 11:43:33 -0600
From: Joe George <joeg@clearcore.net>
Organization: ClearCore
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: PATCH
References: <1026772150.15665.145.camel@zeus.mvista.com> <20020716170741.E31186@dea.linux-mips.net> <1026832557.3552.3.camel@adsl.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'll disagree with both of you so I may learn from the flames. :-)

First it's true the patch wasn't formatted for oss and should have
been rejected on that basis.  At least my patches would be. :)

But Vivien Chappelier said it fixed his X server problem in mips64.
CONFIG_64BIT_PHYS_ADDR is applicable to both 36 and 64
bit code, I think.

So the crux of my question is, if an unsigned long long pte is
and'ed with an unsigned long PAGE_CHG_MASK what happens
to the upper 32 bits of pte.  On a 64 bit processor is PAGE_CHG_MASK
sign extended so everything is fine, or does it zero the upper
32 bits?

Joe


Pete Popov wrote:
> On Tue, 2002-07-16 at 08:07, Ralf Baechle wrote:
> 
>>On Mon, Jul 15, 2002 at 03:29:10PM -0700, Pete Popov wrote:
>>
>>
>>>--- include/asm-mips/pgtable.h.old	Fri Jul 12 17:25:19 2002
>>>+++ include/asm-mips/pgtable.h	Fri Jul 12 17:25:36 2002
>>>@@ -332,7 +332,9 @@
>>> 
>>> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>> {
>>>-	return __pte(((pte).pte_low & _PAGE_CHG_MASK) | pgprot_val(newprot));
>>>+	pte.pte_low &= _PAGE_CHG_MASK;
>>>+	pte.pte_low |= pgprot_val(newprot);
>>>+	return pte;
>>> }
>>>
>>This patch certainly doesn't apply to oss.  Seems somebody did copy all
>>the x86 pte_t and stuff into your tree without too much thinking ...
>>
> 
> That's right, I forgot you don't have the 36 bit code that uses pte_low
> and pte_high.  
> 
> Pete
> 
