Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 12:08:17 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:25099 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225281AbVCPMHw>; Wed, 16 Mar 2005 12:07:52 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2GC6oZN011092;
	Wed, 16 Mar 2005 12:06:50 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2GC6mKL011091;
	Wed, 16 Mar 2005 12:06:48 GMT
Date:	Wed, 16 Mar 2005 12:06:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ed Martini <martini@c2micro.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: initrd problem
Message-ID: <20050316120647.GB8563@linux-mips.org>
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423763B9.2000907@c2micro.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 15, 2005 at 02:37:45PM -0800, Ed Martini wrote:

> Ok.  Then let's get rid of it completly, and provide a replacement that 
> works.

Way to go.

> There were vestiges of embedded initrd in the ld script that were 
> confusing when trying to sort things out. That, in conjunction with 
> Documentation/initrd.txt made it hard to discover early user space and 
> initramfs when coming from the old world (2.4).

Correct and I've applied that part of your patch already while thinking
about the problem you describe below.

> Also, unless you move the location of .init.ramfs, it gets freed twice, 
> leading to a panic.

Interesting one.  When I tested the code recently it did work for me and
it shouldn't have changed since.  The way this is supposed to work is
by setting the page_count to 1 by using set_page_count and unmarking the
page as reserved, so after that point a free_page should actually succeed -
even if done twice as you've observed, first in populate_rootfs then
once more in free_initmem.

It seems a frighteningly bad idea though since it relies on no memory
from the initrd range being allocated between the two calls - or it would
end being freed by force, in use or not.  On startup Linux tends to
allocate memory starting from high address towards low addresses which
must be why we usually get away with this one.

> From the documentation alone it's impossible to figure out how to build 
> your initramfs.  In various places the docs refer to the initial 
> executable as /linuxrc, /kinit, /init, and possibly others.  If you read 
> init/main.c you see that for an initramfs, your initial process will be 
> started from /init.

I guess I read the code so I didn't notice the lacking qualities of the
documentation ...

  Ralf
