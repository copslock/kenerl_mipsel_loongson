Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2008 15:13:24 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7121 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022245AbYAQPNV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Jan 2008 15:13:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0HFAsFH013717;
	Thu, 17 Jan 2008 15:10:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0HFArnS013716;
	Thu, 17 Jan 2008 15:10:53 GMT
Date:	Thu, 17 Jan 2008 15:10:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080117151052.GA12457@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <20080117082741.GA2586@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080117082741.GA2586@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 17, 2008 at 09:27:41AM +0100, Florian Lohoff wrote:

> > this kills my IP28 after a few seconds. If I drop rdhwr or sync the
> > machine hasn't locked up after running for several minutes. Looks
> > like we are hiting a strange condition.
> > 
> > This sort of code could be found in glibc 2.7 all over the place...
> > 
> > Thomas.
> > 
> > PS: Using rdhwr_noopt doesn't make a difference...
> 
> Kills my ip28 after 2 seconds ...

Doesn't harm IP27.  I even tried running two copies running in parallel.

  Ralf
