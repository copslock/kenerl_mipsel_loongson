Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2009 16:50:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:10708 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023955AbZC1Qu5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Mar 2009 16:50:57 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2SGotwN007749;
	Sat, 28 Mar 2009 17:50:56 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2SGossk007747;
	Sat, 28 Mar 2009 17:50:54 +0100
Date:	Sat, 28 Mar 2009 17:50:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/6] Alchemy updates for 2.6.30
Message-ID: <20090328165053.GB23938@linux-mips.org>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net> <20090328150320.37bfd6be@scarran.roarinelk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090328150320.37bfd6be@scarran.roarinelk.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 28, 2009 at 03:03:20PM +0100, Manuel Lauss wrote:

> > #5    I dislike the alchemy/common/platform.c file because it makes passing
> >       platform data to drivers ugly (the platdata struct and the consumer
> >       are in different files) and I also don't like the fact that every
> >       conceivable piece of alchemy hardware has a driver registered whether
> >       I like it or not.  To not change existing behaviour, the platform.c
> >       file is now invoked by the board Makefiles instead of the one in common/.
> > 
> > #6    Adds more complete DB1200 support (see patch for more info).
> 
> Please ignore patches 5 and 6.  I'm working on a better solution for
> the problem #5 is supposed to fix,  and #6 depends on a patch to the
> 8250 driver which has not received any feedback.

Okay, dropped.

  Ralf
