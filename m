Received:  by oss.sgi.com id <S553698AbQJXCsT>;
	Mon, 23 Oct 2000 19:48:19 -0700
Received: from u-45.karlsruhe.ipdial.viaginterkom.de ([62.180.18.45]:38916
        "EHLO u-45.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553679AbQJXCsB>; Mon, 23 Oct 2000 19:48:01 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870342AbQJXCrg>;
        Tue, 24 Oct 2000 04:47:36 +0200
Date:   Tue, 24 Oct 2000 04:47:36 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: process lockups
Message-ID: <20001024044736.B3397@bacchus.dhis.org>
References: <20001024032232.A3426@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001024032232.A3426@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Tue, Oct 24, 2000 at 03:22:32AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 03:22:32AM +0200, Karsten Merker wrote:

> I am running Kernel 2.4.0-test9 on a DECstation 5000/150. I am
> experiencing a strange behaviour when having strong I/O-load, such as
> running a "tar xvf foobar.tgz" with a large archive. After some time of
> activity the process (in this case tar) is stuck in status "D". There is
> neither an entry in the syslog nor on the console that would give me a
> hint what is happening. Is anyone else experiencing this?

I observe similar stuck processes on Origins - even without massive I/O
load.  I'm trying to track them but little success aside of fixing a few
unrelated little bugs.  Do you observe those on your R4k box also?

Another things which I'm observing is that I occasinally can't unmount
a filesystem.  umount then says the fs is still in use.  Sometimes it's
at least possible to remount the fs r/o.  Have you also observed this one?

> Another thing I see on my 5000/150 (and only there - this is my only
> R4K-machine, so I do not know whether this is CPU- or machine-type-bound)
> is "top" going weird, eating lots of CPU cycles and spitting messages
> "schedule_timeout: wrong timeout value fffbd0b2 from 800900f8; Setting
> flush to zero for top". I know Florian also has this on his 5000/150.
> Anyone else with the same behavoiur or any idea about the cause for this?

Setting flush to zero for <process name> means that the floating point
approximator is now enabled ;-)

The schedule_timeout thing is unrelated; I've never heared of it before.

  Ralf
