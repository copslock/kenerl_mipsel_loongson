Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 14:29:07 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:48819 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225229AbUHWN3D>;
	Mon, 23 Aug 2004 14:29:03 +0100
Received: from drow by nevyn.them.org with local (Exim 4.34 #1 (Debian))
	id 1BzEsX-0008AN-2a; Mon, 23 Aug 2004 09:28:53 -0400
Date: Mon, 23 Aug 2004 09:28:53 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823132853.GA31354@nevyn.them.org>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <20040819221646.GC8737@mvista.com> <16678.163.774841.111369@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16678.163.774841.111369@arsenal.mips.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 20, 2004 at 02:46:11PM +0100, Dominic Sweetman wrote:
> I guess our main message was that we felt it would be a mistake just
> to add a thread register to o32 (which produces a substantially
> incompatible new ABI anyway).

Completely agree...

> Until that all works, what we had in mind is that we'd do NPTL over
> o32 by defining a system call to return a per-thread ID which is or
> can be converted into a per-thread data pointer.  We suspected that
> NPTL's per-thread-data model allows the use of cunning macros or
> library functions to make that look OK.
> 
> Ought we to go further and see exactly how that can be done?

It shouldn't be at all hard.  The way NPTL's __thread support works,
the only things that should have to know where the TLS base is are
(A) GCC, so it can load it and (B) GDB, via some new ptrace op.  I
don't know if you'd want to open-code the syscall or take the overhead
of a function call.  Ralf had some ideas?

-- 
Daniel Jacobowitz
