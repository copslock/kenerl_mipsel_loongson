Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 21:18:14 +0100 (BST)
Received: from mail.bawue.net ([193.7.176.63]:60561 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20025736AbXJCUSG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2007 21:18:06 +0100
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 1472EE011F;
	Wed,  3 Oct 2007 22:18:12 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IdAfQ-00083F-8L; Wed, 03 Oct 2007 21:18:00 +0100
Date:	Wed, 3 Oct 2007 21:18:00 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071003201800.GP16772@networkno.de>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4703F155.4000301@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Thiemo Seufer wrote:
> > 
> > Then you have the worst of both approaches: The nicely readable
> > disassembly will change under you feet, and you still need
> > relocation annotations etc. for CPU-specific fixups. The end-result
> > is likely more complicated and opaque than what we have now.
> 
> Let say we generate handlers with all possible cpu fixups. Very few
> instructions would be removed so the disassembly should be quite
> similar after patching.

No way. Just check the possible variations: 64bit, highmem, SMP,
and so on.

> And by emitting some nice comments in the
> generated code, it should be fairly obvious to get an idea of the
> final code.
> 
> All fixups would be listed in a table with some flags to identify them
> and a list of instructions which need to be relocated.

At that point you have invented something which effectively emits
the sourcecode for tlbex.c.

> It seems to me that the kernel code would be much simpler than what we
> have now. Regarding the script used to generate the assembly code, if
> think it would be too.

I doubt that.


Thiemo
