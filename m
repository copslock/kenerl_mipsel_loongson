Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Nov 2013 12:23:56 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:50536 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815746Ab3KXLXyw0YHi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Nov 2013 12:23:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 3F44B56F904;
        Sun, 24 Nov 2013 13:23:54 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id T8k+x0ShRngv; Sun, 24 Nov 2013 13:23:50 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with SMTP id 38F465BC004;
        Sun, 24 Nov 2013 13:23:49 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 24 Nov 2013 13:23:48 +0200
Date:   Sun, 24 Nov 2013 13:23:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: MIPS: 3.13-rc1 regression: Loongson2 broken
Message-ID: <20131124112348.GB24645@blackmetal.musicnaut.iki.fi>
References: <20131123195339.GA6755@blackmetal.musicnaut.iki.fi>
 <CAAhV-H6Dfh08r+9ujwKpOPj7dMeybN5nE8EJLfJmhz9JzO16yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6Dfh08r+9ujwKpOPj7dMeybN5nE8EJLfJmhz9JzO16yg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38575
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

On Sun, Nov 24, 2013 at 05:27:42PM +0800, Huacai Chen wrote:
> I have already post a patch for this (see below), but it seems like Ralf has
> missed to see it.
> http://www.linux-mips.org/archives/linux-mips/2013-11/msg00053.html

Yes, but this patch is not alone sufficient since the second crash will
be still there:

[    3.652000] Reserved instruction in kernel code[#1]:
[    3.652000] CPU: 0 PID: 1 Comm: earlyboot.sh Not tainted 3.13.0-rc1-lemote-los.git-6e483b8-dirty+ #1
[    3.652000] task: 980000009f078000 ti: 980000009f05c000 task.ti: 980000009f05c000
[    3.652000] $ 0   : 0000000000000000 ffffffffcfffffff ffffffff802223c0 000000007fec8000
[    3.652000] $ 4   : 000000007fec4000 0000000000000040 0000000000000427 9800000001104003
[    3.652000] $ 8   : 0000000000000004 0000000000000000 980000009f31c000 0000000000000000
[    3.652000] $12   : 0000000000000000 000000001000001e f2c1fe409143bbcb 0001fe409143bbcb
[    3.652000] $16   : 000000007fec4000 0000000000000000 000000007fec6b64 9800000001112850
[    3.652000] $20   : 000000000084e35b ffffffff806f2060 980000009f467d88 0000000000800000
[    3.652000] $24   : 0000000000000000 ffffffff80222850                                  
[    3.652000] $28   : 980000009f05c000 980000009f05fb90 ffffffff810dee70 ffffffff80222c34
[    3.652000] Hi    : 00000000000006ff
[    3.652000] Lo    : df3b645a1cac1081
[    3.652000] epc   : ffffffff802223c8 blast_icache32_page+0x8/0xb0
[    3.652000]     Not tainted
[    3.652000] ra    : ffffffff80222c34 r4k_flush_cache_page+0x19c/0x200
[    3.652000] Status: 300044e3	KX SX UX KERNEL EXL IE 
[    3.652000] Cause : 10008028
[    3.652000] PrId  : 00006303 (ICT Loongson-2)
[    3.652000] Modules linked in:
[    3.652000] Process earlyboot.sh (pid: 1, threadinfo=980000009f05c000, task=980000009f078000, tls=0000000077e864d0)
[    3.652000] Stack : 980000009f4b01f8 9800000001112888 980000009f379ad0 ffffffff802d17e4
	  980000009f3b41f8 000000007fec7fff 980000009f379ad0 980000009f2ed600
	  000000007fea0000 980000009f4b01f8 000000007fec6b64 980000009f4b01f8
	  0000000000000001 980000009f379ad0 ffffffff810dee70 00000000000000a9
	  980000009f467d88 980000009f379ad0 980000009f2edb80 ffffffff802d51b0
	  0000000100000000 0000000000000000 980000009f2ed600 980000009f2ed678
	  000000007fec6b64 00000000000000a9 980000009f2edb80 980000009f078000
	  0000000000000001 980000009f2edbe0 0000000000030002 980000009f379ad0
	  980000009f05feb0 ffffffff8021bd40 980000009f379ad0 980000009f2ed600
	  000000007fec8000 980000009f4b01f8 000000007fec8000 ffffffff802d3f48
	  ...
[    3.652000] Call Trace:
[    3.652000] [<ffffffff802223c8>] blast_icache32_page+0x8/0xb0
[    3.652000] [<ffffffff80222c34>] r4k_flush_cache_page+0x19c/0x200
[    3.652000] [<ffffffff802d17e4>] do_wp_page.isra.97+0x47c/0xe08
[    3.652000] [<ffffffff802d51b0>] handle_mm_fault+0x938/0x1118
[    3.652000] [<ffffffff8021bd40>] __do_page_fault+0x140/0x540
[    3.652000] [<ffffffff80206be4>] resume_userspace_check+0x0/0x10
[    3.652000] 
[    3.652000] 
Code: 00200825  64834000  00200825 <bc900000> bc900020  bc900040  bc900060  bc900080  bc9000a0 
[    3.656000] ---[ end trace cd8a48f722f5c5f7 ]---
[    3.660000] note: earlyboot.sh[1] exited with preempt_count 2
[    3.664000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

A.
