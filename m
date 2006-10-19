Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 13:56:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22701 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038429AbWJSM4F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 13:56:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9JCuO1L005171;
	Thu, 19 Oct 2006 13:56:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9JCuNfA005170;
	Thu, 19 Oct 2006 13:56:23 +0100
Date:	Thu, 19 Oct 2006 13:56:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pramod P K <pra.engr@gmail.com>
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: OOPS with JFFS2, MIPS
Message-ID: <20061019125623.GA24108@linux-mips.org>
References: <417f1b740610190242h2a39da81l7f2763e79e457736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417f1b740610190242h2a39da81l7f2763e79e457736@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 19, 2006 at 03:12:49PM +0530, Pramod P K wrote:
> Date:	Thu, 19 Oct 2006 15:12:49 +0530
> From:	"Pramod P K" <pra.engr@gmail.com>
> To:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
> Subject: OOPS with JFFS2, MIPS
> Content-Type: multipart/alternative; 
> 	boundary="----=_Part_217232_6585938.1161250969461"
> 
> Iam using MIPS, Big Endian, with AMD/Fujitsu Spansion CFI flash.
> 
> I have Rootfs(jffs2) in flash, Linux-2.6.15 in RAM. Trying to mount Rootfs
> (jffs2). but gives OOPS, and then kernel panic !!
> I have traced the disassembled part of it. Got the location of OOPS but dont
> know why
> 
> Please .. help me out.
> 
> 
> MSP flash device "flash0": 0x00800000 at 0x1f800000
> flash0: Found 1 x16 devices at 0x0 in 8-bit bank
> Amd/Fujitsu Extended Query Table at 0x0040
> Using buffer write method
> flash0: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 6 MTD partitions on "flash0":
> 0x00480000-0x007f0000 : " General partition"
> mtd: Giving out device 0 to  General partition
> 0x00400000-0x00470000 : " pmon"
> mtd: Giving out device 1 to  pmon
> 0x00470000-0x00480000 : " pmon script"
> mtd: Giving out device 2 to  pmon script
> 0x00010000-0x00400000 : " Linux"
> mtd: Giving out device 3 to  Linux
> 0x007f0000-0x00800000 : " Copyprotected space end"
> mtd: Giving out device 4 to  Copyprotected space end
> 0x00000000-0x00010000 : " Copyprotected space start"
> mtd: Giving out device 5 to  Copyprotected space start
> MSP flash device "flash1": 0x00bf0000 at 0x1e000000
> flash1: Found 1 x16 devices at 0x0 in 8-bit bank
> Amd/Fujitsu Extended Query Table at 0x0040
> Using buffer write method
> flash1: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 1 MTD partitions on "flash1":
> 0x00000000-0x00bf0000 : " Root Filesystem jffs2"
> mtd: Giving out device 6 to  Root Filesystem jffs2
> 
> ...........
> ..........
> <skipped some statements here>
> ..........
> ..........
> 
> CPU 0 Unable to handle kernel paging request at virtual address 00000000,
> epc == 80121f30, ra == 80121fe0
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 00000000 00000003 00000000
> $ 4   : 80490554 00000003 00000001 00000000
> $ 8   : ffffffff 87e02488 00000000 00000008
> $12   : 8048bb80 87e02480 ffffffff 00000010
> $16   : 00000001 0000fff8 00000001 80490554
> $20   : 00000000 00000000 00000003 80490500
> $24   : 00000000 80298d08
> $28   : 8048a000 8048ba98 8048ba98 80121fe0
> Hi    : 00000000
> Lo    : 000000bf
> epc   : 80121f30 __wake_up_common+0x44/0xb8     Not tainted
> ra    : 80121fe0 __wake_up+0x3c/0x98

A good old NULL pointer dereferenced by a generic kernel function which
almost certainly itself is not the culprit, so probably was passed bad
arguments.

  Ralf
