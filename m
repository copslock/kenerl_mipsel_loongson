Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2006 16:11:49 +0100 (BST)
Received: from ip-217-204-115-127.easynet.co.uk ([217.204.115.127]:21767 "EHLO
	apollo.linkchoose.co.uk") by ftp.linux-mips.org with ESMTP
	id S20037572AbWIEPLs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Sep 2006 16:11:48 +0100
Received: from [10.98.1.127] (helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1GKcb7-0006q1-7M
	for linux-mips@linux-mips.org; Tue, 05 Sep 2006 16:12:21 +0100
Received: from [10.0.1.63]
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1GKcaO-0002Kw-1l
	for linux-mips@linux-mips.org; Tue, 05 Sep 2006 16:11:36 +0100
From:	David Goodenough <david.goodenough@linkchoose.co.uk>
Organization: Linkchoose Ltd
To:	linux-mips@linux-mips.org
Subject: Re: ADM5120 support
Date:	Tue, 5 Sep 2006 16:11:33 +0100
User-Agent: KMail/1.9.3
References: <200609011150.54312.david.goodenough@linkchoose.co.uk> <20060904061141.GB5361@domen.puncer.telargo.com>
In-Reply-To: <20060904061141.GB5361@domen.puncer.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051611.34286.david.goodenough@linkchoose.co.uk>
Return-Path: <david.goodenough@linkchoose.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@linkchoose.co.uk
Precedence: bulk
X-list: linux-mips

On Monday 04 September 2006 07:11, Domen Puncer wrote:
> On 01/09/06 11:50 +0100, David Goodenough wrote:
> > I have found some patches for the ADM5120 on the web for 2.6.12, but
> > nothing more recent.  Anyone know of an updated patch (if updating is
> > needed)?
>
> Hi!
>
> I forward ported them to 2.6.15, but then lost interest.
>
> http://coderock.org/planet_xrt-401d/files/
>
>
> 	Domen
>
> > David
Thank you.  I tried to use those but obviously I have something wrong in
my config.  The patches apply, but then when it tried to compile it
complains on the first CC saying that THREAD_SIZE_ORDER is undefined.  This
looks as though I have the config wrong.  Do you have a working config to
go with your patches?

Regards

David
