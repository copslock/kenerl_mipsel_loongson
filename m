Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 07:10:52 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:46995 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24207392AbYLRHKs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2008 07:10:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBI7AcAo027662;
	Thu, 18 Dec 2008 07:10:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBI7AcbO027661;
	Thu, 18 Dec 2008 07:10:38 GMT
Date:	Thu, 18 Dec 2008 07:10:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Joseph S. Myers" <joseph@codesourcery.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: N32 fallocate syscall
Message-ID: <20081218071038.GA11823@linux-mips.org>
References: <Pine.LNX.4.64.0812180009000.31179@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812180009000.31179@digraph.polyomino.org.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 18, 2008 at 12:14:12AM +0000, Joseph S. Myers wrote:

> The N32 syscall table uses sys_fallocate instead of sys32_fallocate.  
> However, glibc expects to be using the syscall version with 32-bit 
> arguments on N32, which should work with sys32_fallocate but not 
> sys_fallocate.
> 
> What should the N32 interface for this syscall be?  My inclination is that 
> glibc is right not to do anything special and different from other 32-bit 
> ABIs here, and so sys32_fallocate should be used.
> 
> (glibc is also expecting the 32-bit version for N64, but that's a clear 
> bug in glibc that I'll be fixing.)

There are exceptions such as pipe(2) or clone(2) but the calling convention
of most syscalls in all ABIs is following the C calling conventions for the
respective ABI, so N32 fallocate(2) receives it's syscalls like a N32
function call would.

o32-style arguments would require splitting the two 64-bit loff_t arguments
to be split into 2 32-bit halfs each in userspace and those pairs then to
be re-assembled into 64-bit arguments in kernel.  Bit messy, no?

  Ralf
