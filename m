Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 21:15:21 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:28179 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225195AbUJEUPQ>; Tue, 5 Oct 2004 21:15:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E28FFF5974; Tue,  5 Oct 2004 22:15:09 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18598-06; Tue,  5 Oct 2004 22:15:09 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 807B3F596D; Tue,  5 Oct 2004 22:15:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i95KFQVq020495;
	Tue, 5 Oct 2004 22:15:26 +0200
Date: Tue, 5 Oct 2004 21:15:14 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Assembler errors in rtld.c
In-Reply-To: <20041005121713.GH5033@lug-owl.de>
Message-ID: <Pine.LNX.4.58L.0410052114230.26193@blysk.ds.pg.gda.pl>
References: <41626E7D.2070405@procsys.com> <20041005.191608.59649656.nemoto@toshiba-tops.co.jp>
 <Pine.LNX.4.58L.0410051152440.20503@blysk.ds.pg.gda.pl> <20041005121713.GH5033@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 5 Oct 2004, Jan-Benedict Glaw wrote:

> > > Also, you might have to pass -fno-unit-at-a-time to gcc 3.4.  (at
> > > least glibc 2.3.2 requires it).
> > 
> >  Which is also fixed in the CVS. ;-)
> 
> So that inline mess is also gone? Find... Or is that about a different
> thing?

 Could you please elaborate?  What current glibc does is adding 
-fno-unit-at-a-time where appropriate.

  Maciej
