Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2003 12:49:09 +0100 (BST)
Received: from p508B6063.dip.t-dialin.net ([IPv6:::ffff:80.139.96.99]:3494
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225214AbTG2LtH>; Tue, 29 Jul 2003 12:49:07 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6TBn5x6032724;
	Tue, 29 Jul 2003 13:49:05 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6TBn5VS032723;
	Tue, 29 Jul 2003 13:49:05 +0200
Date: Tue, 29 Jul 2003 13:49:04 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: =?us-ascii?B?PT9pc28tODg1OS0xP1E/?= Frank=20F=F6rstemann ?= 
	<Foerstemann@web.de>
Cc: linux-mips@linux-mips.org
Subject: Re: No mouse support for Indy in 2.5.75 ?
Message-ID: <20030729114904.GA32526@linux-mips.org>
References: <200307252137.h6PLb6Q01329@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307252137.h6PLb6Q01329@mailgate5.cinetic.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 25, 2003 at 11:37:06PM +0200, =?iso-8859-1?Q? Frank=20F=F6rstemann ?= wrote:

> I tried kernel version 2.5.75 on my Indy. It works fine with the
> exception that the mouse in XFree86 does not move. The devices are 
> available, but event debugging shows no mouse events at all. Are there
> any special configuration options for the Indy mouse except the ones in
> the 'input' section ? Dmesg output and kernel configuration are
> attached.

We knew there was something wrong in that area; the probe for kbd and mouse
also takes very long on the Indy.  What worries me more are those
kernel messages from your log:

mount: Exception at [<88113a38>] (88113bf0)
mount: Exception at [<88113a38>] (88113bf0)
mount: Exception at [<88113a38>] (88113bf0)

  Ralf
