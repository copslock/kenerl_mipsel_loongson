Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 21:44:59 +0100 (CET)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49149 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491095Ab1AXUoz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 21:44:55 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0OKiFD6032586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 24 Jan 2011 12:44:16 -0800
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id p0OKiCqw009334;
        Mon, 24 Jan 2011 12:44:13 -0800
Date:   Mon, 24 Jan 2011 12:44:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix build error when CONFIG_SWAP is not set
Message-Id: <20110124124412.69a7c814.akpm@linux-foundation.org>
In-Reply-To: <4D3DD366.8000704@mvista.com>
References: <20110124210813.ba743fc5.yuasa@linux-mips.org>
        <4D3DD366.8000704@mvista.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Mon, 24 Jan 2011 22:30:46 +0300
Sergei Shtylyov <sshtylyov@mvista.com> wrote:

> Hello.
> 
> Yoichi Yuasa wrote:
> 
> > In file included from
> > linux-2.6/arch/mips/include/asm/tlb.h:21,
> >                  from mm/pgtable-generic.c:9:
> > include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
> > include/asm-generic/tlb.h:76: error: implicit declaration of function
> > 'release_pages'
> > include/asm-generic/tlb.h: In function 'tlb_remove_page':
> > include/asm-generic/tlb.h:105: error: implicit declaration of function
> > 'page_cache_release'
> > make[1]: *** [mm/pgtable-generic.o] Error 1
> > 
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> [...]
> 
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 4d55932..92c1be6 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/memcontrol.h>
> >  #include <linux/sched.h>
> >  #include <linux/node.h>
> > +#include <linux/pagemap.h>
> 
>     Hm, if the errors are in <asm-generic/tlb.h>, why add #include in 
> <linux/swap.h>?
> 

The build error is caused by macros which are defined in swap.h.

I worry about the effects of the patch - I don't know which of swap.h
and pagemap.h is the "innermost" header file.  There's potential for
new build errors due to strange inclusion graphs.

err, there's also this, in swap.h:

/* only sparc can not include linux/pagemap.h in this file
 * so leave page_cache_release and release_pages undeclared... */

It would be safer to convert free_page_and_swap_cache() and
free_pages_and_swap_cache() into out-of-line C functions.  Or to
explicitly include pagemap.h into the offending .c files.
