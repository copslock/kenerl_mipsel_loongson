Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 19:14:21 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:36003 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27036183AbcE0ROTFJmqi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 19:14:19 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-130-131-nat.elisa-mobile.fi [85.76.130.131])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 6FCB2414A;
        Fri, 27 May 2016 20:14:17 +0300 (EEST)
Date:   Fri, 27 May 2016 20:14:17 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160527171417.GC8755@raspberrypi.musicnaut.iki.fi>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
 <57473996.7030705@gmail.com>
 <20160526192330.GA17985@raspberrypi.musicnaut.iki.fi>
 <5747750E.4090000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5747750E.4090000@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Thu, May 26, 2016 at 03:13:34PM -0700, David Daney wrote:
> On 05/26/2016 12:23 PM, Aaro Koskinen wrote:
> >Yes, just tested with ER Pro using single core, and also with just "make"
> >without any parallel threads. And it failed with SIGSEGV this time:
> 
> Is it possible for you to create a root file system that substitutes
> /sbin/init with a script that does the minimal amount of system
> initialization and then runs the "make" command?
> 
> The idea being that the system without any user input of any kind would boot
> directly to the failure case.  Ideally this would be for the single CPU
> case.
> 
> With an ext2 image of that and the vmlinux file, it would be child's play to
> run in our simulator and find the cause.

OK, I have prepared such image and will send you the URL off-list.

One thing however is that you will probably need 2 GB RAM, and I think
the mainline kernel limits the memory to 64 MB on simulator?

When testing my image, I came across a new type of failure. This time
kernel reported a bug:

[ 1918.046230] BUG: Bad page state in process khugepaged  pfn:6896e
[ 1918.052256] page:8000000005000010 count:-1610612736 mapcount:1 mapping:          (null) index:0x0
[ 1918.061189] flags: 0x0()
[ 1918.063735] page dumped because: nonzero _count
[ 1918.068271] Modules linked in: broadcom bcm_phy_lib
[ 1918.073191] CPU: 0 PID: 124 Comm: khugepaged Not tainted 4.6.0-octeon-los_a568fa0+ #1
[ 1918.081030] Stack : ffffffff81790000 ffffffff81784d48 0000000000000000 ffffffff82070000
	  00000000000003e0 0044b82fa09b0000 ffffffff8206efd0 0000000000000004
	  0000000000000049 ffffffff81790000 0000000000000000 0000000000000000
	  0000000000000049 0000000000000006 0000000000000000 ffffffff8118a588
	  0000000000000000 ffffffff82070000 0000000000000000 ffffffff82060000
	  ffffffff8178ad07 ffffffff816dd238 800000008ec2ce00 0000000000000000
	  000000000000007c ffffffff82066878 ffffffff817b8a00 0000000000000001
	  8000000004ffb000 800000008f557850 800000008f557968 ffffffff813648d4
	  ffffffff817b8a00 ffffffff8118b678 000000000000009e ffffffff816dd238
	  0000000000000000 ffffffff811242f8 0000000000000000 0000000000000000
	  ...
[ 1918.146630] Call Trace:
[ 1918.149089] [<ffffffff811242f8>] show_stack+0x88/0xa8
[ 1918.154154] [<ffffffff813648d4>] dump_stack+0x94/0xd0
[ 1918.159213] [<ffffffff811d9dbc>] bad_page+0x134/0x1a0
[ 1918.164273] [<ffffffff811ddd90>] get_page_from_freelist+0x3b0/0xac8
[ 1918.170550] [<ffffffff811de79c>] __alloc_pages_nodemask+0xcc/0x998
[ 1918.176740] [<ffffffff8122c274>] khugepaged+0x7e4/0x1878
[ 1918.182063] [<ffffffff81162284>] kthread+0xd4/0xf0
[ 1918.186861] [<ffffffff8111ec18>] ret_from_kernel_thread+0x14/0x1c
[ 1918.192961] 
[ 1918.194465] Disabling lock debugging due to kernel taint

However, the build went through apparently OK.

Much later, Perl got stuck in the test suite. SysRq showed it was
apparently busylooping in the page fault handler:

[ 8567.431460] perl            R  running task        0 19437  19408 0x08d00000
[ 8567.438538] Stack : ffffffff816e0fdd ffffffff8163bed8 ffffffff816e0fdc ffffffff816e1cf8
	  ffffffff82070000 0000000000000001 ffffffff820682e0 ffffffff82070000
	  ffffffff81790000 ffffffff81784d48 0000000000000000 ffffffff82070000
	  0000000000000000 0044b82fa09b0000 ffffffff8206efd0 0000000000000004
	  000000000000001d ffffffff81790000 0000000000000000 0000000000000000
	  000000000000001d 0000000000000002 0000000000000000 ffffffff8118a588
	  0000000000000000 0000000000000001 0000000000000000 ffffffff8206a6f8
	  800000008eca0000 800000008ebb76f0 800000008eca02e0 ffffffff8116d568
	  ffffffff8178ae80 ffffffff817a0000 ffffffff8179fd00 ffffffff817c0000
	  0000000000000000 ffffffff811242f8 0000000000000000 0000000000000000
	  ...
[ 8567.504144] Call Trace:
[ 8567.506596] [<ffffffff811242f8>] show_stack+0x88/0xa8
[ 8567.511656] [<ffffffff8116d568>] show_state_filter+0x88/0xc8
[ 8567.517325] [<ffffffff813cda28>] sysrq_handle_showstate+0x10/0x20
[ 8567.523427] [<ffffffff813cde60>] __handle_sysrq+0xb8/0x1f0
[ 8567.528921] [<ffffffff813d4378>] serial8250_rx_chars+0x110/0x228
[ 8567.534938] [<ffffffff813d7550>] serial8250_handle_irq.part.14+0x80/0x110
[ 8567.541736] [<ffffffff813db460>] dw8250_handle_irq+0x38/0xb0
[ 8567.547405] [<ffffffff813d2da8>] serial8250_interrupt+0x60/0xf8
[ 8567.553335] [<ffffffff8118c1f8>] handle_irq_event_percpu+0x78/0x1b8
[ 8567.559611] [<ffffffff8118c390>] handle_irq_event+0x58/0x98
[ 8567.565194] [<ffffffff81190074>] handle_level_irq+0xd4/0x198
[ 8567.570862] [<ffffffff8118b780>] generic_handle_irq+0x40/0x58
[ 8567.576617] [<ffffffff81120b70>] do_IRQ+0x18/0x28
[ 8567.581329] [<ffffffff811052bc>] plat_irq_dispatch+0xc4/0x130
[ 8567.587083] [<ffffffff8111ebd0>] ret_from_irq+0x0/0x4
[ 8567.592143] [<ffffffff8160eed0>] _raw_spin_lock+0x18/0x30
[ 8567.597550] [<ffffffff8122d8f0>] huge_pmd_set_accessed+0x40/0xd8
[ 8567.603566] [<ffffffff81205220>] handle_mm_fault+0x110/0x1bb0
[ 8567.609320] [<ffffffff811344b8>] __do_page_fault+0x158/0x508
[ 8567.614988] [<ffffffff8111ebc0>] ret_from_exception+0x0/0x10

A.
