Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 13:40:05 +0000 (GMT)
Received: from p508B5FA1.dip.t-dialin.net ([IPv6:::ffff:80.139.95.161]:4498
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225263AbSLQNkE>; Tue, 17 Dec 2002 13:40:04 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBHDdxH27291;
	Tue, 17 Dec 2002 14:39:59 +0100
Date: Tue, 17 Dec 2002 14:39:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Long Li <long21st@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: .reginfo and .mdebug section
Message-ID: <20021217143959.B26794@linux-mips.org>
References: <20021217084303.20121.qmail@web40407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021217084303.20121.qmail@web40407.mail.yahoo.com>; from long21st@yahoo.com on Tue, Dec 17, 2002 at 12:43:03AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 12:43:03AM -0800, Long Li wrote:

> 1. I tried to compile some c code targetting mips4k,
> which is 32-bit ISA. However, the map file tells me
> that the compiled code are 64-bit, since the address
> are 64-bit.
> 
> 2. When I compiled the c code, I found in the mapfile
> that there are some sections called .reginfo and
> .mdebug. What are those sections? I would like to get
> rid of them. However, they still exists even if I
> deleted the '-g' option for gcc. Is there a way I can
> avoid the .reginfo and .mdebug sections?

.reginfo is MIPS ABI mandated brain damage described the register usage of
a given object or shared object.  I know of nothing that actually is using
these sections.  It's always just 24 bytes so not really worth alot of fuzz
though.  With some binutils versions you can remove this section with
objcopy --remove-section=.reginfo.  Some binutils version however will just
create a new .reginfo section during objcopy so with those this won't work.

.mdebug is the MIPS ABI mdebug stuff, debug information.  You should be
able to get rid of those with -g, at least my tools here don't create it
by default.

  Ralf
