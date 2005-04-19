Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 12:16:26 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:24334 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225845AbVDSLQK>; Tue, 19 Apr 2005 12:16:10 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 488D6F597E; Tue, 19 Apr 2005 13:16:00 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02129-02; Tue, 19 Apr 2005 13:16:00 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8FD0DE1C7A; Tue, 19 Apr 2005 13:15:59 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j3JBG04M016736;
	Tue, 19 Apr 2005 13:16:01 +0200
Date:	Tue, 19 Apr 2005 12:16:06 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alex Gonzalez <alex.gonzalez@packetvision.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Building native binutils/gcc/glibc
In-Reply-To: <1113843806.4266.20.camel@euskadi.packetvision>
Message-ID: <Pine.LNX.4.61L.0504191214580.14774@blysk.ds.pg.gda.pl>
References: <1113843806.4266.20.camel@euskadi.packetvision>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/840/Tue Apr 19 03:42:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Apr 2005, Alex Gonzalez wrote:

> I am trying to cross compile native binutils/gcc and glibc to be able to
> build on the target, using:
> 
> binutils 2.14
> gcc 3.3.5
> glibc 2.3.5
[...]
> /bin/../lib/gcc-lib/mips-linux-gnu/3.3.5/../../../../mips-linux-gnu/bin/ld: ./ccYlX6Ij.o: linking abicalls files with non-abicalls files
> Bad value: failed to merge target specific data of file ./ccYlX6Ij.o
> collect2: ld returned 1 exit status

 Update binutils.

  Maciej
