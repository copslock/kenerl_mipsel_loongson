Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 18:02:15 +0100 (BST)
Received: from p508B7611.dip.t-dialin.net ([IPv6:::ffff:80.139.118.17]:43044
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224909AbUJSRCL>; Tue, 19 Oct 2004 18:02:11 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9JH25DS020486;
	Tue, 19 Oct 2004 19:02:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9JH24Cg020485;
	Tue, 19 Oct 2004 19:02:04 +0200
Date: Tue, 19 Oct 2004 19:02:04 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org, Andrew Dyer <adyer@righthandtech.com>
Subject: Re: jump instruction in delay slot
Message-ID: <20041019170204.GB18385@linux-mips.org>
References: <B482D8AA59BF244F99AFE7520D74BF961A5B71@server1.RightHand.righthandtech.com> <200410191900.02222.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191900.02222.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 19, 2004 at 07:00:02PM +0200, Thomas Koeller wrote:

> > Also, idt has a good book online in pdf called
> > IDT MIPS Microprocessor Family
> > Software Reference Manual
> >
> > it has a good section on assembly collecting info
> > from a lot of places.
> 
> That was a good hint, thanks a lot!

In case you have an IRIX system with documentation at hand you may check
it's documentation.  The assembler dialects differ a bit but both are
close enough and some details are only well explained in the IRIX
documentation.

  Ralf
