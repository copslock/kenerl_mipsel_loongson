Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 15:18:46 +0200 (CEST)
Received: from resqmta-po-12v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:171]:43178
        "EHLO resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbdJKNSdDCwyK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 15:18:33 +0200
Received: from resomta-po-20v.sys.comcast.net ([96.114.154.244])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id 2GreeDQL1nYqY2GrheKeh9; Wed, 11 Oct 2017 13:16:01 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-20v.sys.comcast.net with SMTP
        id 2Grfe1drIOhsv2GrfePtP9; Wed, 11 Oct 2017 13:16:00 +0000
Subject: Re: Question regarding atomic ops
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
References: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
 <4f77107c-18ba-d549-c5f2-d52d0460377b@gentoo.org>
 <20171010142306.GA24194@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <5b5db1f6-c00b-6b84-6d94-7776457f8678@gentoo.org>
Date:   Wed, 11 Oct 2017 09:15:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171010142306.GA24194@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGf/ROOZirKH9GZoMFtkCrWHey6BJsJKAn1R4kXUZj95A+RsaZMbsqCPcX7EUo30r0Sz/nCWHFDwNtewUnPnodxo2+PRfY+tS7D2UMdI9/Y3L4dN3dSs
 CzmDbYUQHIiIK6zVHi1UsmsUpcScWVNBi0lixjbaGak4yhD7OexlKJWdQKOCBCafRh9siz4TMhFG8yt2N+eGMTCV7e3IRWOKRNs=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60362
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

On 10/10/2017 10:23, Ralf Baechle wrote:
> On Mon, Oct 09, 2017 at 10:34:43PM -0400, Joshua Kinard wrote:
> 
>> On 10/09/2017 22:24, Joshua Kinard wrote:
>>
>> [snip]
>>
>>> This raises the question of why was the standard "kernel_uses_llsc" case
>>> changed but not the R10000_LLSC_WAR case?  The changes seem like they would be
>>> applicable to the older R10K CPUs regardless, since this is before a lot of the
>>> code for the newer ISAs (R2+) was added.  I am getting a funny feeling that a
>>> lot of these templates need to be re-written (maybe even in plain C, given
>>> newer gcc's better intelligence) and other useful cleanups done.  I am not
>>> fluent in MIPS asm enough, though, to know what to change.
>>
>> Answered one of my own questions via this buried commit from ~2006/2007 that
>> has a commit message, but no changed files:
>>
>> https://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/atomic.h?id=5999eca25c1fd4b9b9aca7833b04d10fe4bc877d
>>
>>> [MIPS] Improve branch prediction in ll/sc atomic operations.
>>> Now that finally all supported versions of binutils have functioning
>>> support for .subsection use .subsection to tweak the branch prediction
>>>
>>> I did not modify the R10000 errata variants because it seems unclear if
>>> this will invalidate the workaround which actually relies on the cheesy
>>> prediction of branch likely to cause a misspredict if the sc was
>>> successful.
>>>
>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>> Seems like that second paragraph is a ripe candidate for a comment block so
>> this is better documented :)
> 
> Btw, I reasonably certain applying the change to the R10000 LL/SC workaround
> versions as well would work.  But testing is difficult, even with hardware
> at hand - and the other option asing a R10000 RTL designer is tricky about
> 20 years later!

Okay, I'll see about playing with that file and collapsing that it down in size
somewhat by merging the standard and R10000_LLSC_WAR cases in a similar way
that arch/mips/include/asm/cmpxchg.h was done uses the '__scbeqz' macro.  I
don't have any older R10000 CPUs affected by the errata to test with, but I can
at least test the code path under R12K+ to make sure things still work.

---

For the RCU stalls, I found this tidbit of information:
o	Booting Linux using a console connection that is too slow to
	keep up with the boot-time console-message rate.  For example,
	a 115Kbaud serial console can be -way- too slow to keep up
	with boot-time message rates, and will frequently result in
	RCU CPU stall warning messages.  Especially if you have added
	debug printk()s.

From here:
https://www.kernel.org/doc/Documentation/RCU/stallwarn.txt

By default, IP27 runs at 9600bps on the serial console.  The early PROM
messages are hardcoded for that linespeed, which is why I leave it at 9600.
Under the IOC3 metadriver (and I believe even the stock serial code in
ioc3-eth.c), we're relying on a really simple (and crappy) non-IRQ polling
routine buried deep in the 8250 serial core to read the serial console state,
and so that probably adds to the problems.

Under the metadriver, the DMA-capable ioc3_serial.c driver built originally for
Altix will get detected if you build it in, but I've never been able to get any
output out of it on boot.  I think nyef tried as well in his early IP35 port
and didn't have much luck either.  Or maybe he did....I forget.  I guess that's
something to look into so we can get away from the polling mechanism once and
for all.

If that is the source of my RCU stalls, I'll have to try booting w/o serial at
all and log into the machine by ssh and see the timestamps in dmesg.  If they
stay under ~45 seconds, that should confirm things.  It'd also rule out any
other bugs elsewhere in the newer code I've written.  Which means Origin 200
should run right again.  Onyx2 + NUMA, OTOH, still has something goofy with it
as far as I know.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
