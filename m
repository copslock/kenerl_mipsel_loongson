Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 20:34:54 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:12501 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225002AbVCUUej>;
	Mon, 21 Mar 2005 20:34:39 +0000
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DDTbp-0001qb-3N; Mon, 21 Mar 2005 15:34:45 -0500
Date:	Mon, 21 Mar 2005 15:34:45 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: NPTL support for the kernel
Message-ID: <20050321203445.GA7082@nevyn.them.org>
References: <20050316141151.GA23225@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316141151.GA23225@nevyn.them.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 16, 2005 at 09:11:52AM -0500, Daniel Jacobowitz wrote:
> Here's a kernel patch to enable NPTL support.  This doesn't include Maciej's
> uber-fast rdhwr emulation; I believe we ought to include both the fast and
> slow paths, since the slow path will handle use of other destination
> registers.  Changes:
> 
>   - Clone takes five arguments, not four.  Um, this bit is gross.
>   - New syscall sys_set_thread_area.  Only glibc uses this.
>   - Emulation of the rdhwr instruction.  This version is only loosely
>     based on the emulation on the malta branch; the major difference
>     is that I fixed ll/sc/rdhwr emulation in branch delay slots.
>     GCC 4.1 will generate rdhwr in branch delay slots in some
>     conditions.
>   - PTRACE_GET_THREAD_AREA support for GDB.

Ping?

-- 
Daniel Jacobowitz
CodeSourcery, LLC
