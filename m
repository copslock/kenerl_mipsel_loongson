Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 19:58:32 +0100 (BST)
Received: from mail.onstor.com ([66.201.51.107]:60474 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20022572AbXGSS6a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2007 19:58:30 +0100
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 19 Jul 2007 11:58:22 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 19 Jul 2007 11:58:22 -0700
Date:	Thu, 19 Jul 2007 11:58:22 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
Message-ID: <20070719115822.027a8891@ripper.onstor.net>
In-Reply-To: <469CCBB4.60005@gentoo.org>
References: <4687DCE2.8070302@gentoo.org>
	<468825BE.6090001@gmx.net>
	<50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu>
	<20070704152729.GA2925@linux-mips.org>
	<20070704192208.GA7873@linux-mips.org>
	<469B5C2E.5080905@niisi.msk.ru>
	<20070716123343.GA13439@linux-mips.org>
	<20070716103823.3fe9aef4@ripper.onstor.net>
	<469CCBB4.60005@gentoo.org>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jul 2007 18:58:22.0271 (UTC) FILETIME=[C737B4F0:01C7CA36]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jul 2007 10:01:24 -0400 Kumba <kumba@gentoo.org> wrote:

> Andrew Sharp wrote:
> > 
> > I hungrily await said patch, as I believe this is a problem on
> > RM9000 processors as well.  I'm seeing "random" SIGILLs on user
> > processes, particularly large complicated shell scripts like
> > configure on an RM9k platform.
> 
> This was more or less exactly what I was seeing on an O2 RM7000 setup
> until the fix for errata #28 was put in (which should already be
> enabled for RM9000 systems).
> 
> Check include/asm-mips/war.h and make sure your machine is included
> in the list that define ICACHE_REFILLS_WORKAROUND_WAR.  If not, add
> it and test; and fire off a patch.  Should fix that issue (especially
> if bash is the only userland process dying while complex g++ compiles
> behave fine)

Thanks, I had added this about a month ago, but the l-users were
reporting that the problem persisted.  Now that I've had a chance to
examine it myself, it appears they were confused.  There's a first time
for everything.

I will be sending some patches to be sure, once I get all the bugs
worked out.  This architecture, a bifurcated RM9000x2 together with a
marvell south bridge, is a searing pain I have to deal with daily.

Cheers,

a
