Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 12:49:18 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.236]:50550 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037796AbWJLLtP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 12:49:15 +0100
Received: by hu-out-0506.google.com with SMTP id 20so134839huc
        for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 04:49:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=gTqdblnp4NUZgvr6F+jESDHGP3sz6PKD6fi7xVF90SC6To9b56fvIVzyI1fe9Fyv8HUIsElWI/38xRQFO208BHa8qAemVbcextFdxe3aOskanU8zUHeWl0Gh+J4VIyE30HKf/lo0VZrLBM9A5M7PXPhiJr01bK7Mjv/j7Z28EHo=
Received: by 10.49.29.3 with SMTP id g3mr4933129nfj;
        Thu, 12 Oct 2006 04:49:11 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id p45sm2520588nfa.2006.10.12.04.49.10;
        Thu, 12 Oct 2006 04:49:11 -0700 (PDT)
Message-ID: <452E2BB2.2090601@innova-card.com>
Date:	Thu, 12 Oct 2006 13:49:06 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
References: <452CFC95.1080806@innova-card.com>	<20061012.003007.08076055.anemo@mba.ocn.ne.jp>	<452D1567.1050706@innova-card.com> <20061012.190559.96685979.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061012.190559.96685979.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 11 Oct 2006 18:01:43 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> __pa() is used in many place indirectly via virt_to_page().
>> what about make virt_to_page() use virt_to_phys() instead ?
> 
> No objection for virt_to_phys(), but I found other __pa() usages in
> kernel.
> 
> drivers/char/mem.c:       && addr >= __pa(high_memory);
> drivers/char/mem.c:     return addr >= __pa(high_memory);
> drivers/char/mem.c:     if (addr + count > __pa(high_memory))
> drivers/char/mem.c:     pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
> 
> So __pa() should handle >512MB address unless we change all __pa() usages.

weird, I really thought that __pa() shouldn't be used by drivers...
Let see what people on lkml think about this usage, you'll be CC'ed
if you want to.

> 
> How about something like this ?
> 
> #if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
> #define __pa(x)			((unsigned long)(x) - ((unsigned long)(x) >= CKSEG0 ? CKSEG0 : PAGE_OFFSET))
> #else
> #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
> #endif
> 

It would be safer indeed, specially because __pa() definition is not
really well defined and seems to be confusing for most people.

> In any case, I think virt_to_page() should use simpler virt_to_phys()
> for better performance.

I agree.

		Franck
