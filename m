Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2014 04:22:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52266 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822968AbaGYCMMQJkkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2014 04:12:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 36E30388AAC61;
        Fri, 25 Jul 2014 03:12:04 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 25 Jul 2014 03:12:05 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 24 Jul
 2014 19:12:00 -0700
Message-ID: <53D1BCF0.3080706@imgtec.com>
Date:   Thu, 24 Jul 2014 19:12:00 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Max Filippov <jcmvbkbc@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Chris Zankel" <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>,
        Steven Hill <Steven.Hill@imgtec.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com> <20140723141721.d6a58555f124a7024d010067@linux-foundation.org> <CAMo8BfJ0zC16ssBDGUxsLNwmVOpgnyk1PjikunB9u-C7x9uaOA@mail.gmail.com> <20140724152133.bd4556f632b9cbb506b168cf@linux-foundation.org>
In-Reply-To: <20140724152133.bd4556f632b9cbb506b168cf@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 07/24/2014 03:21 PM, Andrew Morton wrote:
> On Thu, 24 Jul 2014 04:38:01 +0400 Max Filippov <jcmvbkbc@gmail.com> wrote:
>
>> On Thu, Jul 24, 2014 at 1:17 AM, Andrew Morton
>> <akpm@linux-foundation.org> wrote:
>>> Fifthly, it would be very useful to publish the performance testing
>>> results for at least one architecture so that we can determine the
>>> patchset's desirability.  And perhaps to motivate other architectures
>>> to implement this.
>> What sort of performance numbers would be relevant?
>> For xtensa this patch enables highmem use for cores with aliasing cache,
>> that is access to a gigabyte of memory (typical on KC705 FPGA board) vs.
>> only 128MBytes of low memory, which is highly desirable. But performance
>> comparison of these two configurations seems to make little sense.
>> OTOH performance comparison of highmem variants with and without
>> cache aliasing would show the quality of our cache flushing code.
> I'd assumed the patch was making cache coloring available as a
> performance tweak.  But you appear to be saying that the (high) memory
> is simply unavailable for such cores without this change.  I think.

>
> Please ensure that v3's changelog explains the full reason for the
> patch.  Assume you're talking to all-the-worlds-an-x86 dummies, OK?
>

I am not sure that I will work on it again, we move to bigger pages and 
non-aliasing cache, and I ask Steven Hill to help with MIPS variant.
So, I try to summarise an expanation here:

If cache line of some page in MIPS (and XTENSA?) is accessed via 
multiple page virtual addresses (kernel or/and user) then it may be 
located twice or more times in L1 cache which is an obvious coherency 
bug. It is a trade-off for simple L1 access hardware. Two virtual 
addresses of page which hits the same location in L1 cache are named as 
"in the same page colour". Usually, colours are numbered and sequential 
page colours looks like 0,1,0,1 or 0,1,2,3,0,1,2,3... It is usually 
least one-two-or-three bits of PFN.

One simple way to hit this problem is using current HIGHMEM remapping 
service because it doesn't take care of "page colouring". To prevent 
coherency failure a current HIGHMEM code attempts to flush page from L1 
cache each time before changing it's virtual address: flush cache each 
PKMAP recycle and at each kunmap_atomic(), see arch/arm/mm/highmem.c - 
MIPS code even doesn't have a flush here (BUG!).

However, kunmap_atomic() should do it locally to CPU without kmap_lock 
by definition of kmap_atomic() and can't prevent a situation then a 
second CPU hyper-thread accesses the same page via kmap() right after 
kmap_atomic() got a page and uses a different page colour (different 
virtual address set). Also, setting the whole cycle 
kmap_atomic()...page...access...kunmap_atomic() under kmap_lock is 
impractical.

This patch introduces some interface for architecture code to work with 
coloured pages in PKMAP array which eliminates the kmap_atomic problem 
and cancels cache flush requirements. It also can be consistent with 
kmap_coherent() code which is required for some cache aliasing 
architecture to handle aliasing between kernel virtual address and user 
virtual address. The whole idea of this patch - force the same page 
colour then page is assigned some PKMAP virtual address or kmap_atomic 
address. Page colour is set by architecture code, usually it is a 
physical address colour (which is usually == KVA colour).

- Leonid.
