Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 23:27:44 +0100 (BST)
Received: from mailgate5.cinetic.de ([IPv6:::ffff:217.72.192.165]:62410 "EHLO
	mailgate5.cinetic.de") by linux-mips.org with ESMTP
	id <S8225207AbTGaW1m>; Thu, 31 Jul 2003 23:27:42 +0100
Received: from web.de (fmomail03.dlan.cinetic.de [172.20.1.236])
	by mailgate5.cinetic.de (8.11.6p2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id h6VMRaQ26570;
	Fri, 1 Aug 2003 00:27:36 +0200
Date: Fri, 1 Aug 2003 00:27:36 +0200
Message-Id: <200307312227.h6VMRaQ26570@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: =?iso-8859-1?Q? "Frank=20F=F6rstemann" ?= <foerstemann@web.de>
To: "RalfBaechle" <ralf@linux-mips.org>
Cc: "linux-mips" <linux-mips@linux-mips.org>
Subject: Re: No mouse support for Indy in 2.5.75 ?
Precedence: fm-user
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <foerstemann@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: foerstemann@web.de
Precedence: bulk
X-list: linux-mips

Am Mit, 2003-07-30 um 13.23 schrieb Ralf Baechle:
> On Wed, Jul 30, 2003 at 07:54:25AM +0200, =?iso-8859-1?Q? Frank=20F=F6rstemann ?= wrote:
> 
> > Is there any additional information I can collect on these issues ?
> 
> Well, as for the PS/2 issues, you'll have to read through the code yourself,
> nobody's digged into that so far.
> 

Hm, seems to be easier to stay at 2.4.x for the moment. I'll have a look
when I find some time...

> > > mount: Exception at [<88113a38>] (88113bf0)
> > > mount: Exception at [<88113a38>] (88113bf0)
> > > mount: Exception at [<88113a38>] (88113bf0)
> 
> The kernel messages otoh are not sign of a kernel but an application bug.
> It seems mount did pass bad addresses to the kernel through some syscall;
> these messages are the sign of the normal mechanism to intercept bad
> address arguments to syscall kicking in.  You won't get those messages
> anymore in 2.6 btw.  The kernel only print's them if the second digit of
> the version number is odd, see development_version in arch/mips/mm/fault.c.

.... which means that this problem might well be an old one, because my standard
kernel is a 2.4.

> 
>   Ralf
> 

Frank

______________________________________________________________________________
Spam-Filter fuer alle - bester Spam-Schutz laut ComputerBild 15-03
WEB.DE FreeMail - Deutschlands beste E-Mail - http://s.web.de/?mc=021120
