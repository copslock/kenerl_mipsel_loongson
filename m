Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 15:33:44 +0100 (CET)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:44724 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013036AbbBIOdnHQpNb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 15:33:43 +0100
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id qEZB1p0092JGN3p01EZb07; Mon, 09 Feb 2015 14:33:35 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-10v.sys.comcast.net with comcast
        id qEZb1p0011duFqV01EZb3Q; Mon, 09 Feb 2015 14:33:35 +0000
Message-ID: <54D8C53C.6020708@gentoo.org>
Date:   Mon, 09 Feb 2015 09:33:32 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: BUG() in mm/vmscan.c, isolate_lru_pages [was: Random hard
 locks after ~16hrs uptime]
References: <54D6D0D5.8020704@gentoo.org> <alpine.LFD.2.11.1502081003060.22715@eddie.linux-mips.org> <54D80515.3040208@gentoo.org> <54D874BF.3040003@gentoo.org>
In-Reply-To: <54D874BF.3040003@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1423492415;
        bh=akPrEReXMeNoIYaoCoUc1jzZCdoraB1+8Mi8YWnIOxg=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=FCIG+TP79e0UA/QlPixWk59b70ZMGETYzeWXR9iyMkvY8oqwcpbYcQ+YPz1XR2mf8
         w126WFs15qN9h+PETTDPhbNTrmwM2QT6H+mCWl3wG9TEBFav7HiPn5DbzkdH35s4AW
         ITSGk/ZidgRIj14V08FH71Bm/F3gkQDZJ4aAu3i8jkmVGTQLy+2080Nt/Bt/vSXMpl
         1G431k8KLEOyuCTZklbY+uMAe51FXuHOTIOX8YCpQ1XAnlhMYQZCYUQ8VBC9cyOmOM
         ZXa5WkaxsqaIRZXe5sgppmYhBYplwISSPTbJ3ZHdeEGDeG28oJzEa87qHkb0+6bwtR
         rlUcnYdaoufJA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45781
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

On 02/09/2015 03:50, Joshua Kinard wrote:
> On 02/08/2015 19:53, Joshua Kinard wrote:
>> On 02/08/2015 07:06, Maciej W. Rozycki wrote:
>>> On Sat, 7 Feb 2015, Joshua Kinard wrote:
>>>
>>>> I've had my Onyx2 running quite a bit lately doing compile runs, and it seems
>>>> that after about ~16 hours, there's a random possibility that the machine just
>>>> completely stops.  No errors printed anywhere, serial becomes completely
>>>> unresponsive.  I have to issue a 'rst' from the MSC to bring it back up again.
>>>
>>>  If the time spent up is always similar, then one possibility is a counter 
>>> wraparound or suchlike that is not handled correctly (i.e. the carry from 
>>> the topmost bit is not taken into account), causing a kernel deadlock.
>>
>> I believe I've pinned the problem down to the block I/O layer and points
>> beneath, such as SCSI core, qla1280, etc.  I am using an out-of-tree patch to
>> add the BFQ I/O scheduler in, so that may also be a cause to consider.
>>
>> I had a very similar hardlock on the Octane, too, when I upgraded the RAM to
>> 3.5GB the other day, but going back to 2GB solves the problem there.  Octane
>> is, for all intents and purposes, a single-node Origin system w/ graphics
>> options, HEART instead of HUB, and a much more simplified PROM).  Both use the
>> same SCSI chip, a QLogic ISP1040B, and thus the same driver, qla1280.o.  The
>> difference with the Octane is I can reproduce the hardlock on demand by
>> untarring a large tarball (a Gentoo stage3, to be exact).  Compared to the
>> Onyx2, which has 8GB of RAM, and the lock seems more random.
>>
>> I'll have to reconfigure the Octane later on with 3.5GB of RAM again, but test
>> BFQ, CFQ, and Deadline out to see if the hardlock happens with all three.  I
>> know BFQ is largely derived from the CFQ code, so if the system remains stable
>> with Deadline, but not CFQ or BFQ, then I know the subsystem.  Then, if it only
>> happens on BFQ, I'll go pester their upstream for debugging advice.
> 
> For the Octane, it looks like it's something with the scheduler.  If I use
> "No-op", the machine can unpack a stage3 just fine.  If I use Deadline or CFQ,
> it dies.  I did get several oopses under both, but they're not specific to
> Octane or MIPS code, and the Oops output doesn't always trigger with each
> attempt.  Several were actually "Reserved instruction in kernel code", but the
> failing instruction was an "sw", which should work fine.  Other weird one was
> "do_cpu invoked from kernel context!" -- new to me.  Saved all of them in case
> anyone is interested in it.
> 
> I'll have to test this on the Onyx2 later to see if similar results
> happen there.  That way, I'll know that I am chasing the same bug down.

No, I think I am looking at two different bugs here.  They just happen to share
similar triggers and exhibit similar symptoms.

Octane, the bug happens when I use two high-density memory modules (very
rare).  I'll have to find my IRIX disk and run diags on the modules to
eliminate them being plain faulty.  I can still crash the machine with just
those two installed...oddly enough, though, only when using a scheduler other
than no-op.  Have to dig further into that...

For the Onyx2, I was able to use bonnie++ to trigger the oops, and it seems
I've tripped up a BUG() in mm/vmscan.c:

command line:
# bonnie++ -d /usr/space/bonnie/ -s 16g -f -b -u root

