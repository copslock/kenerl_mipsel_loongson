Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Aug 2008 12:14:44 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:3225 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20031503AbYHQLOk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Aug 2008 12:14:40 +0100
Received: (qmail invoked by alias); 17 Aug 2008 11:14:33 -0000
Received: from mnhm-590f7207.pool.einsundeins.de (EHLO halden.box) [89.15.114.7]
  by mail.gmx.net (mp023) with SMTP; 17 Aug 2008 13:14:33 +0200
X-Authenticated: #1045983
X-Provags-ID: V01U2FsdGVkX1/5451ljD35390kiqsrV6Bo311gb6qoISHqyWH2D1
	CUm0H2QJX0HvnH
Message-ID: <48A8081A.4080609@gmx.de>
Date:	Sun, 17 Aug 2008 13:14:34 +0200
From:	Helge Deller <deller@gmx.de>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Christoph Hellwig <hch@lst.de>, Kyle McMartin <kyle@mcmartin.ca>
CC:	linux-mips@linux-mips.org, linux-parisc@vger.kernel.org
Subject: Re: missing compat_sys_ptrace conversions for mips and parisc
References: <20080817022924.GA23625@lst.de>
In-Reply-To: <20080817022924.GA23625@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deller@gmx.de
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> Currently mips and parisc are the only architectures not yet converted
> to the generic compat_sys_ptrace.  The conversion is rather trivial and
> only involves splitting the current compat_ptrace handler into a
> compat_arch_ptrace with all the meat and the existing compat_sys_ptrace
> that does all the boilerplate code, just like the generic sys_ptrace.
> To get the generic compat_sys_ptrace you have to add a
> 
> 	#define __ARCH_WANT_COMPAT_SYS_PTRACE
> 
> to ptrace.h for now, but once mips and parisc are converted this will of
> course be removed.  Take a look at the powerpc conversion as an example:
> 
> 	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git&a=commitdiff&h=81e695c026eeda9a97e412fa4f458e5cab2f6c85

I could take care of this for parisc. Just looked into the code and it 
seems it could cleanup the code nicely as well.

But I don't want to step on Kyle's toe, since I assume he prepares the 
asm-parisc/ move in the parisc-2.6 git tree during the next days.

Kyle: any comments? Should I prepare some patches? Or do you want to 
take care of the compat_sys_ptrace yourself?

Helge
