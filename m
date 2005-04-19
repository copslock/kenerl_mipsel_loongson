Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 17:50:49 +0100 (BST)
Received: from smtp.uk.colt.net ([IPv6:::ffff:195.110.64.125]:30662 "EHLO
	smtp.uk.colt.net") by linux-mips.org with ESMTP id <S8226243AbVDSQue>;
	Tue, 19 Apr 2005 17:50:34 +0100
Received: from euskadi.packetvision (unknown [213.86.106.84])
	by smtp.uk.colt.net (Postfix) with ESMTP id 01819E7077
	for <linux-mips@linux-mips.org>; Tue, 19 Apr 2005 17:42:53 +0100 (BST)
Subject: Re: Building native binutils/gcc/glibc
From:	Alex Gonzalez <alex.gonzalez@packetvision.com>
To:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0504191214580.14774@blysk.ds.pg.gda.pl>
References: <1113843806.4266.20.camel@euskadi.packetvision>
	 <Pine.LNX.4.61L.0504191214580.14774@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1113929447.31725.1.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Tue, 19 Apr 2005 17:50:47 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <alex.gonzalez@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.gonzalez@packetvision.com
Precedence: bulk
X-list: linux-mips

Thanks a lot, binutils-2.15 worked.
Alex

On Tue, 2005-04-19 at 12:16, Maciej W. Rozycki wrote:
> On Mon, 18 Apr 2005, Alex Gonzalez wrote:
> 
> > I am trying to cross compile native binutils/gcc and glibc to be able to
> > build on the target, using:
> > 
> > binutils 2.14
> > gcc 3.3.5
> > glibc 2.3.5
> [...]
> > /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/ld: ./ccYlX6Ij.o: linking abicalls files with non-abicalls files
> > Bad value: failed to merge target specific data of file ./ccYlX6Ij.o
> > collect2: ld returned 1 exit status
> 
>  Update binutils.
> 
>   Maciej
> 
