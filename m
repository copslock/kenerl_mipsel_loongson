Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 08:04:20 +0100 (CET)
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:46587 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012946AbaKJHETBV4iT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 08:04:19 +0100
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-04v.sys.comcast.net with comcast
        id Dj4C1p00252QWKC01j4C9L; Mon, 10 Nov 2014 07:04:12 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-09v.sys.comcast.net with comcast
        id Dj4B1p0010gJalY01j4Bld; Mon, 10 Nov 2014 07:04:12 +0000
Message-ID: <5460636A.5090401@gentoo.org>
Date:   Mon, 10 Nov 2014 02:04:10 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com> <545EB09C.40006@gentoo.org>
In-Reply-To: <545EB09C.40006@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415603052;
        bh=DlnKe3ZrK7toU7paP1jMpzO70vg6czZWGk2+mjK6GCo=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=n0NiU1tWAdR0CzXnDOao71olyL9Cr5LVGX5WfHtWoQ0tTQQtU4p4XrQ+Oi/qjxxJ/
         xztFUsBmhou2vVnliDDadLJjO2NnrKUUGFaModjcPEAFghqAwBIjpviD0WTCHSMoHl
         OqVZA542i/nJABpWRYH0WNkKhj7NNPxvMUItows4/LBFCBRokubj4+sWXD5J+lh4AS
         y9w1RnPt8dBm4Cq1gI6BtIPbhQDLZ7PX4NdGvs1fRjLckjay53/mKxjlT7kKL+Ox6M
         747EUa6LOVw6ZSeGOoErbN334n8wYWLi9+RANZBsWE6eTCBpphj2cC4oWvcY1n8+df
         jJXETaQcvYUKg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43940
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

On 11/08/2014 19:09, Joshua Kinard wrote:
> On 11/07/2014 13:30, David Daney wrote:
>> On 11/07/2014 02:22 AM, Joshua Kinard wrote:
>> [...]
>>>
>>> So my guess is unless hugepages can happen in powers of 4,
>>
>> Huge  pages are currently only supported on MIPS64 for this reason.
>>
>> huge_page_mask_size = (normal_page_size/8 * normal_page_size) / 2;
>>
>> If you take log2 of everything you get
>>
>> huge_page_mask_bits = normal_page_bits - 3 + normal_page_bits - 1
>>   = 2 * normal_page_bits - 4 (always even)
>>
>> So all page sizes result in huge pages that meet the power of 4 criterion.
> 
> Well, looks like I'll have to bisect to hunt the problem down.  Obviously there
> is something with transparent hugepages that the R10K-family dislikes.  Just a
> question of "what?".  Seems like I'm the only one left with this kind of
> equipment and interest to play with it :)

I gave up on bisecting this.  3.7 and 3.9 kernels are not bootable on my Onyx2
w/o additional patches to fix the PCI probing code to deal with the card cage I
have in my system (basically, it stops probing after it discovers the first PCI
bus).  Even with that fixed, normal init refused to load on those kernels, and
dash as init just outright crashed.  Must be some other IP27 bug that was fixed
at some point, and I didn't feel like applying multiple patches to every bisect
checkout, which might've altered results and led me to blaming the wrong commit.

It does look like the PageMask register is getting set to the correct values on
PAGE_SIZE_4K and PAGE_SIZE_16K when a hugepage is needed (PM_1M and PM_16M).
The PAGE_SIZE_64K case wouldn't be valid on R10k, as that uses PM_256M for a
hugepage, which is bits 28:13 in PageMask and that would lead to "undefined
behavior".  I'm assuming another register is getting set to an incorrect value
in the huge pagecase (EntryLo0 or EntryLo1?  EntryHi?), but I don't have the
required knowledge to fiddle w/ the TLB code to figure it out.

So, I sent in the patch that marks CPU_SUPPORTS_HUGEPAGES as BROKEN until
someone feels like tackling it (if ever).

Sidenote: Is it possible to add additional CP0 registers to a register dump on
a panic or oops?  I looked around ptrace.c and ptrace.h and see where these
registers are setup and printed out, but I can't find out where the actual
values are fetched from the CPU and put into struct pt_regs.  I am assuming
it's a snippet of asm somewhere.  Adding R10K's PageMask, Config, ErrorEpc, And
Context/XContext registers seems like useful debugging info.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
