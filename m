Received:  by oss.sgi.com id <S553757AbQJXPOZ>;
	Tue, 24 Oct 2000 08:14:25 -0700
Received: from u-117.karlsruhe.ipdial.viaginterkom.de ([62.180.10.117]:51204
        "EHLO u-117.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553681AbQJXPOJ>; Tue, 24 Oct 2000 08:14:09 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870342AbQJXOin>;
        Tue, 24 Oct 2000 16:38:43 +0200
Date:   Tue, 24 Oct 2000 16:38:43 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     K.H.C.vanHouten@kpn.com
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com,
        K.H.C.vanHouten@research.kpn.com
Subject: Re: process lockups
Message-ID: <20001024163843.A7342@bacchus.dhis.org>
References: <20001024044736.B3397@bacchus.dhis.org> <200010240551.HAA02069@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200010240551.HAA02069@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Tue, Oct 24, 2000 at 07:51:42AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 07:51:42AM +0200, Houten K.H.C. van (Karel) wrote:

> > > I am running Kernel 2.4.0-test9 on a DECstation 5000/150. I am
> > > experiencing a strange behaviour when having strong I/O-load, such as
> > > running a "tar xvf foobar.tgz" with a large archive. After some time of
> > > activity the process (in this case tar) is stuck in status "D". There is
> > > neither an entry in the syslog nor on the console that would give me a
> > > hint what is happening. Is anyone else experiencing this?
> > 
> > I observe similar stuck processes on Origins - even without massive I/O
> > load.  I'm trying to track them but little success aside of fixing a few
> > unrelated little bugs.  Do you observe those on your R4k box also?
> On my DEC 5000/260 (R4k) I have no stuck processes, but I should mention
> that I am running without swap (I have 192Mb RAM).

That matches my Origin experience with it's 1.5gb RAM and no swap.

> > Another things which I'm observing is that I occasinally can't unmount
> > a filesystem.  umount then says the fs is still in use.  Sometimes it's
> > at least possible to remount the fs r/o.  Have you also observed this one?

> Yes, but only the root FS. I thought I might have to upgrade to a newer
> mount program for the 2.4 kernel, or is the system call returning the error?

It also happens for other filesystems; the heavier the usage of the
filesystem has been the more often.  But I've never seen a hanging tar or
gcc process.

> Aside from this I stil get 'bug in get_wchan' messages, but everything
> seems to run fine. I hope to test my current kernels on a 5000/150 and
> a 3100.

This message is harmless.  The only effect is that the WCHAN column of
ps axl will have bogus information.

Which is a problem - I need exactly the WCHAN information to debug this
problem.

  Ralf
