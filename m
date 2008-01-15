Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 23:13:57 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:37335 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20039479AbYAOXNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 23:13:48 +0000
Received: from lagash (88-106-203-79.dynamic.dsl.as9105.com [88.106.203.79])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 1648A48916;
	Wed, 16 Jan 2008 00:13:43 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JEuz7-0008AA-8f; Tue, 15 Jan 2008 23:14:21 +0000
Date:	Tue, 15 Jan 2008 23:14:21 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080115231421.GB9767@networkno.de>
References: <477E7DAE.2080005@raritan.com> <20080106.000725.75184768.anemo@mba.ocn.ne.jp> <4787AC3D.2020604@raritan.com> <20080112.211749.25909440.anemo@mba.ocn.ne.jp> <478CD639.3040307@raritan.com> <20080115161457.GB31107@networkno.de> <478D121C.4020701@raritan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <478D121C.4020701@raritan.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gregor Waltz wrote:
[snip]
> From where in the kernel image should execution begin?

Normally from kernel_entry, but your boot loader appears to start
from the begin of the code segment it loaded.

> Presuming that the output of "objdump -d" reflects the disassembled  
> binary from the beginning in order, it looks like my 2.6 kernel is  
> running straight into run_init_process as the first real code executed.  
> From what I have seen in the kernel code, run_init_process should be  
> jumped to far later in the boot process. If what I am thinking is  
> correct, then it also explains why the failure happens in kernel_execve.
>
> I have also included the start of my working kernel, which has _ftext  
> with non-zero data as its first entry. Is the _ftext the ELF header or  
> some other info for the boot loader?

This is likely code which jumps to kernel_entry (but the disassembler
doesn't know since it sees no function symbol, so it defaults to data).

> Thanks
>
>
> linux-2.6.23.9/vmlinux:     file format elf32-tradlittlemips
>
> Disassembly of section .text:
>
> 80020000 <run_init_process-0x400>:
>        ...

Enabling CONFIG_BOOT_RAW, as Atsushi already suggested, would have
added a jump to kernel_entry in this place.

> 80020400 <run_init_process>:
> 80020400:       3c028033        lui     v0,0x8033
> 80020404:       3c068033        lui     a2,0x8033
> 80020408:       244594dc        addiu   a1,v0,-27428


Thiemo
