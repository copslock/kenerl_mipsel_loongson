Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 00:25:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64910 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039571AbWJGXZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 00:25:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k97NPQkH031447;
	Sun, 8 Oct 2006 00:25:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k97NPK5u031446;
	Sun, 8 Oct 2006 00:25:20 +0100
Date:	Sun, 8 Oct 2006 00:25:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
Cc:	linux-mips@linux-mips.org
Subject: Re: /proc/cpuinfo makes false assumptions of uniformity on IP27
Message-ID: <20061007232520.GA23815@linux-mips.org>
References: <34353.136.163.203.3.1160138023.squirrel@www.ferretporn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34353.136.163.203.3.1160138023.squirrel@www.ferretporn.se>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 06, 2006 at 02:33:43PM +0200, Karl-Johan Karlsson wrote:

> 1. What about the CPU feature test macros in
> include/asm-mips/cpu-features.h? They claim
>   /*
>    * SMP assumption: Options of CPU 0 are a superset of all processors.
>    * This is true for all known MIPS systems.
>    */
> but is that really true, even on a mixed R12k/R10k system?

To the degree that is actually matters, yes.  For cache managment on
Origins the size of the S-cache doesn't matter, that is it is not
relevant if scache_size(cpu 0) > or < scache_size(cpu 1).  It gets a
little hairy for stuff like performance counters where the R10000
supports a different set of events than its successors; that is not
something oprofile can deal with ...

  Ralf
