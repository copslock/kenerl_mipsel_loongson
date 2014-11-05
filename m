Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 10:09:46 +0100 (CET)
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:36467 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012642AbaKEJJmedUi0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Nov 2014 10:09:42 +0100
Received: from resomta-po-07v.sys.comcast.net ([96.114.154.231])
        by resqmta-po-10v.sys.comcast.net with comcast
        id Bl9b1p0014zp9eg01l9bzF; Wed, 05 Nov 2014 09:09:35 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-po-07v.sys.comcast.net with comcast
        id Bl7Z1p00C3aNLgd01l7aMF; Wed, 05 Nov 2014 09:07:35 +0000
Message-ID: <5459E8CC.6040205@gentoo.org>
Date:   Wed, 05 Nov 2014 04:07:24 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com>
In-Reply-To: <54582A91.8040401@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415178575;
        bh=Qr9ViEL2/TVhU40TTeGGZBIr59EY1fgbNAhXTUermJs=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=mcncN00H3xwQb7KAouCFeKlpr/GKarZmADgIzo0W8JMMQ2Sg+jDPkm+s4YT24iXaa
         t6VaNKDSyyRaFwREC6SGOMQXjPjTGSRBMbeqL7xJxRS999LXpp3bSydAYLiKSWSMK7
         gAgzkv/fnBfhcVba+uHOzcG7Hh7q9K+jjrQ6MsX6wrWxBZB45SBnvH192kzoJO2LiW
         7Zyphv6j/CsrDu4b9xhsSSJx9oK3TNM4Lxw1Zz3vriIBIGhIuDB3vDxdVe9DyszY1U
         XWkQ0FSTQWsKjoob2cdrthlHThdWsanIpagVPcvZpwVgb1wjjshxifQ6Bcjmj1OhRS
         DpGoIKqfTB23Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43873
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

On 11/03/2014 20:23, David Daney wrote:
> On 11/03/2014 05:08 PM, Joshua Kinard wrote:
>> On 11/03/2014 13:52, David Daney wrote:
>>> On 11/02/2014 02:53 AM, Joshua Kinard wrote:
>>>>
>>>> So I have been testing the Onyx2 I have out the last few days with the IOC3
>>>> metadriver used on Octane, and I can get it to boot, but if
>>>> CONFIG_TRANSPARENT_HUGEPAGE is enabled in the kernel, bus errors can happen.
>>>>
>>>> If I use CONFIG_PAGE_SIZE_4KB, I get bus errors rather frequently -- running
>>>> Gentoo's 'emerge' command  can produce one.  Switch to CONFIG_PAGE_SIZE_16KB,
>>>> and the bus errors are far less frequent.  I suspect CONFIG_PAGE_SIZE_64KB
>>>> will
>>>> be even less.
>>>>
>>>> Disable CONFIG_TRANSPARENT_HUGEPAGE, and the machine works pretty good.  It's
>>>> been up for almost 8 hours compiling, and not a single bus error yet.  It's
>>>> got
>>>> 2x node board with dual R12K/400MHz CPUs per node.
>>>>
>>>> I'm not really sure what CONFIG_TRANSPARENT_HUGEPAGE is enabling that's
>>>> causing
>>>> R12K CPUs on the IP27 such a headache (and on Octane, really screws up R14K
>>>> CPUs).  I tried getting a core dump on one of the bus errors, but that
>>>> produces a
>>>> truncated or corrupted core file that actually crashed GDB, plus I get a nice
>>>> oops message in dmesg:
>>>
>>> Well, as its name implies, if you enable CONFIG_TRANSPARENT_HUGEPAGE, huge
>>> pages will be created and used in the background transparently to the userspace
>>> application.
>>>
>>> With 4KB base page size, the huge pages will be 2MB in size..  I don't know
>>> much about the R10K/R12K/R14K CPUs, but it is possible that either their TLBs
>>> cannot handle such pages, or that the TLB Exception handlers don't contain
>>> proper code for these CPUs.
>>>
>>> For each doubling of the base PAGE_SIZE, the huge page size will increase by a
>>> factor of 4.  So with 16KB base pages the huge page size would be 32MB, since
>>> there are many fewer opportunities to transparently use a 32MB page, I would
>>> expect any errors related to huge pages to be correspondingly less frequent.
>>>
>>> With 64KB PAGE_SIZE the huge page size is 512MB, and It is likely that that
>>> could never be used by normal userspace programs.
>>
>> I checked the R10K/R12K manual, and the PageMask register there has bits 24:13
>> open for setting a mask value.  It looks like these CPUs only support a page
>> size from 4KB to 16MB (so a 2MB page size should work w/ transparent
>> hugepages).  I assume that the R14K on the Octane might be the same (but I
>> don't have a manual specific to the R14k, so I don't know).  All of the
>> remaining bits in that register read 0 and must have 0's written back.
>>
>> I guess I could find a way to have the kernel trigger a non-fatal oops/dump the
>> registers on a bus error and get a look at the cause register to see if that
>> sheds any light on things.  Doesn't a SIGBUS on MIPS typically mean that an
>> address wasn't aligned on a 32-bit boundary?  Or could it also mean other
>> things?
>>
>> I believe that the R10K is largely compatible with the R4K-style TLB setup, but
>> Ralf or someone else more knowledge in that area will have to verify.  Maybe
>> the R10k-family CPUs need their own TLB routines, or what currently exists
>> needs modifications?  I have not tried to understand the whole TLB thing in
>> MIPS yet, so that's a bit of voodoo to me.
> 
> I haven't checked, but there may be workarounds required in the TLB management
> code that are not in place for the huge page case.  When the huge TLB code was
> developed, we didn't do any testing on R10K.  Somebody should dump the
> exception handlers and carefully look at the rest of the huge TLB management
> code, and check to see that any required workarounds are in place.
> 
> David.

I did some digging, and it looks like Ralf added CPU_SUPPORTS_HUGEPAGES support
a few years ago to most of the CPUs:
http://marc.info/?l=git-commits-head&m=135552890201646&w=2

It was pointed out to me off list that this statement for the PageMask register
in the R10K manual may explain things:

"""TLB read and write operations use this register as either a source or a
destination; when virtual addresses are presented for translation into physical
address, the corresponding bits in the TLB identify which virtual address bits
among bits 24:13 are used in the comparison. When the Mask field is not one of
the values shown in Table 13-6, the operation of the TLB is undefined. The 0
field is reserved; it must be written as zeroes, and returns zeroes when read."""

2MB page sizes aren't explicitly listed in this table in the manual, so setting
bits 24:13 in PageMask might be leading to this "undefined behavior", which on
R12K might include the random bus errors/segfaults, and R14K triggers an IBE
that needs a cold reboot.

The only other R10K system I have is the IP28, but I haven't gotten that to
boot up in a few years.

Checking the NEC Vr-Series programming manual and the PMC-Sierra RM7000 manual,
at least the R5000 and RM7000 also carry this restriction because they have the
same bits defined in PageMask.

My O2 w/ RM7K is out of commission at the moment, so I can't test for that.
Anyone got an R5K/R5200/RM7K O2/Indy/I2 and can check that CPU?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
