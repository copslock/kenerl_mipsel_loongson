Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 14:12:15 +0100 (BST)
Received: from mail.bawue.net ([193.7.176.63]:8881 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024026AbXJCNMG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2007 14:12:06 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 47CE3E0154;
	Wed,  3 Oct 2007 15:12:12 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Id418-000581-Hk; Wed, 03 Oct 2007 14:11:58 +0100
Date:	Wed, 3 Oct 2007 14:11:58 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071003131158.GL16772@networkno.de>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47038874.9050704@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Ralf Baechle wrote:
> > I don't mind - it's just that I've never been a friend of leaving much
> > debugging code or features around.  99% of the time it is just make the
> > code harder to read and maintain.
> > 
> 
> Yeah this kind of code is really hard to follow and therefore hard to
> maintain I guess.
> 
> I'm wondering if we couldn't try to implement such code generator by
> using a tools/scripts during the build process.
>
> This tool could emit
> the assembler code during the early phase of the build into an
> assembler file and then it could compiled like any other one. I see a
> 3 main benefits:
> 
>   - It would simplify a lot the kernel code.
>   - Decrease the size of the kernel
>   - Easy to read the generated disassembly
> 
> One issue to deal with is that some instructions need to be emitted
> according to the type of the cpu which can only be determined at run
> time. In this case we could leave some rooms into the generated code
> for additional instructions which could be filled/patched during the
> boot time by using a 'patch table'. If the cpu doesn't need to patch
> the generated code then the useless space would be discarded when
> installing the handler in its final place.

Then you have the worst of both approaches: The nicely readable
disassembly will change under you feet, and you still need relocation
annotations etc. for CPU-specific fixups. The end-result is likely
more complicated and opaque than what we have now.


Thiemo
