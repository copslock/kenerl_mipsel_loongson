Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 16:38:40 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40977 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021903AbXHAPif (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 16:38:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C9D22E1C78;
	Wed,  1 Aug 2007 17:38:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bS4Opvxnhpuy; Wed,  1 Aug 2007 17:38:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7FF12E1C6D;
	Wed,  1 Aug 2007 17:38:30 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l71Fcelj026147;
	Wed, 1 Aug 2007 17:38:40 +0200
Date:	Wed, 1 Aug 2007 16:38:34 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B0880B.2000009@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Sergei Shtylyov wrote:

> > > Of course it will.  It shall work with whatever physical address space is
> > > supported by your MMU.  As long as the MMU is handled correctly that is,
> > > but I guess I may have omitted this clarification as obvious.
> 
> >    Even on a CPU with 36-bit physical address? ;-)
> 
>    WTF... I know I've typed "32-bit CPU"! :-/

 It does not matter.  The physical address of an I/O resource can be 
treated as a cookie that is converted, typically though an MMU, to another 
cookie that can be used with {read,write}{b,w,l}().  Of course you may 
have troubles ioremap()ping say 4GB of I/O space on a processor with a
32-bit virtual address space, but that is a corner case and typically your 
I/O space will be sparsely occupied.

 On a MIPS32 processor you have 512MB of KSEG0/1 unmapped virtual address 
space available for I/O devices located within the first 512MB of the 
physical address space plus 1GB of KSEG2 mapped virtual address space 
available for I/O devices located anywhere in the physical address space.  
That gives you from 1GB to 1.5GB of virtual address space for I/O which is 
enough for all the usual cases.

  Maciej
