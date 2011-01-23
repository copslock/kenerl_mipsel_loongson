Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2011 05:34:51 +0100 (CET)
Received: from anubis.se.axis.com ([195.60.68.12]:44770 "EHLO
        anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490947Ab1AWEes (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Jan 2011 05:34:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by anubis.se.axis.com (Postfix) with ESMTP id 10ECA19D85;
        Sun, 23 Jan 2011 05:34:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
        by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id O35syKXCGcSe; Sun, 23 Jan 2011 05:34:41 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by anubis.se.axis.com (Postfix) with ESMTP id 0471A19D7E;
        Sun, 23 Jan 2011 05:34:40 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 1F8D53E09C;
        Sun, 23 Jan 2011 05:34:40 +0100 (CET)
Received: from localhost (10.0.5.85) by smtp-x.axis.com (10.0.5.74) with
 Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 23 Jan 2011 05:34:40 +0100
Date:   Sun, 23 Jan 2011 05:34:39 +0100
From:   "Edgar E. Iglesias" <edgar.iglesias@axis.com>
To:     COLin <colin@realtek.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 24k data cache, PIPT or VIPT?
Message-ID: <20110123043439.GA20840@laped.lan>
References: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <edgar.iglesias@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@axis.com
Precedence: bulk
X-list: linux-mips

On Fri, Jan 21, 2011 at 09:52:54AM +0100, COLin wrote:
> 
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

Hi,

This line is confusing:
"This bit is only set if the data cache config and MMU type would normally cause aliasing"

because I don't know what they mean by "normally".

Anyway:
If you have a cache that is organized so that each way is
smaller or equal to the minimum MMU page size, then the cache rams
will be indexed by an offset taken from the page-offset, i.e the part
of the address that doesn't change when MMU translated.

It's a common trick to make it possible to speculatively read the
cache data and tag rams in parallel with MMU translation. Cache hit
detection is done late in the access cycle.

Because the index is unaffected by MMU translation, the VIPT cache
behaives like a PIPT cache. It avoids aliasing.

The drawback is that you have to organize the caches so that no tag
or data ram is larger than a page size.

Cheers
