Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2004 11:53:42 +0000 (GMT)
Received: from p508B66BC.dip.t-dialin.net ([IPv6:::ffff:80.139.102.188]:62049
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225250AbUK1Lxi>; Sun, 28 Nov 2004 11:53:38 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iASBraab016139;
	Sun, 28 Nov 2004 12:53:37 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iASBraPM016138;
	Sun, 28 Nov 2004 12:53:36 +0100
Date: Sun, 28 Nov 2004 12:53:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: sjhill@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20041128115336.GB14004@linux-mips.org>
References: <20041127061929Z8224786-1751+2584@linux-mips.org> <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl> <20041127231543.GA14252@linux-mips.org> <Pine.LNX.4.58L.0411280138200.27645@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411280138200.27645@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 28, 2004 at 02:01:44AM +0000, Maciej W. Rozycki wrote:

> > We're already printing way too much stuff and this is a not very useful
> > message so why not removing the whole thing for good ...
> 
>  This is useful for reliability verification.  See the thread starting at:  
> "http://oss.sgi.com/projects/netdev/archive/2004-11/msg00475.html".  The
> setting should also be user controllable, but for now people should at
> least know whether it's in effect or not.
> 
>  Anyone is free to bump their console/syslog loglevel to get rid of less
> important messages to suit there preferences.  And INFO, which is what the
> message uses, is the lowest level for stuff for non-developers.

As a deterring example why I try to cut down on system messages checkout:

  http://www.linux-mips.org/wiki/index.php/IP27_boot_messages

70kB of little information crawling over a 19k2 console making kernel
startup an entertaining experience for the whole family ;-)

  Ralf
