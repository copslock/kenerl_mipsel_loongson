Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 15:42:07 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:56582 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225456AbVG0Olw>; Wed, 27 Jul 2005 15:41:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8FD0DF597F; Wed, 27 Jul 2005 16:44:22 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18057-03; Wed, 27 Jul 2005 16:44:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 620D8E1C64; Wed, 27 Jul 2005 16:44:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6REiPer028088;
	Wed, 27 Jul 2005 16:44:25 +0200
Date:	Wed, 27 Jul 2005 15:44:34 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Cummings <real.psyence@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: o32 glibc-2.3.5
In-Reply-To: <dbce93020507270655d4a1c6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0507271523550.13819@blysk.ds.pg.gda.pl>
References: <dbce930205072612285bd70e1b@mail.gmail.com> 
 <Pine.LNX.4.61L.0507271059110.13819@blysk.ds.pg.gda.pl>
 <dbce93020507270655d4a1c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/994/Wed Jul 27 10:28:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Jul 2005, David Cummings wrote:

> Alright, thanks. I had found that, but it didn't seem to apply to the
> problem with socket, as that had already been applied when the socket
> happened. I'm also now having a problem with n32 which is similar if

 socket.S shouldn't be needed as recv.o is expected to be built as a stub 
based on syscalls.list.  Have you regenerated the configure script 
corresponding to the changed configure.in template?

> not the same as the one Rolf had not too long ago. Something about a
> __fork_block not being found. Anyplace else I should look? Thanks,

 Check if the symbol is defined where it's expected to.

 Source and binary RPM packages of glibc 2.3.5 built for o32 and (n)64 are 
available at my site; built with GCC 4.0.0 which is even pickier than 
3.4.4.  Availability of binary packages means successful builds are 
possibile.  Figuring out how is left as an exercise for the reader; source 
packages are provided as an aid to that.

  Maciej
