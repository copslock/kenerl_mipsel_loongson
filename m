Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 07:21:41 +0100 (BST)
Received: from out001.atlarge.net ([129.41.63.69]:43202 "EHLO
	out001.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20037854AbWIFGVh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Sep 2006 07:21:37 +0100
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out001.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 Sep 2006 01:20:08 -0500
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 Sep 2006 01:20:07 -0500
Date:	Wed, 6 Sep 2006 08:21:28 +0200
From:	Domen Puncer <domen.puncer@telargo.com>
To:	David Goodenough <david.goodenough@linkchoose.co.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: ADM5120 support
Message-ID: <20060906062128.GE5361@domen.puncer.telargo.com>
References: <200609011150.54312.david.goodenough@linkchoose.co.uk> <20060904061141.GB5361@domen.puncer.telargo.com> <200609051611.34286.david.goodenough@linkchoose.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609051611.34286.david.goodenough@linkchoose.co.uk>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 06 Sep 2006 06:20:07.0798 (UTC) FILETIME=[7FDD0960:01C6D17C]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 05/09/06 16:11 +0100, David Goodenough wrote:
> On Monday 04 September 2006 07:11, Domen Puncer wrote:
> > On 01/09/06 11:50 +0100, David Goodenough wrote:
> > > I have found some patches for the ADM5120 on the web for 2.6.12, but
> > > nothing more recent.  Anyone know of an updated patch (if updating is
> > > needed)?
> >
> > Hi!
> >
> > I forward ported them to 2.6.15, but then lost interest.
> >
> > http://coderock.org/planet_xrt-401d/files/
> >
> >
> > 	Domen
> >
> > > David
> Thank you.  I tried to use those but obviously I have something wrong in
> my config.  The patches apply, but then when it tried to compile it
> complains on the first CC saying that THREAD_SIZE_ORDER is undefined.  This
> looks as though I have the config wrong.  Do you have a working config to
> go with your patches?

http://coderock.org/planet_xrt-401d/files/config-adm
should be the latest I tried.


	Domen
> 
> Regards
> 
> David
