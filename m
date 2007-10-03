Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 14:42:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23981 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021491AbXJCNmA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 14:42:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l93DfxVY028851;
	Wed, 3 Oct 2007 14:41:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l93DfwY7028850;
	Wed, 3 Oct 2007 14:41:58 +0100
Date:	Wed, 3 Oct 2007 14:41:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071003134158.GA28742@linux-mips.org>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47038874.9050704@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 03, 2007 at 02:17:56PM +0200, Franck Bui-Huu wrote:

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
> using a tools/scripts during the build process. This tool could emit
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
> 
> Just a thought but I'm probably missing something.

We went for the runtime generation because this is about the only sane
way we can get support for the widest range of cores yet not compromise
on performance.  Maintaining the previous generation of that code which
was like a dozen variants of page clearing, copying and TLB exception
handlers was definately more tedious than this.

  Ralf
