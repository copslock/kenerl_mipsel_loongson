Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 19:24:44 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:7325 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225254AbVAVTYk>; Sat, 22 Jan 2005 19:24:40 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0MJLuwA001866;
	Sat, 22 Jan 2005 19:21:57 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0MJLtSe001865;
	Sat, 22 Jan 2005 19:21:55 GMT
Date:	Sat, 22 Jan 2005 19:21:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: MIPS contributions have "All rights reserved"?
Message-ID: <20050122192155.GA1004@linux-mips.org>
References: <20050119024536Z8225221-1340+1568@linux-mips.org> <20050119134249.GA9175@deprecation.cyrius.com> <1106159183.3341.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106159183.3341.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 19, 2005 at 10:39:59PM +0000, Alan Cox wrote:

> > > - * Copyright (C) 2000, 2004  MIPS Technologies, Inc.  All rights reserved.
> > > + * Copyright (C) 2000, 2004, 2005  MIPS Technologies, Inc.
> > > + *	All rights reserved.
> > 
> > Does this "All rights reserved" statement make sense in a kernel which
> > is GPL?
> 
> Providing it also says its GPL licensed why not. You reserve all your
> rights then license some.

It's been a repeated cause of confusion and the MIPS port had them in 120
files, so with permission I removed the "All rights reserved." of 40 of
them.  The remaining 80 will probably stay as they are.

  Ralf
