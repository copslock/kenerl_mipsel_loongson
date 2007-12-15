Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Dec 2007 20:11:15 +0000 (GMT)
Received: from host140-217-dynamic.16-79-r.retail.telecomitalia.it ([79.16.217.140]:40358
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20026001AbXLOULG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Dec 2007 20:11:06 +0000
Received: from giuseppe by eppesuigoccas.homedns.org with local (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J3dIY-00012b-JI; Sat, 15 Dec 2007 21:07:46 +0100
Date:	Sat, 15 Dec 2007 21:07:46 +0100
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ricardo Mendoza <ricmm@kanux.com>, linux-mips@linux-mips.org
Subject: Re: Still no 2.6.24 on ip32
Message-ID: <20071215200746.GA3989@eppesuigoccas.homedns.org>
References: <1193599031.14874.1.camel@scarafaggio> <20071029150625.GB4165@linux-mips.org> <1194268551.4842.3.camel@scarafaggio> <1194281699.4192.3.camel@casa> <1197287929.17265.6.camel@scarafaggio> <475D7FE2.7080703@kanux.com> <1197371095.7889.24.camel@scarafaggio> <475E9012.1010504@kanux.com> <20071211204437.GA14243@eppesuigoccas.homedns.org> <475EC648.8030906@kanux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475EC648.8030906@kanux.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Ricardo,

On Tue, Dec 11, 2007 at 01:18:00PM -0400, Ricardo Mendoza wrote:
> Giuseppe Sacco wrote:
> > On Tue, Dec 11, 2007 at 09:26:42AM -0400, Ricardo Mendoza wrote:
> >> Giuseppe Sacco wrote:
> >>
> >>> I just checked that my repository is up to date, so my problem is still
> >>> there (thus I don't know if it is the same problem you fixed).
> >>>
> >>> BTW, what was the problem you fixed? I would like to have a look to it,
> >>> to better understand what's going on there.
> >> Well I just updated to see if anything had broken in the past few days,
> >> but I don't seem to be hitting that error of yours. Could you send your
> >> config to see if I can reproduce it?
> > 
> > Yes, sure: http://eppesuigoccas.homedns.org/~giuseppe/debian/config-2.6.24-rc4-ip32.bz2
> > but please note that the problem is present in every kernel since 2.6.24-rc1
> > 
> > my boot stanza in arcboot is:
> > 
> > label=test
> >   image=/boot/vmlinux-2.6.24-rc4-gs1
> >   append="root=/dev/sda1 ro video=gbefb:1024x768-16@60 debug initcall_debug console=tty0 console=ttyS1,115200"
> 
> Ran it without problems, can't get into much detail right now but I the
> problem you are seeing is more than likely caused by your other patch to
> serial_core.c.

I made a few run, recompiled everything from scratch, without my patch,
but I always had the system loop on IRQ #13 while booting.

Do you test on ip32? SGI O2 R5000@200? I would like to know any difference
between our test environments.

Thanks,
Gisueppe
