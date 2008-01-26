Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jan 2008 14:40:29 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:46038 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28582361AbYAZOkT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Jan 2008 14:40:19 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JImCf-0008U9-00; Sat, 26 Jan 2008 15:40:17 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9D145C2F8B; Sat, 26 Jan 2008 15:39:49 +0100 (CET)
Date:	Sat, 26 Jan 2008 15:39:49 +0100
To:	Kumba <kumba@gentoo.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080126143949.GA6579@alpha.franken.de>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479AA532.5040603@gentoo.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Jan 25, 2008 at 10:12:50PM -0500, Kumba wrote:
> f  - cache barriers on load and stores (-mr10k-cache-barrier=2)
> f2 - cache barriers on loads only (-mr10k-cache-barrier=1)
> f3 - no cache barriers (flag omitted from gcc)
> 
> Running 'f' and 'f2' generates an "Illegal instruction" error, then drops 
> back to the command line, while 'f3' hangs the box.  This is an IP28 

no suprise here. As Ralf already noted cache barrier is a restricted
instruction, it will always cause a illegal instruction when used
in user space. Nevertheless it looks like all IP28 are affected
by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
and this avoids triggering the hang.

> FYI, CPU rev in this machine is R10000 v2.5.  I think that's the same for 
> all IP28 systems.

Flo and mine also have rev 2.5 cpus.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
