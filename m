Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 06:54:34 +0100 (BST)
Received: from mailgate5.cinetic.de ([IPv6:::ffff:217.72.192.165]:33713 "EHLO
	mailgate5.cinetic.de") by linux-mips.org with ESMTP
	id <S8225253AbTG3Fyc>; Wed, 30 Jul 2003 06:54:32 +0100
Received: from web.de (fmomail03.dlan.cinetic.de [172.20.1.236])
	by mailgate5.cinetic.de (8.11.6p2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id h6U5sOQ11794;
	Wed, 30 Jul 2003 07:54:25 +0200
Date: Wed, 30 Jul 2003 07:54:25 +0200
Message-Id: <200307300554.h6U5sOQ11794@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: =?iso-8859-1?Q? "Frank=20F=F6rstemann" ?= <foerstemann@web.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: No mouse support for Indy in 2.5.75 ?
Precedence: fm-user
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <foerstemann@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: foerstemann@web.de
Precedence: bulk
X-list: linux-mips

Hi Ralf.

Is there any additional information I can collect on these issues ?

Frank

Am Die, 2003-07-29 um 13.49 schrieb Ralf Baechle:
> On Fri, Jul 25, 2003 at 11:37:06PM +0200, =?iso-8859-1?Q? Frank=20F=F6rstemann ?= wrote:
> 
> > I tried kernel version 2.5.75 on my Indy. It works fine with the
> > exception that the mouse in XFree86 does not move. The devices are 
> > available, but event debugging shows no mouse events at all. Are there
> > any special configuration options for the Indy mouse except the ones in
> > the 'input' section ? Dmesg output and kernel configuration are
> > attached.
> 
> We knew there was something wrong in that area; the probe for kbd and mouse
> also takes very long on the Indy.  What worries me more are those
> kernel messages from your log:
> 
> mount: Exception at [<88113a38>] (88113bf0)
> mount: Exception at [<88113a38>] (88113bf0)
> mount: Exception at [<88113a38>] (88113bf0)
> 
>   Ralf

______________________________________________________________________________
ComputerBild (15-03) empfiehlt: Der beste Spam-Schutz ist bei
WEB.DE FreeMail - Deutschlands beste E-Mail - http://s.web.de/?mc=021124
