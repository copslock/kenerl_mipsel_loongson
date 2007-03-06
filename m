Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 21:41:05 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.168]:65315 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021464AbXCFVlB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 21:41:01 +0000
Received: by ug-out-1314.google.com with SMTP id 40so381497uga
        for <linux-mips@linux-mips.org>; Tue, 06 Mar 2007 13:40:00 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fmjpq7/0xHprfcrTUTTGSC2bdv4u0CPmd6KW4jjEzlQr90EnEJ5UIoMvAnWElc6elGD3tlIV6APLcBVV2A6CIEIStXoLyo8Yi1xViJUc4OsV0+ENDiQUujWNIuUjP222MU3vU1kDdZX8qabZO3H2lbvdg7MZIbEjsDrQWrGgLPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sncSyUexe5zNMFUb5nUY7ZAkG91Dm04gTD4fZRkeKxs+UxNy0Jumw5QzbzM+FpNoKTn+Q3VPVcBJFxX6dAVZ5eTJ8L468Ma9M/tcMainnbeCbCAAnRG5aqHuJm8XQBWB8gmS/fXboryZ82oTRf7bYQbIPBhojJnN0oUgWJTYuzs=
Received: by 10.114.131.2 with SMTP id e2mr1900573wad.1173217199336;
        Tue, 06 Mar 2007 13:39:59 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 6 Mar 2007 13:39:59 -0800 (PST)
Message-ID: <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
Date:	Tue, 6 Mar 2007 22:39:59 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	mbizon@freebox.fr
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1173112433.7093.36.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <1172879147.964.65.camel@sakura.staff.proxad.net>
	 <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com>
	 <1173112433.7093.36.camel@sakura.staff.proxad.net>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/5/07, Maxime Bizon <mbizon@freebox.fr> wrote:
> I dug a little and found the following.
>
> My kernel is loaded at 0x9012d000, '&_end' value is 0x901d4020. In
> bootmem_init(), we try to compute reserved_end by using
> __pa_symbol(&_end), which adds PHYS_OFFSET to it, though it was already
> accounted.
>

I think you missed PAGE_OFFSET meaning...

PAGE_OFFSET is the start of the kernel virtual address space and
before this patchset pa(PAGE_OFFSET) was always 0.

In your case, you said:

        PAGE_OFFSET = 0x80000000
        PHYS_OFFSET = 0x10000000

this means that the first kernel virtual address is 0x80000000 and the
corresponding physical address is 0x10000000. If you load your kernel
at 0x9000xxxx, it will be loaded in physical memory located at
0x2000xxxx which is obviously not what you want.

So to fix this you have 2 possibilities:

    - load your kernel at 0x8000xxxx addresses,
    - set PAGE_OFFSET to 0x90000000.

You said that you already tried the second solution but it fails. I
don't see why though...

> The loop in setup.c is thus unable to compute a correct 'map_start'
> value since 'reserved_end' is way above all declared memory.
>
> init_bootmem_node() is then called with a 'map_start' default value of
> ~0. Maybe that case should fall in the invalid memory map panic ?
>

well maybe some sanity checkings are missing here.

Sorry for responding lately but life sometimes triggers NMIs ;)
-- 
               Franck