[  741.690000] Kernel bug detected[#1]:
[  741.690000] CPU: 2 PID: 42 Comm: kswapd1 Not tainted 3.19.0-rc7-mipsgit-20150207 #7
[  741.690000] task: a8000000ffff0008 ti: a8000000ff524000 task.ti: a8000000ff524000
[  741.690000] $ 0   : 0000000000000000 ffffffff94001ce0 0000000000000000 0000000000000000
[  741.690000] $ 4   : a800000002957d40 0000000000000000 a8000000ff527b00 a8000000ff527b38
[  741.690000] $ 8   : 0000000000000000 0000000000000020 000000000000039b 0000000000000003
[  741.690000] $12   : fffffffffffffff8 0000000000100000 0000000000000000 0000000000000000
[  741.690000] $16   : 0000000000000000 0000000000000020 0000000000000000 a8000000ff527b00
[  741.690000] $20   : fffffffffffffff0 a8000000ffc9d800 0000000000000002 a800000002957d60
[  741.690000] $24   : 0000000000000000 a800000000083140
[  741.690000] $28   : a8000000ff524000 a8000000ff527a90 a8000000ffc9d820 a8000000000f68d0
[  741.690000] Hi    : 0000000000000000
[  741.690000] Lo    : 0000000000000000
[  741.690000] epc   : a8000000000f69b0 isolate_lru_pages.isra.27+0x170/0x188
[  741.690000]     Not tainted
[  741.690000] ra    : a8000000000f68d0 isolate_lru_pages.isra.27+0x90/0x188
[  741.690000] Status: 94001ce2 KX SX UX KERNEL EXL
[  741.690000] Cause : 00008024
[  741.690000] PrId  : 00000f14 (R14000)
[  741.690000] Process kswapd1 (pid: 42, threadinfo=a8000000ff524000, task=a8000000ffff0008, tls=0000000000000000)
[  741.690000] Stack : 0000000000000000 a8000000ff527b38 a800000100025000 a8000000ff527d30
          0000000000000002 a8000000ffc9d800 0000000000000000 0000000000000020
          0000000000000001 a800000100025600 0000000000000000 a8000000000f8868
          a8000000ff527b10 0000000000000000 a8000000ff527b00 a8000000ff527b00
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 a8000000050332f0 0000000000000001 a8000000ffeb1760
          a8000000ffc9d800 a8000000ff527d30 a8000000ff527c08 0000000000000002
          0000000000000001 0000000000000020 0000000000000003 0000000000000004
          0000000000000000 a8000000000f8ff8 a8000000ff527ba0 a8000000ff527ba0
          a8000000ff527bb0 a8000000ff527bb0 a8000000ff527bc0 a8000000ff527bc0
          ...
[  741.690000] Call Trace:
[  741.690000] [<a8000000000f69b0>] isolate_lru_pages.isra.27+0x170/0x188
[  741.690000] [<a8000000000f8868>] shrink_inactive_list+0xf0/0x638
[  741.690000] [<a8000000000f8ff8>] shrink_lruvec+0x248/0x718
[  744.230000] [<a8000000000f956c>] shrink_zone+0xa4/0x2c8
[  744.230000] [<a8000000000f9e54>] kswapd+0x6c4/0xab0
[  744.230000] [<a80000000006f16c>] kthread+0x10c/0x128
[  744.230000] [<a800000000025b88>] ret_from_kernel_thread+0x14/0x1c
[  744.230000]
[  744.230000]
Code: 0803da48  ffd70000  00000000 <000c000d> 00000000  0000802d  0803da4f  ffa00000  00000000
[  744.660000] ---[ end trace 2796f87304e1e281 ]---
[  744.660000] Fatal exception: panic in 5 seconds
[  744.660000] sched: RT throttling activated
[  749.670000] Kernel panic - not syncing: Fatal exception
[  749.730000] ---[ end Kernel panic - not syncing: Fatal exception


'isolate_lru_pages.isra.27' seems to be where GCC optimized 'isolate_lru_pages'
with -fipa-sra:

a8000000000f6840 <isolate_lru_pages.isra.27>:
 * @mode:       One of the LRU isolation modes
 * @lru:        LRU list id for isolating
 *
 * returns how many pages were moved onto *@dst.
 */
static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
a8000000000f6840:       67bdffa0        daddiu  sp,sp,-96
a8000000000f6844:       ffb60040        sd      s6,64(sp)
a8000000000f6848:       0120b02d        move    s6,a5
                struct lruvec *lruvec, struct list_head *dst,
                unsigned long *nr_scanned, struct scan_control *sc,
                isolate_mode_t mode, enum lru_list lru)
{

[snip]

                switch (__isolate_lru_page(page, mode)) {
a8000000000f68c8:       0c03d9ba        jal     a8000000000f66e8 <__isolate_lru_page>
a8000000000f68cc:       0240282d        move    a1,s2
a8000000000f68d0:       1054002b        beq     v0,s4,a8000000000f6980 <isolate_lru_pages.isra.27+0x140>
a8000000000f68d4:       00000000        nop
a8000000000f68d8:       14400035        bnez    v0,a8000000000f69b0 <isolate_lru_pages.isra.27+0x170>
    ^^^^^^^^^^ +0x90, or $ra, the "default" case in this switch block.

[snip]

static inline void __noreturn BUG(void)
{
        __asm__ __volatile__("break %0" : : "i" (BRK_BUG));
a8000000000f69b0:       000c000d        break   0xc
    ^^^^^^^^^^ +0x1a0, or $epc, BUG()


So I did trip up a kernel bug.  But I have no idea *why* it tripped.  All 8GB
of memory in the Onyx2 should be fine -- I ran heavy diags on it from PROM (not
from IRIX though) and all of the memory passed.

It seems that by rebooting the machine after every compile run and using a
ramdisk, I can avoid triggering the flaw for now.  At least, I hope it's the
same flaw.  The hardlocks never dumped oops information.  But the triggers seem
the same, so I am hoping this is it.

Ideas?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
