Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 01:10:41 +0000 (GMT)
Received: from p508B5CF9.dip.t-dialin.net ([IPv6:::ffff:80.139.92.249]:63937
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225412AbTLMBKk>; Sat, 13 Dec 2003 01:10:40 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBD1AMoK023569;
	Sat, 13 Dec 2003 02:10:22 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBD1AH8h023568;
	Sat, 13 Dec 2003 02:10:17 +0100
Date: Sat, 13 Dec 2003 02:10:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Steven J. Hill" <sjhill@realitydiluted.com>,
	durai <durai@isofttech.com>,
	uclinux-dev <uclinux-dev@uclinux.org>,
	mips <linux-mips@linux-mips.org>
Subject: Re: Network problem in mips
Message-ID: <20031213011017.GB22448@linux-mips.org>
References: <008f01c3bff7$252e3b40$0a05a8c0@DURAI> <3FD88C4D.6010700@realitydiluted.com> <1071184052.19738.12.camel@dhcp23.swansea.linux.org.uk> <20031211233058.GB20373@linux-mips.org> <Pine.LNX.4.55.0312120037480.23228@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0312120037480.23228@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 12, 2003 at 12:46:23AM +0100, Maciej W. Rozycki wrote:

> > > Seems a little out of order. Not everyone immediately understands you
> > > need the ksyms to interpret a trace
> > 
> > Guess that should be mentioned in the FAQ - anybody got a pointer to a
> > little how to for writing useful bug reports?
> 
>  Well, REPORTING-BUGS in the Linux source seems pretty good for a start.  
> README provides a few hints as well, although with a little bias towards
> i386.

Indeed.  So close I already forgot about this file's existence ...

I added a short section about bug reporting to the FAQ.  Less than perfect
but at least it's a start.

  Ralf
