Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 14:54:13 +0100 (BST)
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:63877 "EHLO
	ch-smtp01.sth.basefarm.net") by ftp.linux-mips.org with ESMTP
	id S20039679AbWJXNyH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 14:54:07 +0100
Received: from c83-250-8-219.bredband.comhem.se ([83.250.8.219]:45891 helo=mail.ferretporn.se)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <creideiki+linux-mips@ferretporn.se>)
	id 1GcMjD-0004BI-6C; Tue, 24 Oct 2006 15:54:06 +0200
Received: from www.ferretporn.se (unknown [192.168.0.3])
	by mail.ferretporn.se (Postfix) with ESMTP id F4051D247;
	Tue, 24 Oct 2006 15:53:55 +0200 (CEST)
Received: from 136.163.203.3
        (SquirrelMail authenticated user creideiki)
        by www.ferretporn.se with HTTP;
        Tue, 24 Oct 2006 15:53:56 +0200 (CEST)
Message-ID: <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se>
In-Reply-To: <20061023224318.GA1732@linux-mips.org>
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se>
    <20061022232316.GA19127@linux-mips.org>
    <20061023001947.GA10853@linux-mips.org>
    <200610232330.23498.creideiki+linux-mips@ferretporn.se>
    <20061023224318.GA1732@linux-mips.org>
Date:	Tue, 24 Oct 2006 15:53:56 +0200 (CEST)
Subject: Re: Extreme system overhead on large IP27
From:	"Karl-Johan Karlsson" <creideiki+linux-mips@ferretporn.se>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Scan-Result: No virus found in message 1GcMjD-0004BI-6C.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1GcMjD-0004BI-6C 3847c637f0e5505813664be8b1572174
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

On Tue, October 24, 2006 00:43, Ralf Baechle wrote:

> If you reduce your system to just 4 processors, do you also have that
> extremly high overhead?  The reason I'm asking is that my own Origin 200
> system has just 4 processors.

I can't get physical access to the system to pull out CPU boards today, so
I did the best I could do remotely - powered down all modules but one and
am now running a kernel built with support for only 4 of the 8 remaining
R12000 CPU:s.

Overhead is not as extreme as with more CPU:s, but still high. Running
four copies of "md5sum /dev/zero", top shows around 95% useful work and 5%
system overhead per CPU, while a "make -j4" of the kernel gives me 20-30%
system and 70-80% user time (down from a maximum of 80% system time with
all 32 CPU:s).

This is still on the Gentoo 2.6.17.10 kernel, by the way (which is a
mips-git snapshot from 2006-06-18 plus extra patches from e.g.
<URL:http://ftp.du.se/pub/os/gentoo/distfiles/mips-sources-generic_patches-1.25.tar.bz2>).
I tried a git snapshot from earlier today, but the only thing that kernel
did was print the NUMA-link topology and then hang.

Now that I actually look at Gentoo's patchset, I see there's a large patch
(misc-2.6.17-ioc3-metadriver-r26.patch) touching serial and ethernet
drivers for the IOC3. Perhaps the snapshot actually did boot, but just
couldn't talk to me without that patch? The patch doesn't apply to the
current git, though, so I think I'll leave that to someone who knows what
they're doing.

-- 
Karl-Johan Karlsson
