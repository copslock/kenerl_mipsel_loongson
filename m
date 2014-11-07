Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 11:22:33 +0100 (CET)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:35054 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012814AbaKGKWbK3EG4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 11:22:31 +0100
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id CaNN1p0012Ka2Q501aNNWV; Fri, 07 Nov 2014 10:22:22 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id CaNM1p00N3aNLgd01aNNbl; Fri, 07 Nov 2014 10:22:22 +0000
Message-ID: <545C9D4D.4090501@gentoo.org>
Date:   Fri, 07 Nov 2014 05:22:05 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org>
In-Reply-To: <20141105160945.GB13785@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415355742;
        bh=y8U8c2CEyPewfEj3ko9Xp5AdV7yFVlwzRMnlLspQu1Y=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=kIYIrqgY9NBKKm76JpOLKALDTq3VfM1L+A205Pi5Ztl11/9Cxmmg1shR+TyQfGgad
         tC3vKrcwL1ISbMEqWV4qSwCgeVJmwzZTxbu/aJHSYVKnQa/iAAwHip1a5yYHCdD42z
         M2f7DXBnck9fkzkxGFBmTjlmcRLKg8DfgcVo5pE9UnxR8iQZTEehKI5n4St1C2tsgq
         r/WpiL9+GUJkFzXrLLId8AZu9BPjDhpDo1dy2w214gfVHEGYaj2cFKRFZG83dUhDK+
         rp7ggbPd7ET0yzxg9Ge6XQnPhCtUNttceZP1t/jVasfCQXwjaDeYtXH543VOqFipE3
         GlW2E8A7uV/Nw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 11/05/2014 11:09, Ralf Baechle wrote:
> On Mon, Nov 03, 2014 at 05:23:29PM -0800, David Daney wrote:
> 
>> I haven't checked, but there may be workarounds required in the TLB
>> management code that are not in place for the huge page case.  When the huge
>> TLB code was developed, we didn't do any testing on R10K.  Somebody should
>> dump the exception handlers and carefully look at the rest of the huge TLB
>> management code, and check to see that any required workarounds are in
>> place.
> 
> Joshua, if you happen to have R10000 errata sheets around, maybe you could
> check if there's anything suspicious?  Off the top of my head I don't recall
> any R10000 TLB erratas but the R10000 had plenty of erratas due to it's - by
> the standards of the time - high complexity.
> 
>   Ralf

All I have are errata sheets for Rev 2.3, 2.4, and 2.5 of the R10K.  Nothing
specific on the R12K, and nil for the R14K/R16K.

That said, poking through other areas of the R10K/R12K User Manual, there are
paragraphs titled "Errata" and regarding the PageMask register or TLB, they
state this:

Page 41
The calculated address is translated from a 44-bit virtual address into a
40-bit physical address using a translation-lookaside buffer. The TLB contains
64 entries, each of which can translate two pages. Each entry can select a page
size ranging from 4 Kbytes to 16 Mbytes, inclusive, in __powers__ of 4, as
shown in Figure 1-6.

Page 316:
Translated virtual addresses retrieve data in blocks, which are called pages.
In the R10000 processor, the size of each page may be selected from a range
that runs from 4 Kbytes to 16 Mbytes inclusive, __in_powers_of_4__ (that is, 4
Kbytes, 16 Kbytes, 64 Kbytes, etc.).

So my guess is unless hugepages can happen in powers of 4, they're not
compatible w/ the R10K-series (and likely not the R5K/RM7K, either, since they
all have the same 24:13 bits in the PageMask register).  It seems the logical
choice would be to remove 'select CPU_SUPPORTS_HUGEPAGES' from CPU_R5000,
CPU_NEVADA, CPU_R10000, and CPU_RM7000 in arch/mips/Kconfig.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
