Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2006 10:52:14 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:48611 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133419AbWFUJwB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jun 2006 10:52:01 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id BB4D6C0FB;
	Wed, 21 Jun 2006 11:51:46 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id DB8831BC08F;
	Wed, 21 Jun 2006 11:51:47 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id D403F1A18AB;
	Wed, 21 Jun 2006 11:51:48 +0200 (CEST)
Date:	Wed, 21 Jun 2006 11:51:50 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable local interrupts) Breaks SGI IP32
Message-ID: <20060621095150.GO5568@domen.ultra.si>
References: <4478C0F1.8000006@gentoo.org> <20060528010603.GA24997@linux-mips.org> <20060527194243.a8157338.akpm@osdl.org> <4479250E.3080604@gentoo.org> <20060528105014.GA28621@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060528105014.GA28621@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Hi!

(removed akpm from CC, as he's probably no longer interested)

On 28/05/06 11:50 +0100, Ralf Baechle wrote:
> On Sun, May 28, 2006 at 12:20:30AM -0400, Kumba wrote:
> > It also seems this was affecting AMD Alchemy-based systems too.  Other SGI 
> > machines are known to work fine, except Indy and Indigo2, as I haven't 
> > tested those yet.
> 
> IP27 is fine but it's SMP but I've already cleaned out all the early
> calls to smp_call_function there were shown by the WARN() ages ago.
> 
> You can do it the same way, use this debugging version of on_each_cpu:
> 
> #define on_each_cpu(func,info,retry,wait)       \
>         ({                                      \
> 		WARN_ON(irqs_disabled());	\
>                 func(info);                     \
>                 0;                              \
>         })

On Alchemy au1200 this produces:
[4294667.296000] Synthesized TLB modify handler fastpath (33 instructions).
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
[4294667.296000]  [<803f3630>] trap_init+0x3c/0x440
[4294667.296000]  [<803f3630>] trap_init+0x3c/0x440
[4294667.296000]  [<8025f3dc>] sort_extable+0x24/0x30
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed6c4>] start_kernel+0xb8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<8010b16c>] dump_stack+0x14/0x20
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
[4294667.296000]  [<8010cb78>] set_except_vector+0x88/0xa0
[4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
[4294667.296000]  [<803f3648>] trap_init+0x54/0x440
[4294667.296000]  [<8025f3dc>] sort_extable+0x24/0x30
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed6c4>] start_kernel+0xb8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
[4294667.296000]  [<803f395c>] trap_init+0x368/0x440
[4294667.296000]  [<803f395c>] trap_init+0x368/0x440
[4294667.296000]  [<8025f3dc>] sort_extable+0x24/0x30
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed6c4>] start_kernel+0xb8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
[4294667.296000]  [<803f38c8>] trap_init+0x2d4/0x440
[4294667.296000]  [<803f39dc>] trap_init+0x3e8/0x440
[4294667.296000]  [<8025f3dc>] sort_extable+0x24/0x30
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed6c4>] start_kernel+0xb8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803f5edc>] flush_tlb_handlers+0x28/0x64
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803f5ef4>] flush_tlb_handlers+0x40/0x64
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
[4294667.296000] Call Trace:
[4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
[4294667.296000]  [<80105580>] handle_reserved+0x0/0xc8
[4294667.296000]  [<8010cb78>] set_except_vector+0x88/0xa0
[4294667.296000]  [<8010b0f4>] show_trace+0x98/0xfc
[4294667.296000]  [<803f0c18>] arch_init_irq+0x44/0x1e0
[4294667.296000]  [<8010b16c>] dump_stack+0x14/0x20
[4294667.296000]  [<803f2620>] init_IRQ+0x90/0x9c
[4294667.296000]  [<803ed6e4>] start_kernel+0xd8/0x20c
[4294667.296000]  [<803ed6d4>] start_kernel+0xc8/0x20c
[4294667.296000]  [<803ed12c>] unknown_bootoption+0x0/0x310
[4294667.296000] 
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)



	Domen
