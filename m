Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 03:59:29 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:43244 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225984AbUENC71>;
	Fri, 14 May 2004 03:59:27 +0100
Received: (qmail 15098 invoked from network); 14 May 2004 02:47:25 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.188)
  by mail.ict.ac.cn with SMTP; 14 May 2004 02:47:25 -0000
Message-ID: <40A43601.70307@ict.ac.cn>
Date: Fri, 14 May 2004 10:59:13 +0800
From: wuming <wuming@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B1@server1.RightHand.righthandtech.com>
In-Reply-To: <B482D8AA59BF244F99AFE7520D74BF9609D4B1@server1.RightHand.righthandtech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <wuming@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuming@ict.ac.cn
Precedence: bulk
X-list: linux-mips

>
>
>I am having a similar problem with 2.4.26 on an NEC VR5500 with a 32k
>2-way cache.  This is with a 32 bit little-endian kernel, and an ext2
>filesystem on an ide hard drive in pio mode.
>
>Removing just the check for PG_dcache_dirty fixes the problem for me.
>
>Along the way, I found a bogus check for cache aliases in c-r4k.c.  In
>the ld_mmu_r4xx0 function, it has the check:
>    if (c->dcache.sets * c->dcache.ways > PAGE_SIZE)
>which will never work for a 32k cache.
>
>Bob Breuer
>
>
>
>  
>
I have understood the phenomenon, and I think this is a kernel's bug.
The real wrong place is not the judgement for condition "PG_dcache_dirty"
in function __update_cache( ).
in file mm/filemap.c and function filemap_nopage( ):
......
success:
        /*
         * Try read-ahead for sequential areas.
         */
        if (VM_SequentialReadHint(area))
                nopage_sequential_readahead(area, pgoff, size);
                                                                               
        /*
         * Found the page and have a reference on it, need to check sharing
         * and possibly copy it over to another page..
         */
        mark_page_accessed(page);
        flush_page_to_ram(page);
        return page;
......

flush_page_to_ram( ) has not been used for a long time, and in kernel 2.4.22
"include/asm-mips/cacheflush.h"
#define flush_page_to_ram(page)         do { } while (0)

so the mapped page has not been flushed to ram, and the user space will not
know the latest data in the page.
the flush_page_to_ram( ) should be replaced by flush_dcache_page( ),
and if the flush_dcache_page( ) does not really flush the cache, it will set
the PG_dcache_dirty, and the real flush will be postponed to 
__update_cache( ).
and if there is not the flush_dcache_page( ) here, no one will set the 
PG_dcache_dirty,
and __update_cache( ) will not flush the page too, so the D-cache 
aliasing happens.

at last, when I replaced flush_page_to_ram( ) with flush_dcache_page( ),
the internal compiler error disappeared.

I hope your problem will be solved by this way too. God bless you! :-)
