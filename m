Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 18:16:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49611 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492995AbZKFRQS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 18:16:18 +0100
Date:	Fri, 6 Nov 2009 17:16:18 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
cc:	David Daney <ddaney@caviumnetworks.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
In-Reply-To: <90edad820911060907j4a605167xfe1ebdf0dcf7b635@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0911061710160.9725@eddie.linux-mips.org>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>  <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>  <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>  <4AF4526B.3020502@caviumnetworks.com>
 <90edad820911060907j4a605167xfe1ebdf0dcf7b635@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 Nov 2009, Dmitri Vorobiev wrote:

> > It depends on your concerns.  You are still using 4096 bytes of stack, but
> > you are trying to trick the compiler into not warning.
> >
> > If you think the warning is bogus, you should remove it for all code, not
> > just this file.  If you think the warning is valid, then you should fix the
> > code so that it doesn't use as much stack space.
> 
> Frankly, I don't think that the warning is bogus, especially if we're
> talking about the case of the 4K page and 32-bit kernel, and I started
> thinking htat probably the static array solution would be the safest
> bet here.

 KSEG space is not paged, so who cares about the page size?  You're not 
making additional stack page allocations, although you can overflow the 
space available at some point (but that's avoided if you know a priori 
your backtrace is not going to be deep).  Static allocation has its 
drawbacks, for example it takes storage space (if it's initialised data) 
or memory space (if it's BSS) indefinitely.

  Maciej
