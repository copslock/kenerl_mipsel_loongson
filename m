Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 16:46:50 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:11026 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133560AbWB1Qqi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 16:46:38 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6DE6164D3D; Tue, 28 Feb 2006 16:54:16 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 30DAF81F5; Tue, 28 Feb 2006 17:54:05 +0100 (CET)
Date:	Tue, 28 Feb 2006 16:54:05 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060228165404.GA8442@deprecation.cyrius.com>
References: <20060120004208.GA18327@deprecation.cyrius.com> <20060120144710.GA30415@linux-mips.org> <20060121010455.GC3514@colonel-panic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121010455.GC3514@colonel-panic.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Peter Horton <pdh@colonel-panic.org> [2006-01-21 01:04]:
> > >  Real Time Clock Driver v1.12a
> > >  Cobalt LCD Driver v2.10
> > >  i8042.c: i8042 controller self test timeout.
> > >  Unhandled kernel unaligned access[#1]:
> > 
> > The i8042 error message is a little surprising.  The Cobalt boards afair
> No SuperIO, but there is a bog standard VIA PCI-ISA bridge which
> contains a bog standard PS/2 keyboard controller, which you would have
> thought should just work ...

That's really interesting.  I tried latest git (2.6.16-rc5) to see if
this is still there.  First of all, 32-bit is fine, both regarding
i8042 as well as ALSA with a PCI audio card.  With a 64-bit kernel,
i8042 appears to be okay now.  I get:

Cobalt LCD Driver v2.10
i8042.c: i8042 controller self test timeout.
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled

and the kernel boots fine.

I then built ALSA support into the kernel to see whether
http://www.linux-mips.org/archives/linux-mips/2006-01/msg00325.html
disappeared too.  I got almost the same oops as the one I got before
because of i8042.

Peter, does that make any sense to you?  I assume your recent PCI fix
may be related.


...
Real Time Clock Driver v1.12a
Cobalt LCD Driver v2.10
i8042.c: i8042 controller self test timeout.
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ÿserial8250: ttyS0 at I/O 0xc800000 (irq = 21) is a ST16650V2
loop: loaded (max 8 devices)
...
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff940044e0 9b64000001014c88 0000000000000000
$ 4   : ffffffff803b1c20 ffffffffdc820000 0000000000000000 9b64000001014c80
$ 8   : 98000000004d8000 98000000004dbc00 0000000000000000 ffffffff8040dc60
$12   : ffffffff940044e0 000000001000001e ffffffff803c9758 ffffffff804a0000
$16   : 98000000004dbc00 0000000000000004 0000000000000000 0000000000010000
$20   : 0000000000000004 0000000000000002 0000000000000002 98000000005dbc00
$24   : 0000000000000010 ffffffff80096fc8                                  
$28   : 98000000004d8000 98000000004dbbd0 ffffffff803f0000 ffffffff8008234c
Hi    : 0000000000000000
Lo    : 0000000000000380
epc   : ffffffff80089ae8 do_ade+0x398/0x4a0     Not tainted
ra    : ffffffff8008234c handle_adel_int+0x34/0x48
Status: 940044e2    KX SX UX KERNEL EXL 
Cause : 0080a010
BadVA : 9b64000001014c87
PrId  : 000028a0
Process swapper (pid: 1, threadinfo=98000000004d8000, task=98000000004d7848)
Stack : 98000000005c7048 0000000000000004 90000000005f0000 0000000000010000
        ffffffff8008234c ffffffff8040dd40 0000000000000000 ffffffff940044e0
        0000000000000380 ffffffff940044e1 9b64000001014c80 9b64000001014cb8
        9b64000001015000 0000000000004000 0000000000008000 ffffffff804a0000
        0000000000000004 ffffffff8040dc60 0000000000000000 ffffffff80207a2c
        ffffffff803c9758 ffffffff804a0000 98000000005c7048 0000000000000004
        90000000005f0000 0000000000010000 0000000000000004 0000000000000002
        0000000000000002 98000000005dbc00 0000000000000010 ffffffff80096fc8
        00000000000005f0 ffffffff800dcd10 98000000004d8000 98000000004dbd30
        ffffffff803f0000 ffffffff802b26c8 ffffffff940044e2 0000000000000000
        ...
Call Trace:
 [<ffffffff8008234c>] handle_adel_int+0x34/0x48
 [<ffffffff80207a2c>] memset_partial+0x48/0x60
 [<ffffffff80096fc8>] blast_dcache32+0x0/0x100
 [<ffffffff800dcd10>] __get_free_pages+0x60/0xf0
 [<ffffffff802b26c8>] snd_dma_alloc_pages+0x118/0x1a8
 [<ffffffff802b1d10>] mark_pages+0x60/0xa8
 [<ffffffff802b1994>] snd_pcm_lib_preallocate_pages+0x16c/0x1e0
 [<ffffffff802b1a68>] snd_pcm_lib_preallocate_pages_for_all+0x60/0xb0
 [<ffffffff802a3b88>] snd_pcm_new+0x98/0x180
 [<ffffffff802e008c>] snd_audiopci_probe+0x8f4/0xd00
 [<ffffffff802dd290>] snd_ensoniq_mixer_free_ac97+0x0/0x10
 [<ffffffff802170c0>] pci_device_probe+0x80/0xa8
 [<ffffffff802503e8>] driver_probe_device+0x58/0x110
 [<ffffffff802507c4>] __driver_attach+0x1cc/0x218
 [<ffffffff802505f8>] __driver_attach+0x0/0x218
 [<ffffffff8024f210>] bus_for_each_dev+0x50/0xb8
 [<ffffffff80201c0c>] kobject_register+0x5c/0xa0
 [<ffffffff8024f6f0>] bus_add_driver+0xb8/0x1f8
 [<ffffffff80490000>] netlink_proto_init+0x1c8/0x3f8
 [<ffffffff80216b04>] __pci_register_driver+0xb4/0x118
 [<ffffffff80216b04>] __pci_register_driver+0xb4/0x118
 [<ffffffff800805f8>] init+0x150/0x448
 [<ffffffff800805f8>] init+0x150/0x448
 [<ffffffff800838e0>] kernel_thread_helper+0x10/0x18
 [<ffffffff800838d0>] kernel_thread_helper+0x0/0x18


Code: 00621824  5460ff7d  de020100 <68e30007> 6ce30000  24020000  1440ffa0  00051402  0802267b 
Kernel panic - not syncing: Attempted to kill init!
 

-- 
Martin Michlmayr
http://www.cyrius.com/
