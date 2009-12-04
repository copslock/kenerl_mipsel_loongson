Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 16:58:47 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:48143 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493372AbZLDPR7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 16:17:59 +0100
Received: by pzk35 with SMTP id 35so2409006pzk.22
        for <linux-mips@linux-mips.org>; Fri, 04 Dec 2009 07:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=TkrHbyrfYOqePPCm59DD9R64nbovofg3ns9yPjcPGYg=;
        b=mu1iZTu6ESM3eYFQsQszGqmHdsCSpr8S8rYd+u1q8EiNbDfwhRKwVUnFPWHNvGFOgD
         pbCY7fE/Rgh7g9bdSHBHkUdqEhdAi1vVo5OD2E/tGP3RXfx9euECfmYYy++rvIxH9byB
         /wtfEoSezHbU+oZvL20eGJkx4RqRSPQaV0BBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=crpaVyc9KFwuo6gxT31ux2UxqIWHPgRR2jrSAVaD8PlN4AKKIPGZ3TTunqLf8PQc8W
         SfeRRqxCavvzMmOEMEeIf2xocjOIgCv06e0EnYWpm4XnkrkR9TUhpDXxisvzyg2aQIzV
         R9waWoou5tc7hSJl5V3edecsAzEUwAJHdo0ME=
Received: by 10.114.236.23 with SMTP id j23mr4232904wah.164.1259939872767;
        Fri, 04 Dec 2009 07:17:52 -0800 (PST)
Received: from ?192.168.1.100? ([118.132.131.118])
        by mx.google.com with ESMTPS id 23sm68341pxi.1.2009.12.04.07.17.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 07:17:51 -0800 (PST)
Subject: Re: [HELP] is it some issue about HIGHMEM for mips32?
From:   "Figo.zhang" <figo1802@gmail.com>
To:     wuzhangjin@gmail.com
Cc:     wuzhangjin@gmail.com, rostedt@goodmis.org, zhangfx@lemote.com,
        "Thomas.Koeller" <Thomas.Koeller@baslerweb.com>,
        linux-mips@linux-mips.org
In-Reply-To: <1259935679.8314.0.camel@falcon.domain.org>
References: <1259935069.2070.8.camel@myhost>
         <1259935679.8314.0.camel@falcon.domain.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 04 Dec 2009 23:20:07 +0800
Message-ID: <1259940007.2070.48.camel@myhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25318
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-12-04 at 22:07 +0800, Wu Zhangjin wrote:
> On Fri, 2009-12-04 at 21:57 +0800, Figo.zhang wrote:
> > hi,
> > i am using 24KC soc, and linux2.6.21.5 kernel and set CONFIG_HIGHMEM
> > enable. if my realy physic RAM is not more than HIGHMEM, such as only
> > 32MB, it is some issue about kernel, i dont know how to fix it? I try
> > linux-2.6.31.4, it is no this issue, is it some change , how to fix it?
> 
> Hello, here is the unique commit about the higmem I can found:
> 
> commit bb86bf28aec6d0a207ae09f38a43e94133d4d6db
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Sat Apr 25 11:25:34 2009 +0200
> 
>     MIPS: Fix highmem.
>     
>     Commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 (kernel.org) rsp.
>     b3594a089f1c17ff919f8f78505c3f20e1f6f8ce (linux-mips.org):
>     
>     > From: Chris Dearman <chris@mips.com>
>     > Date: Wed, 19 Sep 2007 00:58:24 +0100
>     > Subject: [PATCH] [MIPS] Allow setting of the cache attribute at
> run time.
>     >
>     > Slightly tacky, but there is a precedent in the sparc archirecture
> code.
>     
>     introduces the variable _page_cachable_default, which defaults to
> zero and.
>     is used to create the prototype PTE for __kmap_atomic in
>     arch/mips/mm/init.c:kmap_init before initialization in
>     arch/mips/mm/c-r4k.c:coherency_setup, so the default value of 0 will
> be
>     used as the CCA of kmap atomic pages which on many processors is not
> a
>     defined CCA value and may result in writes to kmap_atomic pages
> getting
>     corrupted.  Debugged by Jon Fraser (jfraser@broadcom.com).
> 
> Could you please try to apply it, and test it again?

hi , i have apply the patch by manual,

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bb86bf28aec6d0a207ae09f38a43e94133d4d6db
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=351336929ccf222ae38ff0cb7a8dd5fd5c6236a0
 

but the issue still. so what is the problem?

Best,
Figo.zhang


