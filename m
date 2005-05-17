Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 11:15:49 +0100 (BST)
Received: from krt.tmd.ns.ac.yu ([IPv6:::ffff:147.91.177.65]:12966 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8226180AbVEQKPd>;
	Tue, 17 May 2005 11:15:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4HAKoZF031081
	for <linux-mips@linux-mips.org>; Tue, 17 May 2005 12:20:56 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 30287-05 for <linux-mips@linux-mips.org>;
 Tue, 17 May 2005 12:20:50 +0200 (CEST)
Received: from davidovic ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4HAKh1p031076
	for <linux-mips@linux-mips.org>; Tue, 17 May 2005 12:20:43 +0200
Message-Id: <200505171020.j4HAKh1p031076@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: Mips 4lkecr2
Date:	Tue, 17 May 2005 12:16:07 +0200
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050516174940.GA31527@linux-mips.org>
Thread-Index: AcVaQXwE8CLCWORGTEeQW88iB6fyfAAhu+2g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <mile.davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mile.davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all

Here is output from latest (2.6.12-rc3) linux-mips version. What is problem
with mem_init function?


 Linux version 2.6.12-rc3-md (davidovic@rhel.micronasnit.com) (gcc version
3.4.2) #14 Tue May 17 11:06:34 CEST 2005
 CPU revision is: 00019064
 Determined physical RAM map:
  memory: 04000000 @ 00000000 (usable)
 Built 1 zonelists
 Kernel command line: 
 Primary instruction cache 16kB, physically tagged, 4-way, linesize 16
bytes.
 Primary data cache 8kB, 2-way, linesize 16 bytes.
 Synthesized TLB refill handler (20 instructions).
 Synthesized TLB load handler fastpath (32 instructions).
 Synthesized TLB store handler fastpath (32 instructions).
 Synthesized TLB modify handler fastpath (31 instructions).
 PID hash table entries: 512 (order: 9, 8192 bytes)
 Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
 Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
 Bad page state at free_hot_cold_page (in process 'swapper', page 81003180)
 flags:0x00000000 mapping:00000000 mapcount:-65535 count:0
 Backtrace:
 Call Trace:
  [<80052440>] bad_page+0x70/0xc0
  [<800296c4>] vprintk+0x38c/0x460
  [<80162b28>] build_tlb_refill_handler+0xdcc/0xea8
  [<80052bec>] free_hot_cold_page+0x88/0x284
  [<80169e48>] free_all_bootmem_core+0x174/0x2d4
  [<8016ab88>] alloc_large_system_hash+0x28c/0x2fc
  [<80160868>] mem_init+0x50/0x1b4
  [<8016bf74>] inode_init_early+0x68/0xbc
  [<8015e070>] vgca_timer_setup+0xc8/0xfc
  [<80157910>] start_kernel+0x17c/0x254
  [<801572e4>] unknown_bootoption+0x0/0x310
 
 Trying to fix it up, but a reboot is needed
 Bad page state at free_hot_cold_page (in process 'swapper', page 81003280)
 flags:0x0000525a mapping:00000000 mapcount:0 count:0
 Backtrace:
 Call Trace:
  [<80052440>] bad_page+0x70/0xc0
  [<800296c4>] vprintk+0x38c/0x460
  [<80162b28>] build_tlb_refill_handler+0xdcc/0xea8
  [<80052bec>] free_hot_cold_page+0x88/0x284
  [<80169e48>] free_all_bootmem_core+0x174/0x2d4
  [<8016ab88>] alloc_large_system_hash+0x28c/0x2fc
  [<80160868>] mem_init+0x50/0x1b4
  [<8016bf74>] inode_init_early+0x68/0xbc
  [<8015e070>] vgca_timer_setup+0xc8/0xfc
  [<80157910>] start_kernel+0x17c/0x254
  [<801572e4>] unknown_bootoption+0x0/0x310 

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Monday, May 16, 2005 7:50 PM
To: Mile Davidovic
Cc: 'Linux/MIPS Development'
Subject: Re: Mips 4lkecr2

On Mon, May 16, 2005 at 11:57:02AM +0200, Mile Davidovic wrote:

> I have embedded processor with MIPS 4KECr2 processor and tried to port 
> linux-2.6.11-mipscvs-20050313.
> I follow tutorial from linux-mips and add custom code for int handler, 
> time ...
> But I have some problem with detecting of cpu. In cpu-probe.c I added:
> cpu_probe_mips with:
>        case PRID_IMP_4KEC:
>        case PRID_IMP_4KECR2:   /* this line is added */
>         c->cputype = CPU_4KEC;
> 		c->isa_level = MIPS_CPU_ISA_M32;
> 
> Is it ok ? Did I forgot something?

To get Linux to work on a 4KEc R2 Malta I only had to to do this change so
you have an additional problem.

  Ralf
