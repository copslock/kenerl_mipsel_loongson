Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2002 12:55:52 +0100 (MET)
Received: from alg133.algor.co.uk ([IPv6:::ffff:62.254.210.133]:19686 "EHLO
	oalggw.algor.co.uk") by ralf.linux-mips.org with ESMTP
	id <S869668AbSLILzl>; Mon, 9 Dec 2002 12:55:41 +0100
Received: from gladsmuir.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gB9BsKW07564;
	Mon, 9 Dec 2002 11:54:25 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.33900.117478.251574@gladsmuir.algor.co.uk>
Date: Mon, 9 Dec 2002 11:54:20 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@mips.com>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
In-Reply-To: <3DF4629B.F377F711@mips.com>
References: <3DEF7087.B6DEA7EC@mips.com>
	<20021209051845.A31939@linux-mips.org>
	<3DF4629B.F377F711@mips.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


> > > The __access_ok macro in include/asm-mips64/uaccess.h and the
> > > check_axs macro in arch/mips64/kernel/unaligned.c ... is a copy
> > > from the 32-bit kernel...
> > >
> > > The area between USEG (XUSEG) and KSEG0 will in 64-bit
> > > addressing mode generate an address error, if accessed.

I'd like to be clear about the consequences of this.  Presumably the
'access_ok()' macro is used to check addresses which were (originally)
provided by a user program's system call.

Carsten, are you saying that if such an address is set to say 2**41 in
a CPU supporting 40-bit user virtual addresses, that the kernel will
crash?

If so, that seems to require a fix, even if we don't know a very
efficient one.  But perhaps any problem is a bit more subtle than
that?

-- 
Dominic Sweetman
MIPS Technologies
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706205/fax +44 1223 706250/swbrd +44 1223 706200
http://www.algor.co.uk
