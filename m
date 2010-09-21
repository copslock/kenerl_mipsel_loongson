Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Sep 2010 15:33:15 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491070Ab0IUNdI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Sep 2010 15:33:08 +0200
Date:   Tue, 21 Sep 2010 14:33:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     arrow zhang <arrow.ebd@gmail.com>
Cc:     linux-mips@linux-mips.org,
        OpenWrt <openwrt-devel@lists.openwrt.org>
Subject: Re: [HELP] Oops when insmod iptable_filter
Message-ID: <20100921133307.GA3855@linux-mips.org>
References: <AANLkTimCEAzvya1zH0BRvHtn7=PhZPHgPG2LMzquhjGy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimCEAzvya1zH0BRvHtn7=PhZPHgPG2LMzquhjGy@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16271

On Fri, Sep 17, 2010 at 08:55:43PM +0800, arrow zhang wrote:

> Here has a difficult problem for me, would like anyone give some advice
> 
> On a mips r3000 cpu, here has a kernel crash when doing the insmod
> iptable_filter,

Are you sure you really have an R3000?  That's an very old processor
released in 1988.

> The phenomenon is same as https://dev.openwrt.org/ticket/6129
> 
> 1, the FW is at openwrt versoin r23057
> 2, the crash occurs if insmod automatically by preinit
> 3, but not has crash if insmod within "failsafe mode"
> 
> 4, the crash address is random in the "iptable_filter_init" progress,
> seems the symbol or page address invalidate
>     and sometime may crash at any other modules, (e.g.
> iptable_mangle/raw, but iptable_filter module is crash every time)
> 
> 5, refer from the "crash log" "Cause : 00000008", maybe is a TLB
> issue, but I have no idea about the debug direction

That could be a fairly generic sympthom for dereferencing a bad pointer.

>    I have try something as these
>    * check the irq routine
>    * double check file arch/mips/mm/c-r3k.c
>    * double check file arch/mips/mm/tlb-r3k.c
>    * try to remove the patch :
> target/linux/generic/patches-2.6.35/027-mips_module_reloc.patch
>    * try to remove the patch :
> target/linux/generic/patches-2.6.35/028-module_exports.patch
>    * try to remove the patch :
> target/linux/generic/patches-2.6.35/202-mips_mem_functions_performance.patch
> but all can not fix this bug
> 
> next is the crash log (some printk added at sys_init_module)
> {{{
> device eth0 entered promiscuous mode
> br-lan: port 1(eth0) entering forwarding state
> br-lan: port 1(eth0) entering forwarding state
> sys_init_module 2626, name: crc_ccitt
> sys_init_module 2636
> sys_init_module 2641
> sys_init_module 2626, name: slhc
> sys_init_module 2636
> sys_init_module 2641
> sys_init_module 2626, name: ppp_generic
> sys_init_module 2636
> sys_init_module 2638
> PPP generic driver version 2.4.2
> sys_init_module 2641
> sys_init_module 2626, name: ppp_async
> sys_init_module 2636
> sys_init_module 2638
> sys_init_module 2641
> sys_init_module 2626, name: x_tables
> sys_init_module 2636
> sys_init_module 2638
> sys_init_module 2641
> sys_init_module 2626, name: xt_tcpudp
> sys_init_module 2636
> sys_init_module 2638
> sys_init_module 2641
> sys_init_module 2626, name: ip_tables
> sys_init_module 2636
> sys_init_module 2638
> ip_tables: (C) 2000-2006 Netfilter Core Team
> sys_init_module 2641
> sys_init_module 2626, name: iptable_filter
> sys_init_module 2636
> sys_init_module 2638
> CPU 0 Unable to handle kernel paging request at virtual address
> 00000000, epc == 81a6e030, ra == 81a6e024
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 00000000 00000000 00005200
> $ 4   : 000000b0 81a90000 81a9224c 000012ce
> $ 8   : 00000030 800042c0 00000001 00000000
> $12   : 00000003 ffffffff 00000000 745f7375
> $16   : 819e5200 802f3260 81a30000 81a2e174
> $20   : 81a6e090 802b0000 004085c4 00000002
> $24   : 00000000 81a6e000
> $28   : 81a86000 81a87e30 7fbef508 81a6e024
> Hi    : 00000000
> Lo    : 000000c7
> epc   : 81a6e030 __this_module+0x3fea0/0x3ff00 [iptable_filter]
>     Not tainted
> ra    : 81a6e024 __this_module+0x3fe94/0x3ff00 [iptable_filter]

The big difference between your issue and the old issue in openwrt is that
your system dies in the kernel itself; the old openwrt case blows up
while executing code of the module.  So they're probably something different.

(I think the openwrt issue was actually something specific to 64-bit kernels.)

> Status: 1000ff04    IEp
> Cause : 00000008
> BadVA : 00000000
> PrId  : 0000cf01 (rtl)
> Modules linked in: iptable_filter(+) ip_tables xt_tcpudp x_tables
> ppp_async ppp_generic slhc crc_ccitt
> Process insmod (pid: 282, threadinfo=81a86000, task=81a08108, tls=00000000)
> Stack : 802eac4c 81a2e174 802c0000 802e0000 81a2e174 802c0000 802e0000 801b0b1c
>         00000034 8001e944 00000001 00000000 81a2e174 802c0000 802e0000 00000000
>         81a6e090 801b0c94 8025148c 0000002a 0000002a c016c9e8 c016c47c 00000001
>         81a30000 81a6e0c0 00000310 000002f0 0000001a 00000019 1000ff01 00000001
>         81a2e190 80008b50 80280000 80250000 81a2e19c 802b0000 004085c4 00000002
>         ...
> Call Trace:
> [<81a6e030>] __this_module+0x3fea0/0x3ff00 [iptable_filter]
> [<81a6e024>] __this_module+0x3fe94/0x3ff00 [iptable_filter]
> 
> 
> Code: 10400018  00408021  3c0281a3 <8c43e170> 2645e120  00031827
> ae030188  02202021  0c6a478e
> Disabling lock debugging due to kernel taint
> sys_init_module 2626, name: iptable_mangle
> sys_init_module 2636
> sys_init_module 2638
> }}}

  Ralf
