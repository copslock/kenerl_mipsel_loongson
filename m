Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 08:49:25 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:57575 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28787486AbYISHtR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 08:49:17 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Kgajq-0003dq-00; Fri, 19 Sep 2008 09:49:14 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id A2DA0C2C01; Fri, 19 Sep 2008 09:48:51 +0200 (CEST)
Date:	Fri, 19 Sep 2008 09:48:51 +0200
To:	"Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: execve errno setting on MIPS
Message-ID: <20080919074851.GA26907@alpha.franken.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56DA35@insardxms01.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56DA35@insardxms01.ap.sony.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 08:57:17AM +0530, Sadashiiv, Halesh wrote:
> >And it looks like the ARG_MAX limit is bigger than my installed glibc
> >thinks, because it works at least on x86. When I increase the array two
> >2 * ARG_MAX I'll get the wanted E2BIG.
>  
>  Yes, on MIPS we need to increase the ARM_MAX to 2*ARG_MAX to get E2BIG.

I've tested only on x86 and I also needed to use 2 * ARG_MAX. This all
depends on the installed glibc, which provides ARG_MAX and the installed
kernel, which sets the rules independand from glibc. If you look at
fs/exec.c in the kernel source, you see these rules. Current kernels
for example have a limit of 

#define MAX_ARG_STRINGS 0x7FFFFFFF

for the number of strings. Looks like E2BIG is triggered by the space
needed for the strings (I only had a quick look at exec.c).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
