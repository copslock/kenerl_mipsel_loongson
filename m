Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 09:22:06 +0100 (BST)
Received: from ip-217-204-115-127.easynet.co.uk ([217.204.115.127]:33554 "EHLO
	apollo.linkchoose.co.uk") by ftp.linux-mips.org with ESMTP
	id S20037874AbWIFIWC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Sep 2006 09:22:02 +0100
Received: from [10.98.1.127] (helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1GKsgC-0007TG-Eq
	for linux-mips@linux-mips.org; Wed, 06 Sep 2006 09:22:40 +0100
Received: from [10.0.1.63]
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1GKsfO-0003N1-G1
	for linux-mips@linux-mips.org; Wed, 06 Sep 2006 09:21:50 +0100
From:	David Goodenough <david.goodenough@linkchoose.co.uk>
Organization: Linkchoose Ltd
To:	linux-mips@linux-mips.org
Subject: Re: ADM5120 support
Date:	Wed, 6 Sep 2006 09:21:52 +0100
User-Agent: KMail/1.9.3
References: <200609011150.54312.david.goodenough@linkchoose.co.uk> <200609051611.34286.david.goodenough@linkchoose.co.uk> <20060906062128.GE5361@domen.puncer.telargo.com>
In-Reply-To: <20060906062128.GE5361@domen.puncer.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609060921.52642.david.goodenough@linkchoose.co.uk>
Return-Path: <david.goodenough@linkchoose.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@linkchoose.co.uk
Precedence: bulk
X-list: linux-mips

On Wednesday 06 September 2006 07:21, Domen Puncer wrote:
> On 05/09/06 16:11 +0100, David Goodenough wrote:
> > On Monday 04 September 2006 07:11, Domen Puncer wrote:
> > > On 01/09/06 11:50 +0100, David Goodenough wrote:
> > > > I have found some patches for the ADM5120 on the web for 2.6.12, but
> > > > nothing more recent.  Anyone know of an updated patch (if updating is
> > > > needed)?
> > >
> > > Hi!
> > >
> > > I forward ported them to 2.6.15, but then lost interest.
> > >
> > > http://coderock.org/planet_xrt-401d/files/
> > >
> > >
> > > 	Domen
> > >
> > > > David
> >
> > Thank you.  I tried to use those but obviously I have something wrong in
> > my config.  The patches apply, but then when it tried to compile it
> > complains on the first CC saying that THREAD_SIZE_ORDER is undefined. 
> > This looks as though I have the config wrong.  Do you have a working
> > config to go with your patches?
>
> http://coderock.org/planet_xrt-401d/files/config-adm
> should be the latest I tried.
>
Thank you

David
>
> 	Domen
>
> > Regards
> >
> > David
