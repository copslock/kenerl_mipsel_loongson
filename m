Received:  by oss.sgi.com id <S554028AbQLBByE>;
	Fri, 1 Dec 2000 17:54:04 -0800
Received: from u-183-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.183]:59145
        "EHLO u-183-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S554022AbQLBBxn>; Fri, 1 Dec 2000 17:53:43 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869503AbQLBBxR>;
	Sat, 2 Dec 2000 02:53:17 +0100
Date:	Sat, 2 Dec 2000 02:53:17 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Gordon McNutt <gmcnutt@ridgerun.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: console knowledge
Message-ID: <20001202025317.A4718@bacchus.dhis.org>
References: <001901c05b67$8c88ab60$0deca8c0@Ulysses> <XFMail.001201163348.Harald.Koerfgen@home.ivm.de> <20001201185321.A3211@bacchus.dhis.org> <3A27EAD6.83E03DFB@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A27EAD6.83E03DFB@ridgerun.com>; from gmcnutt@ridgerun.com on Fri, Dec 01, 2000 at 11:15:50AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 01, 2000 at 11:15:50AM -0700, Gordon McNutt wrote:

> > /dev/console (as chardev 5/1) differs from another device in some important
> > ways:
> >
> >  - When opened by a process without controlling tty it will not become a
> >    CTTY even if the NOCTTY flag is not set.
> 
> What do you mean by "controlling tty"?
> output, but perhaps you can clarify.

Controlling terminal is a fundamental UNIX term; you should check a good
UNIX book about it.  The glibc info pages also have some words about it.

> And why is the distinction noted above important? I assume it has something
> to do with keyboard input/screen

Reread my posting, it describes some of the differences in the behaviour
of for example /dev/console and /dev/ttyS0 even though both refer to the
same device.

That could be different.  The classic UNIX setup is sending /dev/console to
the printer on one serial and having the system's console terminal on
another.  Any arbitrary device combination would be possible.

  Ralf
