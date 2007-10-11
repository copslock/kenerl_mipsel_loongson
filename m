Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 13:44:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62387 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030447AbXJKMod (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 13:44:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9BCiW2g024857;
	Thu, 11 Oct 2007 13:44:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9BCiAqo024843;
	Thu, 11 Oct 2007 13:44:10 +0100
Date:	Thu, 11 Oct 2007 13:44:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
Message-ID: <20071011124410.GA17202@linux-mips.org>
References: <470DF25E.60009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470DF25E.60009@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 11, 2007 at 11:52:30AM +0200, Franck Bui-Huu wrote:

> Other question: I noticed that the exit.data section is not
> discarded. Could anybody give me the reason why ?

.exit.data and .exit.text may reference each other.  __exit functions
generally get compiled into .exit.text but some constructs such as jump
tables for switch() constructs may be compiled into address tables which
gcc unfortunately will put into .rodata, so .rodata will end up
referencing function addresses in .exit.text which makes ld unhappy if
.exit.text was discarded.  So until this is fixed in gcc we can't
discard exit code, unfortunately.

It's actually an issue which doesn't strike very often, so users who are
desparate for shrinking the kernel down could try to undo patchsets:

  6f0b1e5d266fb1d0da019c07b56ccc02c3a4f53a
  ca7402fed2a76cd5a417ac4d375a5539dcb2b6de

and see if they can get away with it.  If the final kernel link succeeds,
the build would be ok.

I think gcc should probably put the jump table into a .subsection if
a section was explicitly requested, at least for non-PIC code.

  Ralf
