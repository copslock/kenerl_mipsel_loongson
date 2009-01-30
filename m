Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 16:55:47 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:38632 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366209AbZA3Qzp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jan 2009 16:55:45 +0000
Received: (qmail 16061 invoked from network); 30 Jan 2009 17:55:44 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 30 Jan 2009 17:55:44 +0100
Date:	Fri, 30 Jan 2009 17:56:20 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: GCC-4.3.3 sillyness
Message-ID: <20090130175620.72dd4252@scarran.roarinelk.net>
In-Reply-To: <20090130140309.GA17050@linux-mips.org>
References: <20090130074407.GA12368@roarinelk.homelinux.net>
	<20090130140309.GA17050@linux-mips.org>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri, 30 Jan 2009 14:03:09 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Jan 30, 2009 at 08:44:07AM +0100, Manuel Lauss wrote:
> 
> > Can't build kernel because gcc-4.3.3 comes up with this gem:
> > 
> >   CC      arch/mips/kernel/traps.o
> > cc1: warnings being treated as errors
> > /linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
> > /linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments
> > 
> > The fastest fix is the patch below, but I don't know whether it is
> > the right thing to do.
> 
> Is this new with 4.3.3?  I've not ran into this problem with 4.3.2 so far.
> Or it could be configuration dependent ...

So far I see this only with 4.3.3 on various archs.
 

> This seems a gcc bug so could you extract a test case and file a gcc bug
> report?

Done.  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=39044


-- ml.
