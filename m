Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 16:22:06 +0000 (GMT)
Received: from hicks.ciena.com ([63.118.34.22]:33413 "EHLO hicks.ciena.com")
	by ftp.linux-mips.org with ESMTP id S23954044AbYK0QU5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Nov 2008 16:20:57 +0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEALtXLkk/dicV/2dsb2JhbADSM4J9
Thread-Index: AclQrB1PGqQauXXTTsCYu7+YHK/RmQ==
Message-ID: <492EC8D8.2070200@ciena.com>
Date:	Thu, 27 Nov 2008 11:20:40 -0500
From:	"David Pelton" <dpelton@ciena.com>
Organization: Ciena
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	"Mark E Mason" <mason@broadcom.com>
Cc:	"Andrew Sharp" <andy.sharp@onstor.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"LMO" <linux-mips@linux-mips.org>, <mmason@upwardaccess.com>
Subject: Re: Booting top-of-tree bcm47xx as nfs-root with cfe only (no sibyl)
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com> <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org> <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com> <20081126153115.24dda1dc@ripper.onstor.net> <BD3F7F1EFBA6D54DB056C4FFA45140080348EC805C@SJEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC805C@SJEXCHCCR01.corp.ad.broadcom.com>
Content-Type: text/plain;
	format=flowed;
	charset="utf-8"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Content-class: urn:content-classes:message
Content-Transfer-Encoding: 8BIT
Importance: normal
Priority: normal
X-OriginalArrivalTime: 27 Nov 2008 16:20:47.0612 (UTC) FILETIME=[1B1AFBC0:01C950AC]
Return-Path: <dpelton@ciena.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpelton@ciena.com
Precedence: bulk
X-list: linux-mips

Mark E Mason wrote:

<...snip...>

> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 168k freed
> Algorithmics/MIPS FPU Emulator v1.5
> Data bus error, epc == 803ef178, ra == 80017030
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 1000a800 fffd9000 00000001
> $ 4   : 810a6000 fffd9000 810a6f00 fffd9000
> $ 8   : 803bc1c8 00000001 81021500 00040000
> $12   : 00000000 803e8d20 00000001 803bc1a0
> $16   : 810a6000 803f0000 2ad19120 0109968b
> $20   : 8394d2ac 8395517c 2ad19120 83940de0
> $24   : 00000000 2aab4184                  
> $28   : 83818000 83819db0 00000000 80017030
> Hi    : 00000000
> Lo    : 00000000
> epc   : 803ef178 0x803ef178
>     Not tainted
> ra    : 80017030 copy_user_highpage+0x90/0x140
> Status: 1000a803    KERNEL EXL IE 
> Cause : 0080001c
> PrId  : 00029006 (Broadcom BCM3302)
> Modules linked in:
> Process init (pid: 1, threadinfo=83818000, task=83815a58, tls=00000000)
> Stack : 83943464 0109968b 8394d2ac 8395517c 803f0000 81021320 810214c0 8008c498
>         839551d0 00000000 00000000 00000000 00000000 00000000 810214c0 83940de0
>         83815a58 0109968b 80000000 8395517c 8394d2ac 2ad19120 00000001 00030000
>         00000464 8008dc84 83940de0 00100073 00000000 00000000 8394d2ac 83940e20
>         0109968b 00100073 80091a14 800917d4 83815a58 8395517c 83940e14 83940de0
>         ...
> Call Trace:
> [<8008c498>] do_wp_page+0x6dc/0xa24
> [<8008dc84>] handle_mm_fault+0x7e8/0x8e8
> [<80091a14>] mmap_region+0x3cc/0x6b8
> [<800917d4>] mmap_region+0x18c/0x6b8
> [<80016a00>] do_page_fault+0x100/0x344
> [<8001f6f0>] fpu_emulator_cop1Handler+0x1bf0/0x1c54
> [<8009200c>] do_mmap_pgoff+0x30c/0x344
> [<80013c94>] do_cpu+0x360/0x3c4
> [<80001400>] ret_from_exception+0x0/0x24
> [<80001400>] ret_from_exception+0x0/0x24
> 
> 
> Code: cc9e0060  cc9e0070  cca40100 <8ca80000> 8ca90004  8caa0008  8cab000c  cc9e0080  ac880000 
> note: init[1] exited with preempt_count 2
> BUG: scheduling while atomic: init/1/0x10000002
> Modules linked in:
> Call Trace:
> [<800125a0>] dump_stack+0x8/0x34
> [<80009bac>] __sched_text_start+0x6c/0x6d0
> [<8002c4d0>] __cond_resched+0x20/0x4c
> [<8000a5e4>] _cond_resched+0x4c/0x60
> [<80033780>] put_files_struct+0x19c/0x228
> [<800342b4>] do_exit+0x268/0x854
> [<80012d40>] do_be+0x0/0x198
> 
> Kernel panic - not syncing: Attempted to kill init!


(apologies for what my mail gateway may decide to do with the formatting of this message)


This problem looks similar to an issue raised on this list earlier in the year:

http://www.linux-mips.org/archives/linux-mips/2008-06/msg00050.html

At the time I was having a similar issue with a Broadcom MIPS32 that I was working on (which also has a BCM3302 core).  My fix is outlined in this post:

http://www.linux-mips.org/archives/linux-mips/2008-06/msg00141.html

To summarize, the kernel was trying to map memory into virtual addresses that the chip was using for internal address space.  I'm not sure that you are having the same problem, but I figured I should mention this since the problem looks similar.


- David Pelton
