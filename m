Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 04:53:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38845 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027688AbWIGDxz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 04:53:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k873sRCx025973;
	Thu, 7 Sep 2006 05:54:27 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k873sObJ025972;
	Thu, 7 Sep 2006 05:54:24 +0200
Date:	Thu, 7 Sep 2006 05:54:24 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nida M <nidajm@gmail.com>
Cc:	"Kevin D. Kissell" <KevinK@mips.com>, linux-mips@linux-mips.org
Subject: Re: single step in MIPS
Message-ID: <20060907035424.GB17965@linux-mips.org>
References: <b01966ec0609020445m693b53cfj87d31a4957627f1a@mail.gmail.com> <000b01c6cea8$7d480fa0$a803a8c0@Ulysses> <b01966ec0609032157s35d8c0bdx900956f214c5337b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01966ec0609032157s35d8c0bdx900956f214c5337b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 04, 2006 at 10:27:12AM +0530, Nida M wrote:

> Well this is ok ..but I am trying to implement kenel debugger..
> something like system tap.
> And I have started with kprobe..
> where the kernel code execution will be stopped at user specified
> address using break, how do i single step that instruction to decode
> the instruction and print the registers value..?

Insert a breakpoint instruction after the instruction you want to single
step. Anything that triggers an exception but typicall a "break 0" would
be used for debuggers.  Branches need special care.  Either they need to
be executed in software or breakpoints at both the branch-taken and the
not-taken address need to be inserted.

Just to make this more entertaining, the kernel is a multithreaed piece
of software, even if you only have a single processor and you do not
necessarily want the singlestepping break point to be taken by each
thread / process, so you want to implement some filtering in the
exception handler.

Executing the instruction that has been replaced with a breakpoint takes
an interesting hack as well.  Copy that instruction to the stackframe,
perform the necessary cacheflushes so the CPU will actually fetch the
right instruction.  Then jump to that instruction.  Obviously that needs
to be followed by a jump to the logical next instruction.

And with all those hints I leave the special case of instructions in
branch delay slots to the you, I'm sure you'll find it trivial ;-)

The FPU emulator in the kernel implements this btw.  Not for single
stepping but for entirely different reasons but you may want to look
at it.

  Ralf
