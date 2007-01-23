Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 16:12:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53393 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044434AbXAWQM2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 16:12:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NGCR4X021044;
	Tue, 23 Jan 2007 16:12:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NGCQ05021043;
	Tue, 23 Jan 2007 16:12:26 GMT
Date:	Tue, 23 Jan 2007 16:12:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][RFC] Move some kernel globals from asm file to C file.
Message-ID: <20070123161226.GA20530@linux-mips.org>
References: <20070124.003859.126141727.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070124.003859.126141727.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 24, 2007 at 12:38:59AM +0900, Atsushi Nemoto wrote:

> 801ce000 B fw_arg3
> 801ce004 B fw_arg1
> 801cf000 B swapper_pg_dir
> 801d0000 B invalid_pte_table
> 801d1000 B fw_arg2
> 801d1008 B kernelsp
> 801d1010 B fw_arg0
> 801d1018 B pgd_current
> 801d1020 A __bss_stop
> 801d1020 A _end
> 
> It looks less efficient while fw_arg[0-3] are all 4 byte.
> 
> Is there any point on declaring those symbols in asm file?  If
> nothing, how about moving them to C file?  And I can not see why
> kernel_sp and pgd_current have 8-byte size even on 32-bit kernel.
> 
> Here is a proposal patch.  Comments?

Looks ok but I think all the pagetable stuff should move to somewhere
like arch/mips/mm/init.c.

  Ralf
