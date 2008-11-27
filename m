Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 11:22:42 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:60347 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23948625AbYK0LWk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2008 11:22:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mARBMZSK027757;
	Thu, 27 Nov 2008 11:22:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mARBMYwU027755;
	Thu, 27 Nov 2008 11:22:34 GMT
Date:	Thu, 27 Nov 2008 11:22:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Remove unused header file gio.h
Message-ID: <20081127112234.GA20189@linux-mips.org>
References: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi> <20081127091619.GA6255@alpha.franken.de> <43787.88.114.226.209.1227781466.squirrel@webmail.movial.fi> <20081127103706.GA6929@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081127103706.GA6929@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 27, 2008 at 11:37:06AM +0100, Thomas Bogendoerfer wrote:

> first step is to introduce GIO devices similair to PCI devices. My
> current working GIO device is solid impact. I also looked at
> supporting Phobos G160 cards, but the current set of 2114x drivers
> is not useable for that...
> 
> The big missing thing in the GIO framework right now is a bullet proof
> detection for non standard GIO cards, like newport and XZ cards. They
> don't provide ID information...

So the resulting code will be a mix of normal probing bus code and
something like "GIO platform devices" which are just added if we somehow
"know" they're there?  SGI never stops to amaze me ...

  Ralf
