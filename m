Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 21:28:32 +0000 (GMT)
Received: from nixon.xkey.com ([IPv6:::ffff:209.245.148.124]:45256 "HELO
	nixon.xkey.com") by linux-mips.org with SMTP id <S8225360AbSLRV2b>;
	Wed, 18 Dec 2002 21:28:31 +0000
Received: (qmail 28504 invoked from network); 18 Dec 2002 21:28:29 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 18 Dec 2002 21:28:29 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gBILRQv02576
	for linux-mips@linux-mips.org; Wed, 18 Dec 2002 13:27:26 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 18 Dec 2002 13:27:26 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
Message-ID: <20021218132726.A2572@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux mips mailing list <linux-mips@linux-mips.org>
References: <200212181950.gBIJo4B11893@coplin09.mips.com> <Pine.GSO.3.96.1021218220828.14826A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021218220828.14826A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 18, 2002 at 10:09:37PM +0100
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

> > Sometimes you don't care whether you do only "half" a macro instruction
> > if the branch is taken. Usually though, the warning is a good thing - I
> > remember having spent many hours finding bugs like this with assemblers
> > that don't issue warnings.
> 
>  This is exactly what ".set nomacro" is for -- I can't see any reason for
> such warnings when ".set macro" is active.

While in general I like playing with sharp knives (you should see my
cluster admin toolkit), and I like my kernel to run fast, and the only
thing that gets trashed is usually at, I still think I'd prefer to
have nops in those delay slots in the kernel. Hand-written assembly is
unlikely to use ".set nomacro" properly.

-- greg
