Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 00:13:16 +0100 (BST)
Received: from p508B7906.dip.t-dialin.net ([IPv6:::ffff:80.139.121.6]:47730
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225507AbUDLXNQ>; Tue, 13 Apr 2004 00:13:16 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3CNDBxr004030;
	Tue, 13 Apr 2004 01:13:11 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3CND9lA004029;
	Tue, 13 Apr 2004 01:13:09 +0200
Date: Tue, 13 Apr 2004 01:13:09 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: Work on IP30
Message-ID: <20040412231309.GA702@linux-mips.org>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 12, 2004 at 10:51:13PM +0200, Stanislaw Skowronek wrote:

> Interesting note: the ARCS console breaks when I change KSEG0 cache
> coherence in the CP0_CONFIG register (in c-r4k.c). Of course, it breaks
> sooner or later, not exactly afterwards, unless I flush cache exactly
> after changing; it breaks immediately then. I don't give a hoot, because
> IP30 has almost no RAM in KSEG0 and the kernel runs in XKPHYS, always
> cached copy-on-write. But those of you with another machines might be
> interested.

Most firmware breaks at some point due to Linux fiddling with it's
resources.  What differs is how and when it breaks.  In case of IP27 the
first TLB flush for example is going to kill ARC.

And remember, it's written ARC but pronounced ARGGHHHH ;)

  Ralf
