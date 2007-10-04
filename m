Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:46:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33230 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026435AbXJDPnx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:43:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94FgF5F010796;
	Thu, 4 Oct 2007 16:42:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94FgFmc010795;
	Thu, 4 Oct 2007 16:42:15 +0100
Date:	Thu, 4 Oct 2007 16:42:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071004154215.GA10682@linux-mips.org>
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <20071004153008.GE6897@linux-mips.org> <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710041631080.10573@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 04:35:39PM +0100, Maciej W. Rozycki wrote:

> > >  I agree the inclusion both R3k and R4k handlers at the same time even 
> > > though any configuration predetermines which of the two is only going to 
> > > be needed is a bit suboptimal indeed.
> > 
> > I guess one of the goals was to slowly clean up the stuff that forces us
> > to have different kernels for R2000 and R4000 class TLBs.
> 
>  Well, we had a plan to support multiple systems with a "generic" kernel 
> too; at least ones that have a compatible load address.  Which would help 
> distributions create their bootstrap disks for example.  I have thought 
> all of this got abandoned at one point, mostly due to the maintenance 
> effort required to keep it going long-term.  The Alpha port did it many 
> years ago, but they have a compatible bootstrap environment and their 
> number of system variations is limited, especially as compared to ours.

Anything in excessive amounts is toxic and that includes compatibility.
A true MIPS generic kernel would be hard to do.  But we have kernels that
can support all variants of the Malta even though Malta has more CPU options
than any other system.  Or for your personal toy project, all DECs wouldn't
be too hard either, or?

  Ralf
