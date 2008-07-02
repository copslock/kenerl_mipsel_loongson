Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 12:25:14 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:13533 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S62070260AbYGBLZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 12:25:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m62BO6VO007845;
	Wed, 2 Jul 2008 13:24:31 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m62BO5tu007818;
	Wed, 2 Jul 2008 12:24:05 +0100
Date:	Wed, 2 Jul 2008 12:24:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marian Jancar <m.jancar@satca.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/7] gcov: add gcov profiling infrastructure
Message-ID: <20080702112404.GB15896@linux-mips.org>
References: <48313DE6.30802@de.ibm.com> <20080523001136.59ec8b34.akpm@linux-foundation.org> <20080523084506.GB719@linux-mips.org> <4843DEFD.9020303@satca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4843DEFD.9020303@satca.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 02, 2008 at 01:52:29PM +0200, Marian Jancar wrote:

> Ralf Baechle wrote:
> >> {standard input}: Assembler messages:
> >> {standard input}:2716: Error: Branch out of range
> >> {standard input}:2819: Error: Branch out of range
> >> {standard input}:2884: Error: Branch out of range
> >> {standard input}:3032: Error: Branch out of range
> >> {standard input}:3097: Error: Branch out of range
> >> {standard input}:3151: Error: Branch out of range
> >> {standard input}:3216: Error: Branch out of range
> >> make[1]: *** [drivers/telephony/ixj.o] Error 1
> >> make: *** [drivers/telephony/ixj.o] Error 2
> > 
> > A known problem which I had decieded to ignore until it begins to actually
> > bite.  It's triggered by something like this
> > 
> >                 __asm__ __volatile__(
> >                 "       .set    mips3                                   \n"
> >                 "1:     ll      %0, %1          # atomic_add            \n"
> >                 "       addu    %0, %2                                  \n"
> >                 "       sc      %0, %1                                  \n"
> >                 "       beqz    %0, 2f                                  \n"
> >                 "       .subsection 2                                   \n"
> >                 "2:     b       1b                                      \n"
> >                 "       .previous                                       \n"
> >                 "       .set    mips0                                   \n"
> >                 : "=&r" (temp), "=m" (v->counter)
> >                 : "Ir" (i), "m" (v->counter));
> > 
> > when compiled into a large compilation unit.
> 
> Please unignore :) It bites when compiling madwifi (without profiling or
> anything such).

Can't reproduce this one - what is the cooking receipe based on a recent
devel kernel?

  Ralf
