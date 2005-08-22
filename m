Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2005 12:44:48 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:32531 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225357AbVHVLo2>; Mon, 22 Aug 2005 12:44:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 656BEE1C99; Mon, 22 Aug 2005 13:49:43 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13737-06; Mon, 22 Aug 2005 13:49:43 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2BBC4E1C82; Mon, 22 Aug 2005 13:49:43 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j7MBnkbf027909;
	Mon, 22 Aug 2005 13:49:46 +0200
Date:	Mon, 22 Aug 2005 12:49:52 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050822102610.GB3780@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0508221242540.26914@blysk.ds.pg.gda.pl>
References: <20050820142723Z8225252-3678+7060@linux-mips.org>
 <Pine.LNX.4.61L.0508221013180.26914@blysk.ds.pg.gda.pl>
 <20050822102610.GB3780@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Aug 2005, Ralf Baechle wrote:

> >  Well, since they use a different controller structure and different 
> > functions, the user-visible name should be different too, shouldn't it?  
> > To be original ;-) -- how about "MIPS-MT"?
> 
> Thought about but then it's still hammering at the same old bits which
> now just have received a different use.

 Using another structure is enough for justification -- it's a different 
"controller".  Similarly the two variations of interrupts handled in 
arch/mips/dec/ioasic-irq.c are almost the same (the difference is even 
smaller than here), but using separate structures made me use different 
names.

  Maciej
