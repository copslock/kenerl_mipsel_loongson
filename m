Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 11:08:52 +0100 (BST)
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:12039 "HELO
	mallaury.nerim.net") by ftp.linux-mips.org with SMTP
	id S8133456AbWFTKIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Jun 2006 11:08:42 +0100
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with SMTP id 91C924F3E1;
	Tue, 20 Jun 2006 12:08:26 +0200 (CEST)
Date:	Tue, 20 Jun 2006 12:08:36 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-Id: <20060620120836.628ddc79.khali@linux-fr.org>
In-Reply-To: <1150735558.8413.7.camel@localhost.localdomain>
References: <20060615225723.012c82be.khali@linux-fr.org>
	<1150406598.1193.73.camel@localhost.localdomain>
	<20060616222908.f96e3691.khali@linux-fr.org>
	<1150735558.8413.7.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Pete,

> > > For historical correctness, this driver was once upon a time usable,
> > > though it was a few years ago. It was written by MV for some ref board
> > > that had the ITE chip and it did work. That ref board is no longer
> > > around so it's probably safe to nuke the driver. 
> > 
> > In which kernel version? In every version I checked (2.4.12, 2.4.30,
> > 2.6.0 and 2.6.16) it wouldn't compile due to struct iic_ite being used
> > but never defined (and possibly other errors, but I can't test-compile
> > the driver.)
> 
> Honestly, I don't remember. I think it was one of the very first 2.6
> kernels because when MV first released a 2.6 product, 2.6 was still
> 'experimental'. It's quite possible of course that the driver was never
> properly merged upstream in the community tree(s). But I do know that it
> worked in the internal MV tree and an effort was made to get the driver
> accepted upstream.

I couldn't find any evidence of this effort. Whatever, past is past, if
someone fixes the i2c-ite and i2c-algo-ite drivers soon, fine with me,
if not, the drivers will be deleted (which doesn't mean they can't be
resurrected later if there is interest and someone takes over
maintenance.) I'm setting the deadline to September 2006.

-- 
Jean Delvare
