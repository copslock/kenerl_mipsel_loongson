Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 13:47:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51274 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1AXMro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 13:47:44 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0OClGtQ004919;
        Mon, 24 Jan 2011 13:47:16 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0OClFpY004917;
        Mon, 24 Jan 2011 13:47:15 +0100
Date:   Mon, 24 Jan 2011 13:47:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     COLin <colin@realtek.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 24k data cache, PIPT or VIPT?
Message-ID: <20110124124715.GB12232@linux-mips.org>
References: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 21, 2011 at 04:52:54PM +0800, COLin wrote:

> Hi all,
> I found that there is this information while Linux is booting:
>     [Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes]
> I thought the latest MIPS CPUs all use VIPT. I didn't find anything about PIPT on 24k Software User's Manual, either.
> The code related to this is here:
>         case CPU_24K:
>         case CPU_34K:
>         case CPU_74K:
>         case CPU_1004K:
>                 if ((read_c0_config7() & (1 << 16))) {
>                         /* effectively physically indexed dcache,
>                            thus no virtual aliases. */ 
>                         c->dcache.flags |= MIPS_CACHE_PINDEX;
>                         break;
> 
> The 16's bit of config 7 register:
>     [Alias removed: This bit indicates that the data cache is organized to
> avoid virtual aliasing problems. This bit is only set if the data cache
> config and MMU type would normally cause aliasing - i.e., only for
> the 32KB and larger data cache and TLB-based MMU.]
> 
> Does it imply that the CPU is using PIPT?

It means the cache will behave as if it is PIPT, that is it doesn't have
cache aliases.  It doesn't say anything about the actual implementation - it
could be anything, VIPT, PIPT or even crazy stuff.

VIPT makes sense because the lookup can start early before the address
translation has been completed.  The alias removal usually works by
detecting if an operation would result in cache aliases, that is multiple
ways containing conflicting data.  If that happens all conflicting ways
will be written back to secondary cache, invalidated and the operation
will be rerun.

Another strategy was implemented in the R4000 / R4000 SC and MC versions
where the S-cache for every primary cache line contains some virtual
address bits that are needed to detect an alias.  If that ever happens
the CPU will thrown an alias and the exception handler can cleanup the
mess.  Other architectures would do that in microcode hidden from OS
software.

From a software perspective the most preferable solution is increasing
the number of cache ways.  If cache_size / nr_of_ways <= page_size a
cache will no longer suffer from aliases.  Unfortunately hardware folks
traditionally dislike this approach.

  Ralf
