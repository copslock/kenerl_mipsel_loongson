Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 13:29:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48330 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035353AbXL0N34 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Dec 2007 13:29:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBRDSv5M015395;
	Thu, 27 Dec 2007 14:28:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBRDSuMg015394;
	Thu, 27 Dec 2007 14:28:56 +0100
Date:	Thu, 27 Dec 2007 14:28:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: MC Bus Error / tcp_ack_saw_tstamp Was: IP28 Installation
	Success report
Message-ID: <20071227132856.GB14037@linux-mips.org>
References: <20071227090401.GA3393@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071227090401.GA3393@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 27, 2007 at 10:04:01AM +0100, Florian Lohoff wrote:

> On Sun, Dec 23, 2007 at 08:54:42PM +0100, Florian Lohoff wrote:
> > I thought an installation success report is sometimes nice to have:
> 
> Linux ip28 2.6.24-rc5-g8b3ba06b-dirty #21 Tue Dec 18 12:48:29 CET 2007 mips64 GNU/Linux
> 
> After ~10 days uptime and multiple gcc builds. Logging in via ssh 
> and issueing an "ls" in the build directory:
> 
> MC Bus Error
> GIO error 0x401:<TIME > @ 0xc8487e50
> CP0: config 6c11ae03,  MC: cpuctrl0/1: 3d802412/3d802412, giopar: c623
> MC: cpu/gio_memacc: 31453436/34336, memcfg0/1: 67206728/00005fff
> Cache tags @ c8487e50:
> D: 0: 20000000 0c848708, 1: 20000000 028963ce  (VA[13:5]  3e40)
> S: 0: 80000000 0c8481a3, 1: 80000000 02e809df  (PA[18:7] 07e00)
> Interrupt, epc == a8000000202b6760, ra == a8000000202b8d00
> Oops[#1]:
> Cpu 0
> $ 0   : 0000000000000000 ffffffff9004cce0 0000000000000001 0000000000000003
> $ 4   : a800000028963900 0000000000000004 0000000000000001 0000000000000000
> $ 8   : 00000000203f0000 0000000000000020 00000000204a0000 00000000204a0000
> $12   : 0000000000000010 a8000000201dca50 0000000020490000 00000000204a0000
> $16   : 0000000000000001 a800000028963900 a80000002041baa8 a800000020ecc6b8
> $20   : 0000000000000000 00000000204a0000 ffffffff987bd2d4 0000000000000000
> $24   : 0000000020420000 a80000002019b000                                  
> $28   : a800000028b94000 a800000028b97930 0000000000000004 a8000000202b8d00
> Hi    : 0000000000000000
> Lo    : 0000000000000a20
> epc   : a8000000202b6760 tcp_ack_saw_tstamp+0x0/0x78     Not tainted
> ra    : a8000000202b8d00 tcp_ack+0x880/0x2250
> Status: 9004cce3    KX SX UX KERNEL EXL IE 
> Cause : 00004000
> PrId  : 00000925 (R10000)
> Modules linked in:
> Process ls (pid: 308, threadinfo=a800000028b94000, task=a80000002fc73980)
> Stack : 0000000000000002 0000000000000002 0000000000000002 a800000020103cc8
>         0000000000000402 000000000a340059 0000000000000001 0000000000000000
>         0000000000000001 0000000000000000 0000000000000000 0000000000000000
>         0000000000000001 0000000000000000 ffffffff987bd2d4 0000000000000001
>         0000000000000000 a8000000289639b8 a800000028963900 a800000020dc1a34
>         a80000002bb9d580 a80000002bb9d5b8 0000000000000020 00000000204a0000
>         a800000020420000 a8000000204a0000 a8000000204a0000 a8000000202be854
>         a800000020dc1a34 a80000002bb9d580 a800000028963900 a800000020dc1a20
>         a8000000204a0000 00000000204a0000 a800000020420000 a8000000202c6a24
>         a8000000204a0000 a800000020273254 a800000020dc1a34 a800000028963900
>         ...
> Call Trace:
> [<a8000000202b6760>] tcp_ack_saw_tstamp+0x0/0x78
> [<a8000000202b8d00>] tcp_ack+0x880/0x2250
> [<a8000000202be854>] tcp_rcv_established+0x574/0x8e0
> [<a8000000202c6a24>] tcp_v4_do_rcv+0x114/0x488
> [<a8000000202c9d38>] tcp_v4_rcv+0xbc0/0xbf8
> [<a8000000202a3978>] ip_local_deliver_finish+0x1a0/0x358
> [<a8000000202a348c>] ip_rcv_finish+0x13c/0x488
> [<a800000020278330>] netif_receive_skb+0x358/0x4f8
> [<a80000002027bf3c>] process_backlog+0xfc/0x1f8
> [<a80000002027b9d4>] net_rx_action+0x18c/0x258
> [<a80000002003c31c>] __do_softirq+0xbc/0x178
> [<a80000002003c460>] do_softirq+0x88/0x90
> [<a800000020007ff4>] ret_from_irq+0x0/0x4
> [<a800000020031148>] __wake_up+0x10/0x50
> [<a8000000201fb61c>] tty_write+0x204/0x260
> [<a80000002009ef54>] vfs_write+0xec/0x178
> [<a80000002009f600>] sys_write+0x50/0xa0
> [<a80000002001c968>] handle_sys+0x128/0x144
> 
> 
> Code: 03e00008  67bd0010  00000000 <3c02a800> 64420000  67bdfff0  3c0c203f  0002103c  ffb00000 
> Kernel panic - not syncing: Fatal exception in interrupt

Seems to me that this trace is not useful at all.  And that will be
frequently the problem with IP28 bugs, they're extremly hard to trace so
code reviews may be among the most efficient methods to fix these ...

  Ralf
