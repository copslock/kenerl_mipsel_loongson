Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 12:23:12 +0100 (BST)
Received: from p508B60E0.dip.t-dialin.net ([IPv6:::ffff:80.139.96.224]:48265
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTG3LXK>; Wed, 30 Jul 2003 12:23:10 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6UBN8x6024478;
	Wed, 30 Jul 2003 13:23:08 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6UBN7WO024477;
	Wed, 30 Jul 2003 13:23:07 +0200
Date: Wed, 30 Jul 2003 13:23:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: =?us-ascii?B?PT9pc28tODg1OS0xP1E/?= Frank=20F=F6rstemann ?= 
	<foerstemann@web.de>
Cc: linux-mips@linux-mips.org
Subject: Re: No mouse support for Indy in 2.5.75 ?
Message-ID: <20030730112307.GC15703@linux-mips.org>
References: <200307300554.h6U5sOQ11794@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307300554.h6U5sOQ11794@mailgate5.cinetic.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 30, 2003 at 07:54:25AM +0200, =?iso-8859-1?Q? Frank=20F=F6rstemann ?= wrote:

> Is there any additional information I can collect on these issues ?

Well, as for the PS/2 issues, you'll have to read through the code yourself,
nobody's digged into that so far.

> > mount: Exception at [<88113a38>] (88113bf0)
> > mount: Exception at [<88113a38>] (88113bf0)
> > mount: Exception at [<88113a38>] (88113bf0)

The kernel messages otoh are not sign of a kernel but an application bug.
It seems mount did pass bad addresses to the kernel through some syscall;
these messages are the sign of the normal mechanism to intercept bad
address arguments to syscall kicking in.  You won't get those messages
anymore in 2.6 btw.  The kernel only print's them if the second digit of
the version number is odd, see development_version in arch/mips/mm/fault.c.

  Ralf
