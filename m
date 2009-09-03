Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 16:32:23 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:56477 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492761AbZICOcR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2009 16:32:17 +0200
Received: by fxm20 with SMTP id 20so1683155fxm.0
        for <multiple recipients>; Thu, 03 Sep 2009 07:32:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=by8DackXTq6qUg8fh4aBGS8T7nzGF9vn2QxcMM7c1J0=;
        b=SgvZP8T3jq44GIvDkkJkBohSJWZE6InU+dOhojzdIh1zUX5/KFzV7ZpQeUqXv7hiNG
         bWACWRj4+R1OezZA8DbmxyCrek5+S4RRl3qzNXFfjPHvuiHYFkScK/DQZbeyZPSTtm8t
         Sc20Ao+O/9sUg+xjgAL7rcMmJcK2SEk/n/Bvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NkBommUmKREGVPZSMgdeUzttGpFj9LxIKdAM1MVFC+cV4qJTkCJEvthz+qxbTMvAiK
         QLmWhIkUOOeGCk2/neOrswk2ReKDisuv25h5S88F9ytv5x2wmyhCuTAD0VjDKrlNyfRv
         mkKBmtpxntKfa2OZSfc91n8tVC/ElfRRV6vbw=
Received: by 10.204.29.22 with SMTP id o22mr8017326bkc.78.1251988330055;
        Thu, 03 Sep 2009 07:32:10 -0700 (PDT)
Received: from desktop ([58.31.9.46])
        by mx.google.com with ESMTPS id 22sm2012165fkq.23.2009.09.03.07.32.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Sep 2009 07:32:09 -0700 (PDT)
Date:	Thu, 3 Sep 2009 22:32:02 +0800
From:	Wu Fei <at.wufei@gmail.com>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Shrink the size of tlb handler and fix vmalloc()
Message-ID: <20090903143202.GC6482@desktop>
References: <20090903142753.GA6482@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090903142753.GA6482@desktop>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <at.wufei@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: at.wufei@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 03, 2009 at 10:27:53PM +0800, Wu Fei wrote:
> This patch tries to shrink the size of the 64bit tlb handler and also fix
> an vmalloc bug at the same time.
> 
Forgot to say, it's only tested on 2.6.27, not the master, I can't get
the environment to run the latest kernel currently.

Thanks,
Wufei.

> By combining the swapper_pg_dir and module_pg_dir, several checks in tlb
> handler, particularly build_get_pgd_vmalloc64, are not necessary. The reason
> they can be combined is that, the effective virtual address of vmalloc returned
> is at the bottom, and of module_alloc returned is at the top.
> 
> In the normal case of 4KB page size:
>   VMALLOC_START, VMALLOC_END	0xc0000000 00000000 - 0xc0000100 00000000
>   MODULE_START,  MODULE_END	0xffffffff c0000000 - 0xffffffff +xxxxxxx
> Change it to:
>   VMALLOC_START, VMALLOC_END	0xc0000000 00000000 - 0xc00000ff 00000000
>   MODULE_START,  MODULE_END	0xffffffff c0000000 - 0xffffffff +xxxxxxx
> We use the least 40 bits to traverse the page table, the change makes it still
> one-to-one mapping without more checking. "+" is in the range of [c,d,e,f], 
> so there even are big holes bewteen them.
> 
> With this patch, the tlb refill handler only contains about 28 instructions,
> instead of the original 38.
> 
> 
> And this patch also fix a bug in vmalloc, which happens when its returned
> address is not covered by the first pgd. e.g. if we do two vmallocs, the first
> returned address is 0xc0000000 00000000, and the 2nd is 0xc0000000 40000000,
> 
>   vmalloc -> __vmalloc_node -> __vmalloc_area_node -> __vmalloc_area_node
>   -> map_vm_area -> pgd_offset_k
> 
> pgd_offset_k doesn't use the address to index the pgd, just return the first one:
> 
>   #define pgd_offset_k(address) \ 
>         ((address) >= MODULE_START ? module_pg_dir : pgd_offset(&init_mm, 0UL))     
> 
> This is wrong, then the 2 addresses are mapped to the same pte. This bug doesn't
> happen because even in the 4KB page case, one pgd can cover 1GB size, and it looks
> like the system won't vmalloc so much area.
