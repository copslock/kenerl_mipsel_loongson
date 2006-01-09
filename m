Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 15:22:06 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:16670 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134425AbWAIPVt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 15:21:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k09FOUNj006512;
	Mon, 9 Jan 2006 15:24:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k09FOTb0006511;
	Mon, 9 Jan 2006 15:24:29 GMT
Date:	Mon, 9 Jan 2006 15:24:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	linux-mips@linux-mips.org, zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060109152429.GE4286@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <20060109145610.GB4286@linux-mips.org> <200601091720.03822.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601091720.03822.p_christ@hol.gr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 09, 2006 at 05:20:01PM +0200, P. Christeas wrote:

> > You've downloaded a kernel.org kernel it would seem - doesn't fly for MIPS.
> > Instead get a kernel from linux-mips.org.
> >
> > The early_initcall() construct has been removed.
> >
> >   Ralf
> 
> What's the difference between the trees?

All the MIPS work is happening in the linux-mips.org tree.

> Aren't the MIPS patches supposed to be merged to Linus' tree?

In 2.6.15 things were alomst fully merged but several megabytes of
patches are between the linux-mips.org and kernel.org versions of 2.6.14.

  Ralf
