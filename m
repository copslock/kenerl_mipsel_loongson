Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 13:28:50 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:5174
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225225AbUHWM2p>; Mon, 23 Aug 2004 13:28:45 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NCShqU021626;
	Mon, 23 Aug 2004 14:28:43 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NCShYW021623;
	Mon, 23 Aug 2004 14:28:43 +0200
Date: Mon, 23 Aug 2004 14:28:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alec Voropay <a.voropay@vmb-service.ru>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823122843.GB20905@linux-mips.org>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <006f01c485f9$41348b50$3c01a8c0@portege>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006f01c485f9$41348b50$3c01a8c0@portege>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 19, 2004 at 06:31:45PM +0400, Alec Voropay wrote:

> > Well, this is an area of substantial interest to MIPS Technologies.
> > We are working on our multi-threading extension to the MIPS
> > architecture, and one of our longer-term aims is to achieve really
> > good NPTL performance.
> 
>  Sorry for a bit offtopic..., as far as I remember, the Windows NT
> MIPS edition has a working multithread implementation. Is this
> implementation very copyrighted and is it possible to use something
> ftom there for the NPTL implementation ?

In addition to what Dom has already answered - there are very significant
differences between the multithreading as implemented in the Windows OS
family and the varioius threading implementations for Linux like classic
libpthreads, Linuxthreads, NPTL, Mozilla and more.  If we legally could
look at MS's code I'd not expect to find much useful for us there ...

  Ralf
