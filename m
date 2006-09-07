Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 05:03:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38602 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037483AbWIGEDM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 05:03:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8743jQL026224;
	Thu, 7 Sep 2006 06:03:45 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8743j85026223;
	Thu, 7 Sep 2006 06:03:45 +0200
Date:	Thu, 7 Sep 2006 06:03:44 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Erik Niessen <erik.niessen@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Weird output from pmap
Message-ID: <20060907040344.GC17965@linux-mips.org>
References: <f21fe8a50609042355o19ab7b50nb5717bfe0d358232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21fe8a50609042355o19ab7b50nb5717bfe0d358232@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 05, 2006 at 08:55:18AM +0200, Erik Niessen wrote:

> /helloworldmips(86)
> 00400000 (4 KB)        r-xp (00:0a 33243002)   linux/test/helloworldmips
> 10000000 (4 KB)        rw-p (00:0a 33243002)   linux/test/helloworldmips
> 10001000 (4 KB)        rwxp (00:00 0)        [heap]
> 2aaa8000 (20 KB)       r-xp (00:07 1795853)
> /lib/ld-uClibc-0.9.27.so<http://uclibc-0.9.27.so/>
> 2aaad000 (4 KB)        rw-p (00:00 0)
> 2aaed000 (4 KB)        rw-p (00:07 1795853)  /lib/ld-
> uClibc-0.9.27.so<http://uclibc-0.9.27.so/>
> 2aaee000 (48 KB)       r-xp (00:07 1795861)  /lib/libgcc_s.so.1
> 2aafa000 (252 KB)      ---p (00:00 0)
> 2ab39000 (4 KB)        rw-p (00:07 1795861)  /lib/libgcc_s.so.1
> 2ab3a000 (368 KB)      r-xp (00:07 1795855)  /lib/libuClibc-0.9.27.so
> 2ab96000 (256 KB)      ---p (00:00 0)
> 2abd6000 (8 KB)        rw-p (00:07 1795855)  /lib/libuClibc- 0.9.27.so
> 2abd8000 (16 KB)       rw-p (00:00 0)
> 7fd49000 (84 KB)       rwxp (00:00 0)        [stack]
> mapped:   1076 KB writable/private: 128 KB shared: 0 KB
> 
> It seems that the bss segments of the shared libs are protected and mapped
> to the zero page. I don't see this
> when I run this on a linux pc. I have the following questions:
> - Why is this segment protected? Accessing results in a seg fault.

Protecting a bss segment doesn't make sense.

The address and the "---p" flags make me suspect your executable might
actually be wrong, so I suggest you check the binary with something like
readelf -S.

> - Why is it so big (252k/256K)?
> - How much memory is physically allocated for this segment?

None at this stage - the actuall allocation would happen lazily when
a page is touched first which of course doesn't ever happen in your
case.

  Ralf
