Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 08:52:52 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:23443 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225557AbUENHwv>; Fri, 14 May 2004 08:52:51 +0100
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1BOXUp-0000Ex-00; Fri, 14 May 2004 08:52:43 +0100
Message-ID: <40A47ACA.1040101@bitbox.co.uk>
Date: Fri, 14 May 2004 08:52:42 +0100
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wuming <wuming@ict.ac.cn>
CC: linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B1@server1.RightHand.righthandtech.com> <40A43601.70307@ict.ac.cn>
In-Reply-To: <40A43601.70307@ict.ac.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

wuming wrote:

> I have understood the phenomenon, and I think this is a kernel's bug.
> The real wrong place is not the judgement for condition "PG_dcache_dirty"
> in function __update_cache( ).
> in file mm/filemap.c and function filemap_nopage( ):
> ......
> success:
>        /*
>         * Try read-ahead for sequential areas.
>         */
>        if (VM_SequentialReadHint(area))
>                nopage_sequential_readahead(area, pgoff, size);
>                                                                               
>        /*
>         * Found the page and have a reference on it, need to check 
> sharing
>         * and possibly copy it over to another page..
>         */
>        mark_page_accessed(page);
>        flush_page_to_ram(page);
>        return page;
> ......
>
> flush_page_to_ram( ) has not been used for a long time, and in kernel 
> 2.4.22
> "include/asm-mips/cacheflush.h"
> #define flush_page_to_ram(page)         do { } while (0)
>
> so the mapped page has not been flushed to ram, and the user space 
> will not
> know the latest data in the page.
> the flush_page_to_ram( ) should be replaced by flush_dcache_page( ),
> and if the flush_dcache_page( ) does not really flush the cache, it 
> will set
> the PG_dcache_dirty, and the real flush will be postponed to 
> __update_cache( ).
> and if there is not the flush_dcache_page( ) here, no one will set the 
> PG_dcache_dirty,
> and __update_cache( ) will not flush the page too, so the D-cache 
> aliasing happens.
>
> at last, when I replaced flush_page_to_ram( ) with flush_dcache_page( ),
> the internal compiler error disappeared.
>
> I hope your problem will be solved by this way too. God bless you! :-)
>

This is probably just hiding your problem. flush_page_to_ram() is not 
used anymore.

P.
