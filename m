Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2003 03:43:27 +0100 (BST)
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([IPv6:::ffff:66.93.172.17]:38540
	"EHLO nevyn.them.org") by linux-mips.org with ESMTP
	id <S8224861AbTGKCnZ>; Fri, 11 Jul 2003 03:43:25 +0100
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19ansH-0004lf-00; Thu, 10 Jul 2003 22:43:05 -0400
Date: Thu, 10 Jul 2003 22:43:05 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: renwei <renwei@huawei.com>, linux-mips@linux-mips.org
Subject: Re: [patch]: gdb/insight 5.3 buggy   in kernel module debug
Message-ID: <20030711024305.GA18249@nevyn.them.org>
References: <003501c34526$f5adfcc0$6efc0b0a@huawei.com> <20030709123657.GA30305@linux-mips.org> <000701c34752$3263d680$6efc0b0a@huawei.com> <20030711023101.GA10643@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711023101.GA10643@linux-mips.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2003 at 04:31:01AM +0200, Ralf Baechle wrote:
> On Fri, Jul 11, 2003 at 10:14:44AM +0800, renwei wrote:
> 
> > Here's my patch to this problem, change the read pc on mips32 cpu.
> 
> Don't send GDB patches to me, I'm not maintaining GDB; drow@mvista.com is
> probably a better address.
> 
> Also a standard rant - never ever send ed-style patches; any maintainer
> will probably just drop them.

Please don't send them to me either - send them to
gdb-patches@sources.redhat.com, where they belong.

Andrew will tell you that the 64-bit signed PC is correct.  The bug is
in whatever code is not sign extending, probably in the symbol reader. 
If you're using stabs try dwarf-2 instead.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