> 
> >  
> > here is my kernel log:
> > Linux version 2.6.21.5 (figo@myhost) (gcc version 4.1.2) #22 Fri Dec 4
> > 10:33:25 CST 2009
> > CPU revision is: 00019655
> > Determined physical RAM map:
> > memory: start:0x0,size=0x2000000,type=0x1
> > (usable)
> > User-defined physical RAM map:
> > memory: start:0x0,size=0x2000000,type=0x1
> > (usable)
> > Initrd not found or empty - disabling initrd
> > Built 1 zonelists.  Total pages: 8128
> > Kernel command line: console=ttyS0,115200 rdinit=/linuxrc mem=32M nofpu
> > mac=00:aa:aa:bb:bb:99
> > Updated MAC address from u-boot: 8024ff24M
> > Primary instruction cache 32kB, physically tagged, 4-way, linesize 32
> > bytes.
> > Primary data cache 32kB, 4-way, linesize 32 bytes.
> > Synthesized TLB refill handler (20 instructions).
> > Synthesized TLB load handler fastpath (32 instructions).
> > Synthesized TLB store handler fastpath (32 instructions).
> > Synthesized TLB modify handler fastpath (31 instructions).
> > Cache parity protection disabled
> > arch/mips/mach-opulan/optrann/irq.c,arch_init_irq
> > PID hash table entries: 128 (order: 7, 512 bytes)
> > Using 150.000 MHz high precision timer.
> > arch/mips/mach-opulan/optrann/time.c,plat_timer_setup
> > Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> > Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> > Memory: 29012k/32768k available (1798k kernel code, 3756k reserved, 369k
> > data, 900k init, 0k highmem)
> > Mount-cache hash table entries: 512
> > NET: Registered protocol family 16
> > Generic PHY: Registered new driver
> > Time: MIPS clocksource has been installed.
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> > TCP established hash table entries: 1024 (order: 1, 8192 bytes)
> > TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> > TCP: Hash tables configured (established 1024 bind 1024)
> > TCP reno registered
> > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > io scheduler noop registered
> > io scheduler anticipatory registered (default)
> > io scheduler deadline registered
> > io scheduler cfq registered
> > Serial: optrann serial driver $Revision: 1.0
> > uart_register_driver finished
> > ttyS0 at MMIO map 0xbf004000 mem 0xbf004000 (irq = 23) is a UART 0
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > nbd: registered device at major 43
> > optrann_fe_ether Ethernet driver, V1.00
> > FE:dmac_regs =0xbf014000,msg_regs=0xbf028000, irq=26
> > FE MAC: 00:aa:aa:bb:bb:99
> > TCP cubic registered
> > Freeing unused kernel memory: 900k freed
> > ramdisk_execute_command=/linuxrc, execute_command=<NULL>
> > Bad pte = 0135c79f, process = linuxrc, vm_flags = 100073, vaddr =
> > 2aaae000
> > Call Trace:
> > [<80048d70>] dump_stack+0x8/0x34
> > [<8009ebb0>] vm_normal_page+0x68/0x90
> > [<8009f850>] unmap_vmas+0x1e8/0x5e8
> > [<800a3428>] unmap_region+0x9c/0x184
> > [<800a4268>] do_munmap+0x1b0/0x25c
> > [<800a4358>] sys_munmap+0x44/0x70
> > [<8004af40>] stack_done+0x20/0x3c
> > Bad pte = 0135e79f, process = linuxrc, vm_flags = 100073, vaddr =
> > 2aaae000
> > Call Trace:
> > [<80048d70>] dump_stack+0x8/0x34
> > [<8009ebb0>] vm_normal_page+0x68/0x90
> > [<8009f850>] unmap_vmas+0x1e8/0x5e8
> > [<800a3428>] unmap_region+0x9c/0x184
> > [<800a4268>] do_munmap+0x1b0/0x25c
> > [<800a4358>] sys_munmap+0x44/0x70
> > [<8004af40>] stack_done+0x20/0x3c
> > Bad pte = 0026079f, process = linuxrc, vm_flags = 100073, vaddr =
> > 2aaae000
> > Call Trace:
> > [<80048d70>] dump_stack+0x8/0x34
> > [<8009ebb0>] vm_normal_page+0x68/0x90
> > [<8009f850>] unmap_vmas+0x1e8/0x5e8
> > [<800a3428>] unmap_region+0x9c/0x184
> > [<800a4268>] do_munmap+0x1b0/0x25c
> > [<800a4358>] sys_munmap+0x44/0x70
> > [<8004af40>] stack_done+0x20/0x3c
> >  
> > .........
> >  
> > 
> > Best,
> > Figo.zhang
> > 
> 
> 
