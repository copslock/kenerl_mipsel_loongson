Received:  by oss.sgi.com id <S553836AbRAHQfi>;
	Mon, 8 Jan 2001 08:35:38 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:28661 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553817AbRAHQfQ>; Mon, 8 Jan 2001 08:35:16 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870731AbRAHQZN>; Mon, 8 Jan 2001 14:25:13 -0200
Date:	Mon, 8 Jan 2001 14:25:13 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: User applications
Message-ID: <20010108142513.C886@bacchus.dhis.org>
References: <3A598AFC.83204F56@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A598AFC.83204F56@mips.com>; from carstenl@mips.com on Mon, Jan 08, 2001 at 10:40:12AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 10:40:12AM +0100, Carsten Langgaard wrote:

> When a new user process is started will its user space be cleared by the
> kernel or is there a potential leak from an older user process ?

A new process is started by the clone(2) or fork(2) syscalls.  Module the
options that can be passed to clone(2) the two only create an identical copy
of the invoking process, so they're designed to leak information by design ;-)

execve(2) replaces the existing mappings with a new process image loaded
from files plus a newly created stack area.  No old mappings survive, so
there in memory there is no information leak.

> What about the registers values, are they cleared for each new user
> application or will it simply contain the current value it got when the
> user application is started ?

We make no attempt at the integer registers for a new process, so some
information might be leaked in registers.  All the callee saved registers
will be passed unchanged to the child process; the caller saved registers
except those that are used as syscall return values will return random
garbage.  Floating point registers will be cleared with SNANs as soon
as the process is attempting to use a FPU for the first time, that is
we won't leak information via fpu registers.

(Ooops, we're not Orange Book B1 compliant, how sad ;-)

> How can you flush the data and instruction cashes from a user application ?

cacheflush(2).  See man page.

  Ralf
