Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 17:01:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:65474 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20036890AbXJOQBL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 17:01:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9FG19Df018028;
	Mon, 15 Oct 2007 17:01:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9FG19r5018027;
	Mon, 15 Oct 2007 17:01:09 +0100
Date:	Mon, 15 Oct 2007 17:01:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
Message-ID: <20071015160109.GA11048@linux-mips.org>
References: <470DF25E.60009@gmail.com> <20071011124410.GA17202@linux-mips.org> <47127110.4060206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47127110.4060206@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 14, 2007 at 09:42:08PM +0200, Franck Bui-Huu wrote:

> > .exit.data and .exit.text may reference each other.  __exit functions
> > generally get compiled into .exit.text but some constructs such as jump
> > tables for switch() constructs may be compiled into address tables which
> > gcc unfortunately will put into .rodata, so .rodata will end up
> > referencing function addresses in .exit.text which makes ld unhappy if
> > .exit.text was discarded.  So until this is fixed in gcc we can't
> > discard exit code, unfortunately.
> > 
> 
> Thanks for the details.
> 
> I actually don't see any point to move these tables in .rodata since
> they're part of the code...

As I recall the argumentation was they should go there because that section
can be marked no-exec.  Which isn't terribly useful on MIPS where only
very few processors have the no-exec capability.

Anyway, I guess it takes somebody to cook a patch :-)

  Ralf
