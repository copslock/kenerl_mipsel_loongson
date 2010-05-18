Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2010 12:38:25 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46615 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491138Ab0ERKiV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 May 2010 12:38:21 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4IAcJq1002872;
        Tue, 18 May 2010 11:38:20 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4IAcIeX002870;
        Tue, 18 May 2010 11:38:18 +0100
Date:   Tue, 18 May 2010 11:38:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [Bug report] Got bus error when loading kernel module on SB1250
 Rev B2 board with 64 bit kernel
Message-ID: <20100518103818.GA31874@linux-mips.org>
References: <4BED25F3.4010809@windriver.com>
 <20100514180211.GB32203@linux-mips.org>
 <4BF0B08F.1010305@windriver.com>
 <4BF2083B.4000303@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF2083B.4000303@windriver.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2010 at 11:23:39AM +0800, Yang Shi wrote:

> It seems CPU_PREFETCH caused this issue. See commit:
> 
> commit 6b4caed2ebff4ee232f227d62eb3180d0b558a31

Is this a commit ID of a Wind River tree?  The commit ID for the kernel.org
kernel tree is 634286f127bef8799cd04799d3e1d5471e8fd91c, for the lmo tree
e3bf818d95cb372bfe78696957586d9afff0b405.

> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed Jan 28 17:48:40 2009 +0000
> 
>    MIPS: IP27: Switch from DMA_IP27 to DMA_COHERENT
>    commit 0d356eaa6316cbb3e89b4607de20b2f2d0ceda25 from linux-mips
>    The special IP27 DMA code selected by DMA_IP27 has been removed a while
>    ago turning DMA_IP27 into almost a nop.  Also fixup the broken logic of
>    its last users memcpy.S and memcpy-inatomic.s.
>    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> If undef CPU_PREFETCH for SB1250, module can be loaded correctly.

[...]

> This patch did below fix:
>
> -#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
> +#ifdef CONFIG_DMA_NONCOHERENT
> #undef CONFIG_CPU_HAS_PREFETCH
>
> Before the fix, CONFIG_DMA_IP27 is undefined for all of boards except
> IP27, so CONFIG_CPU_HAS_PREFETCH is undefined always.

That's an old issue striking here then.  Memcpy will prefetch beyond the
end of the source or destination area, if the use of prefetch is enabled.

On non-coherent systems this is a problem because these prefetches might
bring back data that was just flushed from the cache back into the cache
resulting in corrupted DMA transfers.

Some systems that do very tight checking of address but do not differenciate
between actual loads / stores and prefetch accesses may also also throw
address error exceptions when prefetching from non-decoded address ranges.
That would typically be just beyond the end of a RAM range.  For those
systems the solution is to either disable prefetching or to not use the
last page of every physically contiguous area of memory.

I'm still looking at why we this wasn't triggered earlier.  Something else
must have changed to suddenly trigger this issue - and your system seems
to be the only system affected.

  Ralf
