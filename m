Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 12:22:20 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:51689 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaKJLWSRFYGn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 12:22:18 +0100
Received: from resomta-ch2-15v.sys.comcast.net ([69.252.207.111])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id DnMz1p0042Qkjl901nNCTx; Mon, 10 Nov 2014 11:22:12 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-15v.sys.comcast.net with comcast
        id DnNA1p00E0gJalY01nNBy7; Mon, 10 Nov 2014 11:22:12 +0000
Message-ID: <54609FE2.3050606@gentoo.org>
Date:   Mon, 10 Nov 2014 06:22:10 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com> <545EB09C.40006@gentoo.org> <5460636A.5090401@gentoo.org> <20141110105106.GA4302@linux-mips.org>
In-Reply-To: <20141110105106.GA4302@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415618532;
        bh=+lmw1tkg5HrVkAAI31k1oE6hbAJAq8dQeDbzm+Un3HU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=uruxLD7nKwRiLqwIjXbv8rfgyS6bNn6pvFq/dbVq7N5oz4sDLdcSuO0NY4FlIqP/F
         3VlQEnSRmf9Zwv7itNc3uUw64IeG2WUWPUuIxcDS4ZjM2iT76gJu9bMzZBe6JpGuDk
         f71DoIk3TQlCt1fiiooiz9gpkk9pBnE7gyb/PrW4LNJ+nmnJJ2kYmDUVCPAaLv7Ipq
         VIrPlzFRzuCOkIsCk/giXX25SvYryuP4jhaSQJhuv8mhxrTePN4Ge1z4B4BYV9wVar
         4lI+vRCHQwjwEteUUCThwvoGG8f/t1hxfgLTphWfWNge0LOWCaLeGTdhybbJYjgO25
         LMeAgpIr9AOTw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43945
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

On 11/10/2014 05:51, Ralf Baechle wrote:
> Thomas,
> 
> can you test CONFIG_TRANSPARENT_HUGEPAGE on an IP28?
> 
> All in all the R10000's TLB is unproblematic; my gut feeling is that
> rather something else specific to IP27 is spoiling the broth.
> 
>   Ralf

I don't know if it's specific to IP27.  I have problems on the Octane w/ an
R14000 and CONFIG_TRANSPARENT_HUGEPAGE (instruction bus errors, needs cold
reboot to clear).  I didn't have the same issues w/ the R12000 CPU module
installed, but I did not test things as thoroughly the last time I installed
it.  I'll see about swapping the R12K module back in tonight or tomorrow and
doing the same tests as on the IP27 that can trigger problems.

--J


> On Mon, Nov 10, 2014 at 02:04:10AM -0500, Joshua Kinard wrote:
>> Date:   Mon, 10 Nov 2014 02:04:10 -0500
>> From: Joshua Kinard <kumba@gentoo.org>
>> To: David Daney <ddaney.cavm@gmail.com>
>> CC: Ralf Baechle <ralf@linux-mips.org>, Linux MIPS List
>>  <linux-mips@linux-mips.org>
>> Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
>> Content-Type: text/plain; charset=windows-1252
>>
>> On 11/08/2014 19:09, Joshua Kinard wrote:
>>> On 11/07/2014 13:30, David Daney wrote:
>>>> On 11/07/2014 02:22 AM, Joshua Kinard wrote:
>>>> [...]
>>>>>
>>>>> So my guess is unless hugepages can happen in powers of 4,
>>>>
>>>> Huge  pages are currently only supported on MIPS64 for this reason.
>>>>
>>>> huge_page_mask_size = (normal_page_size/8 * normal_page_size) / 2;
>>>>
>>>> If you take log2 of everything you get
>>>>
>>>> huge_page_mask_bits = normal_page_bits - 3 + normal_page_bits - 1
>>>>   = 2 * normal_page_bits - 4 (always even)
>>>>
>>>> So all page sizes result in huge pages that meet the power of 4 criterion.
>>>
>>> Well, looks like I'll have to bisect to hunt the problem down.  Obviously there
>>> is something with transparent hugepages that the R10K-family dislikes.  Just a
>>> question of "what?".  Seems like I'm the only one left with this kind of
>>> equipment and interest to play with it :)
>>
>> I gave up on bisecting this.  3.7 and 3.9 kernels are not bootable on my Onyx2
>> w/o additional patches to fix the PCI probing code to deal with the card cage I
>> have in my system (basically, it stops probing after it discovers the first PCI
>> bus).  Even with that fixed, normal init refused to load on those kernels, and
>> dash as init just outright crashed.  Must be some other IP27 bug that was fixed
>> at some point, and I didn't feel like applying multiple patches to every bisect
>> checkout, which might've altered results and led me to blaming the wrong commit.
>>
>> It does look like the PageMask register is getting set to the correct values on
>> PAGE_SIZE_4K and PAGE_SIZE_16K when a hugepage is needed (PM_1M and PM_16M).
>> The PAGE_SIZE_64K case wouldn't be valid on R10k, as that uses PM_256M for a
>> hugepage, which is bits 28:13 in PageMask and that would lead to "undefined
>> behavior".  I'm assuming another register is getting set to an incorrect value
>> in the huge pagecase (EntryLo0 or EntryLo1?  EntryHi?), but I don't have the
>> required knowledge to fiddle w/ the TLB code to figure it out.
>>
>> So, I sent in the patch that marks CPU_SUPPORTS_HUGEPAGES as BROKEN until
>> someone feels like tackling it (if ever).
>>
>> Sidenote: Is it possible to add additional CP0 registers to a register dump on
>> a panic or oops?  I looked around ptrace.c and ptrace.h and see where these
>> registers are setup and printed out, but I can't find out where the actual
>> values are fetched from the CPU and put into struct pt_regs.  I am assuming
>> it's a snippet of asm somewhere.  Adding R10K's PageMask, Config, ErrorEpc, And
>> Context/XContext registers seems like useful debugging info.
