Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Sep 2017 20:26:32 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:2039 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990495AbdI3S0Zj5OAf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Sep 2017 20:26:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 1F6C93F41D;
        Sat, 30 Sep 2017 20:26:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kgdWC-qf4-Em; Sat, 30 Sep 2017 20:26:12 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id B91C13F43C;
        Sat, 30 Sep 2017 20:26:09 +0200 (CEST)
Date:   Sat, 30 Sep 2017 20:26:08 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170930182608.GB7714@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
 <20170922163753.GA2415@localhost.localdomain>
 <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

> > I suspect 63:32 are the critical bits of the upper 96 bits since SD/LD
> > is sufficient. Summery of observations thus far: save/restore works with
> > SQ/LQ and SD/LD, but not SW/LW, in a 32-bit kernel ceteris paribus.
> 
>  This does look intriguing.

I believe the simple answer to this mystery is that addresses are not
supposed to be sign-extended, given the look of $31 below. What are
your thoughts on this?

To delay and recover from the trap I chose printk_delay_msec as an
(arbitrary) trigger with "echo 1 >/proc/sys/kernel/printk_delay".

.macro check_reg reg
	.extern	printk_delay_msec
	sll	$27, \reg, 0
	beq	$27, \reg, 1f
	nop
	lw	$27, printk_delay_msec
	beq	$27, $0, 1f
	nop
	.set	at=$27
	sw	$0, printk_delay_msec
	.set	noat
	break	12
	nop
1:
.endm

Break instruction in kernel code[#1]:
CPU: 0 PID: 94 Comm: echo Not tainted 4.12.0+ #510
task: 81fb5500 task.stack: 81f70000
$ 0   :
 0000000000000000
 0000000000000020
 ffffffff8100a874
 ffffffff800beeb0
$ 4   :
 ffffffffffffffff
 000000000fb60000
 000000000082cb49
 0000000000000001
$ 8   :
 0000000000000875
 ffffffff80260684
 ffffffff80539f0c
 ffffffffffffff80
$12   :
 000000007f9582e0
 0000000077f1a2d0
 0000000000000000
 0000000000000000
$16   :
 ffffffff81500d80
 ffffffff81020be0
 ffffffff81f71dd8
 000000000fb79000
$20   :
 ffffffff805150c0
 000000000fb61000
 ffffffff814e59f8
 000000000fb60000
$24   :
 0000000000000000
 0000000077e4d67c                  
$28   :
 ffffffff81f70000
 ffffffff81f71bf8
 ffffffff815010f8
 00000000800bed80
Hi    : 00000000
Lo    : 00000048
epc   : 800beeb0 unmap_page_range+0x3cc/0x664
ra    : 00000000800bed80 unmap_page_range+0x29c/0x664
Status: 30018c03	KERNEL EXL IE 
Cause : 50000424 (ExcCode 09)
PrId  : 00002e42 (R5900)
Modules linked in:
Process echo (pid: 94, threadinfo=81f70000, task=81fb5500, tls=00adc0e0)
Stack : 8053a2e8 00000000 00000001 00000000 00000000 80520000 00000000 30018c01
        00000000 00000000 001fffff 80525f60 8100a874 ffffffff ffffffff ffffffff
        ffffffff ffffffff 0fb60000 00000000 0082cb49 00000000 00000001 00000000
        01000200 8025bfcc 014200ca 00000001 81f71c68 81f71c68 00000001 00000000
        00000002 81f71cb0 81f71d10 8025c010 00000000 30018c01 8053a2e8 00000000
        ...
Call Trace:
[<800beeb0>] unmap_page_range+0x3cc/0x664
[<8025bfcc>] simple_strtoull+0x34/0x68
[<8025c010>] simple_strtoul+0x10/0x1c
Code: 1220ff6b  ae440008  8e220014 <30430001> 2442ffff  0223100a  8c420004  30420001  14400013 

---[ end trace e89f1298cab4fd73 ]---
Fixing recursive fault but reboot is needed!

Fredrik
