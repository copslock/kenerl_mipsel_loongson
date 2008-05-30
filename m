Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 12:40:24 +0100 (BST)
Received: from p549F7A8A.dip.t-dialin.net ([84.159.122.138]:52688 "EHLO
	p549F7A8A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022176AbYE3LkW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 12:40:22 +0100
Received: from [87.79.32.166] ([87.79.32.166]:36874 "EHLO mx03.syneticon.net")
	by lappi.linux-mips.net with ESMTP id S1109597AbYE3Ljv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2008 13:39:51 +0200
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id D5D6E95D1;
	Fri, 30 May 2008 13:39:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id suu1FMDyk9go; Fri, 30 May 2008 13:39:18 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b67db.pool.mediaWays.net [77.11.103.219])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Fri, 30 May 2008 13:39:18 +0200 (CEST)
Message-ID: <483FE764.1090901@wpkg.org>
Date:	Fri, 30 May 2008 13:39:16 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Nicolas Schichan <nschichan@freebox.fr>
CC:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>,
	openwrt-devel@lists.openwrt.org
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org> <200805291347.05196.nschichan@freebox.fr> <483F0EF3.3060500@wpkg.org> <200805301327.11925.nschichan@freebox.fr>
In-Reply-To: <200805301327.11925.nschichan@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Nicolas Schichan schrieb:
> On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
>> # kexec -e
>> b44: eth0: powering down PHY
>> Starting new kernel
>> Will call new kernel at 00305000
> 
> The calling address of the kernel looks quite wrong, it should clearly
> be inside the KSEG0 zone. could  you please indicate the output of the
> command "mips-linux-readelf -l vmlinux" ?

# uname -m
mips
# readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0x80251b50
There are 2 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   LOAD           0x001000 0x80001000 0x80001000 0x2dd07a 0x303250 RWE 
0x2000
   NOTE           0x000000 0x00000000 0x00000000 0x00000 0x00000 R   0x4

  Section to Segment mapping:
   Segment Sections...
    00     .text __ex_table __dbe_table .rodata .pci_fixup __ksymtab 
__ksymtab_gpl __ksymtab_strings __param .data .data.cacheline_aligned 
.init.text .init.data .init.setup .initcall.init .con_initcall.init 
.exit.text .init.ramfs .bss
    01

-- 
Tomasz Chmielewski
http://wpkg.org
