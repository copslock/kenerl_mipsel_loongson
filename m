Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 18:10:03 +0000 (GMT)
Received: from p508B7DF8.dip.t-dialin.net ([IPv6:::ffff:80.139.125.248]:44220
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225344AbTJ0SKA>; Mon, 27 Oct 2003 18:10:00 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9RI9wNK025978;
	Mon, 27 Oct 2003 19:09:58 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9RI9vgT025977;
	Mon, 27 Oct 2003 19:09:57 +0100
Date: Mon, 27 Oct 2003 19:09:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Teresa Tao <TERESAT@TTI-DM.COM>
Cc: linux-mips@linux-mips.org
Subject: Re: question regarding bss section
Message-ID: <20031027180957.GA25797@linux-mips.org>
References: <92F2591F460F684C9C309EB0D33256FA01B750B3@trid-mail1.tridentmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92F2591F460F684C9C309EB0D33256FA01B750B3@trid-mail1.tridentmicro.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2003 at 09:44:05AM -0800, Teresa Tao wrote:

> I have several questions and hope somebody could help me with the answers:
> 1. how to use gcc to compile the user mode program with larger stack size?

Not at all.  Stack size is a resource limit which is set with can be
manipulated with setrlimit(2) or in bash with the ulimit command.  It
defaults to 8MB.

For pthread applications the stack size is a thead attribute, seem libc
manual.

> 2. Inside the user mode program, I have declared some gloabal data which
> is being put on the bss section and I would like to know whom initialize
> the bss section?

.bss is uninitialized.  Initialized data can't be in .bss.

> How big is the bss section? Under what kind of situation,

As big as needed for everything in it.

> the bss section data could be corrupted?

There's millions of ways of writing broken code.

> 3. What's the difference to compile the program with -G 0 option? That
> menas I don't use the $gp register, will there be any side effect?

-G 0 is the default for userspace.  Iow. passing the option changed nothing.

  Ralf
