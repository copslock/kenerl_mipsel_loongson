Received:  by oss.sgi.com id <S553835AbRAYMnY>;
	Thu, 25 Jan 2001 04:43:24 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:26643 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553842AbRAYMnG>;
	Thu, 25 Jan 2001 04:43:06 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D9057800; Thu, 25 Jan 2001 13:42:59 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8D8C8EE9C; Thu, 25 Jan 2001 13:43:31 +0100 (CET)
Date:   Thu, 25 Jan 2001 13:43:31 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: OOps - very obscure
Message-ID: <20010125134331.A11489@paradigm.rfc822.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124165919.C15348@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 24, 2001 at 04:59:19PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 04:59:19PM +0100, Florian Lohoff wrote:

> Decoded this is:

> >>RA;  00000000 Before first symbol
> >>PC;  00000000 Before first symbol
> Trace; 88028344 <sys_nanosleep+190/24c>
> Trace; 8800fa88 <stack_done+1c/38>

I am trying to track this down a bit more:

with strace (very old version) 

rt_sigaction(34, {SIG_DFL}, NULL, 16)   = 0
rt_sigprocmask(SIG_BLOCK, [], NULL, 16) = 0
sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
[... repeated this 2 lines ...]

Every 1000 lines or something:

nanosleep({0, 2000001}, NULL)           = 0

But with strace it doesnt crash it seems at least not within 10 Minutes
i let it run ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
