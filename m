Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 17:00:10 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:60296
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226719AbVGNP7w>; Thu, 14 Jul 2005 16:59:52 +0100
Received: (qmail 25153 invoked from network); 14 Jul 2005 16:01:04 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 14 Jul 2005 16:01:04 -0000
Subject: Re: CVS Update@linux-mips.org: linux
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61L.0507141653440.31857@blysk.ds.pg.gda.pl>
References: <20050714001711Z8226701-3678+2977@linux-mips.org>
	 <Pine.LNX.4.61L.0507141120450.31857@blysk.ds.pg.gda.pl>
	 <1121356260.4797.364.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507141653440.31857@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 14 Jul 2005 09:01:10 -0700
Message-Id: <1121356870.4797.369.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-14 at 16:59 +0100, Maciej W. Rozycki wrote:
> On Thu, 14 Jul 2005, Pete Popov wrote:
> 
> > >  Hmm, I think you should include <ioremap.h> instead as that's the header 
> > > and not <asm/io.h> that provides the necessary bit for <asm/pgtable.h>.
> > 
> > I think I did and it couldn't pick up the right one since we have the
> > generic one and then the cpu specific version.
> 
>  That would be strange -- the system-specific one (note it's not 
> CPU-specific) should precede the generic one in the inclusion path list.  
> And how does <asm/io.h> pick the right one then?

No idea, didn't spend enough time on it. I'll do another compile with
ioremap.h instead and see what the problem was and if it can be easily
fixed.

Pete
