Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 16:49:57 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:10363
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226701AbVGNPtl>; Thu, 14 Jul 2005 16:49:41 +0100
Received: (qmail 16913 invoked from network); 14 Jul 2005 15:50:54 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 14 Jul 2005 15:50:53 -0000
Subject: Re: CVS Update@linux-mips.org: linux
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61L.0507141120450.31857@blysk.ds.pg.gda.pl>
References: <20050714001711Z8226701-3678+2977@linux-mips.org>
	 <Pine.LNX.4.61L.0507141120450.31857@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 14 Jul 2005 08:51:00 -0700
Message-Id: <1121356260.4797.364.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-14 at 16:35 +0100, Maciej W. Rozycki wrote:
> On Thu, 14 Jul 2005 ppopov@linux-mips.org wrote:
> 
> > Modified files:
> > 	include/asm-mips: pgtable.h 
> > 	include/asm-mips/mach-au1x00: ioremap.h 
> > 
> > Log message:
> > 	Fix the fixup_bigphys_addr compile problem.
> 
>  Hmm, I think you should include <ioremap.h> instead as that's the header 
> and not <asm/io.h> that provides the necessary bit for <asm/pgtable.h>.

I think I did and it couldn't pick up the right one since we have the
generic one and then the cpu specific version.

Pete
