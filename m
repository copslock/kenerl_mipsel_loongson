Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 12:12:51 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:14558 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20042227AbXJRLMl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 12:12:41 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 7F0E5400F9;
	Thu, 18 Oct 2007 13:12:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 55hb3sa57ru0; Thu, 18 Oct 2007 13:12:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 23966400A4;
	Thu, 18 Oct 2007 13:12:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9IBC8oi019267;
	Thu, 18 Oct 2007 13:12:08 +0200
Date:	Thu, 18 Oct 2007 12:12:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	=?ISO-8859-1?Q?G=FCnter_Dannoritzer?= <dannoritzer@web.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Which gcc version for MIPS?
In-Reply-To: <47168782.1000301@web.de>
Message-ID: <Pine.LNX.4.64N.0710181204040.4701@blysk.ds.pg.gda.pl>
References: <47168782.1000301@web.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="328795856-976365475-1192705573=:4701"
Content-ID: <Pine.LNX.4.64N.0710181206190.4701@blysk.ds.pg.gda.pl>
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--328795856-976365475-1192705573=:4701
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64N.0710181206191.4701@blysk.ds.pg.gda.pl>

On Thu, 18 Oct 2007, Günter Dannoritzer wrote:

> Can anybody give me some help in deciding what gcc version to use?

 Well, hard to tell probably: 3.4 used to be fairly stable, 4.0 -- less 
so, 4.1 -- I am happy with it, but your mileage may vary, 4.2 -- I have 
not tried.  Others may have differing opinions.

> Does the gcc version need to match a certain binutils version?

 For binutils your best choice is probably sticking with the most recent 
release.  As of this writing it is 2.18.

> Another question I have about having a mips and mipsel toolchain. I am
> aware that some MIPS procecessors can change the endian-ness. In the gcc
> documentation I saw that there is a -EB and -EL switch to select the
> endianes. What is then the reason to have two toolchains?

 Well, it is a choice from two and you can have only one default.  You 
would usually want to have the default set to the endianness you most 
frequently use, so that you do not have to specify the switch; obviously 
the same applies to a native MIPS/Linux toolchain.  Besides, historically 
there used to be some bugs in the compiler's specs that made the selection 
of the non-default endianness problematic at times.  They should have been 
fixed by now though.

  Maciej
--328795856-976365475-1192705573=:4701--
