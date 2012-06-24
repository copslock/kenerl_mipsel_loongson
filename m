Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2012 18:28:49 +0200 (CEST)
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:35265
        "EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902244Ab2FXQ2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jun 2012 18:28:45 +0200
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
        by qmta05.westchester.pa.mail.comcast.net with comcast
        id SFwP1j0020ldTLk55GUdWT; Sun, 24 Jun 2012 16:28:37 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta04.westchester.pa.mail.comcast.net with comcast
        id SGUb1j00j1rgsis3QGUcXc; Sun, 24 Jun 2012 16:28:36 +0000
Message-ID: <4FE74034.50502@gentoo.org>
Date:   Sun, 24 Jun 2012 12:28:36 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: booting linux-3.3 or linux 3.4 on an SGI O2?
References: <20120605190047.GA6263@alumni-linux.ccs.neu.edu> <4FCE593B.10808@cavium.com> <4FE6195F.7030505@gentoo.org> <20120624121802.GA27839@alpha.franken.de>
In-Reply-To: <20120624121802.GA27839@alpha.franken.de>
X-Enigmail-Version: 1.4.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33799
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/24/2012 8:18 AM, Thomas Bogendoerfer wrote:
> On Sat, Jun 23, 2012 at 03:30:39PM -0400, Joshua Kinard wrote:
>> On 06/05/2012 3:08 PM, David Daney wrote:
>>> On 06/05/2012 12:00 PM, Jim Faulkner wrote:
>>>> Hi all, I haven't been able to boot any kernels after linux 3.2 on my
>>>> SGI O2.  I've tried linux-3.3.5 and linux-3.4.0, but neither would boot.
>>>> Unfortunately I don't have further information such as a kernel panic,
>>>> since I don't get any video output after the kernel is loaded.  I've
>>>> attached my linux-3.4 .config.  Anybody know what patches I might need
>>>> to get the latest kernels booting on this system?
>>>>
>>>
>>> I have had problems as well.
>>>
>>> Someone should configure a serial console and early printk to see if they
>>> can see what is happening.
>>
>> Early printk on O2 systems probably has the same issues as on IP22/IP28
>> where it's overwriting PROM memory somewhere.  The system will hang very
>> early in the bootmem allocator if you kludge early printk to work on these
>> systems:
> 
> O2 is easy since it's simply a 16550 as console port chip, so no PROM
> is needed and no problems like on IP22/28.

All I know is if I add SYS_HAS_EARLY_PRINTK to config IP32 in
arch/mips/Kconfig, then enable Early Printk in menuconfig and boot the
resultant kernel, it freezes right there.  It's not CPU-model dependent,
because this same O2 used to run an R5000 @ 180MHz and had the same problems
in ~2.6.14/2.6.15.


>> CPU revision is: 00002733 (RM7000)
> 
> I guess the problem is here, iirc there was another RM7000 error report
> due to some cache code restructering or it's RM7000 O2 problem in general.
> I don't own a RM7000 cpu module for O2 ...
> 
> On my R5k O2 3.4.3 runs without problems like early 3.5 did:
> 
> mips:~# uname -a
> Linux mips.franken.de 3.4.3 #2 Sun Jun 24 14:12:05 CEST 2012 mips64 GNU/Linux
> mips:~# cat /proc/cpuinfo 
> system type		: SGI O2
> processor		: 0
> cpu model		: R5000 V2.1  FPU V1.0
> BogoMIPS		: 179.45

I got 3.4 working fine.  It was me enabling USB support (OHCI, EHCI), and
the SCSI bus probe was hanging for some reason (trying to read a thumb drive
that I plugged in, I believe).  When I disabled OHCI and kept only EHCI,
then I get an unhandled kernel unaligned access oops.  Not sure the cause of
it, but it's triggered by ffffffff802560e4 ehci_urb_done+0x24/0x100.


I've also noticed that meth is starting to suffer worse.  I get Rx
underflows like its going out of style, as well as a large number of stack
traces triggered by the interrupt handler somewhere:

kswapd0: page allocation failure: order:1, mode:0x4020
Call Trace:
[<ffffffff80016468>] dump_stack+0x8/0x38
[<ffffffff80082780>] warn_alloc_failed+0xf0/0x128
[<ffffffff8008563c>] __alloc_pages_nodemask+0x534/0x770
[<ffffffff800b0d80>] slob_new_pages.isra.12+0x18/0x70
[<ffffffff800b1168>] __kmalloc_node+0xf0/0x160
[<ffffffff802cd03c>] __alloc_skb+0x7c/0x170
[<ffffffff802973a0>] meth_interrupt+0x270/0x730
[<ffffffff800773d4>] handle_irq_event_percpu+0x7c/0x240
[<ffffffff800775d0>] handle_irq_event+0x38/0x60
[<ffffffff8007a364>] handle_level_irq+0x94/0xf0
[<ffffffff80076b04>] generic_handle_irq+0x4c/0x70
[<ffffffff80013760>] do_IRQ+0x18/0x28
[<ffffffff80004420>] ret_from_irq+0x0/0x4
[<ffffffff800b197c>] compaction_alloc+0x3a4/0x3d0
[<ffffffff800b68d8>] migrate_pages+0xb8/0x530
[<ffffffff800b1f40>] compact_zone+0x488/0x8f8
[<ffffffff800b2468>] __compact_pgdat+0xb8/0x1c0
[<ffffffff800b2808>] compact_pgdat+0x40/0x50
[<ffffffff80090318>] balance_pgdat+0x7a8/0x7c0
[<ffffffff80090438>] kswapd+0x108/0x2e8
[<ffffffff800510f0>] kthread+0x90/0x98
[<ffffffff800138c0>] kernel_thread_helper+0x10/0x18


But these don't crash the kernel, nor cause corruption in network traffic.
Seems to just be noise.  I have the box compiling gcc-4.6.3 for N32 now.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
