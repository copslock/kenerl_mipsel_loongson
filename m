Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 16:28:44 +0100 (BST)
Received: from ftp.linux-mips.org ([IPv6:::ffff:62.254.210.162]:1951 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225512AbTIVP2m>; Mon, 22 Sep 2003 16:28:42 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8MFSZXP007276
	for <linux-mips@linux-mips.org>; Mon, 22 Sep 2003 08:28:35 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8LG0XWB032559;
	Sun, 21 Sep 2003 09:00:33 -0700
Date: Sun, 21 Sep 2003 09:00:33 -0700
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Impossible fixup in do_ade
Message-ID: <20030921160033.GA31814@linux-mips.org>
References: <20030920152036.GA12905@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920152036.GA12905@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 20, 2003 at 11:20:36AM -0400, Daniel Jacobowitz wrote:

> Here's a snippet from emulate_load_store_insn.  See the way the sdl and sdr
> are wrapped in fixups?  Well, the fixups can't trigger: we get to
> emulate_load_store_insn a second time, and we hit the fact that sdl_op has a
> "goto sigbus" before we hit the fixup_exception call.
> 
> It doesn't much matter, the bug I'm working on is whatever caused the first
> call.  But we get a SIGBUS when arguably we ought to get a SIGSEGV.

The fixup can be triggered - think of an missaligned load or store
inside the kernel itself.  If there's no fixup we'll simply assume the
instruction was in userspace and send a signal which is true unless there's
a kernel bug.

In case we deliver a signal at fault: I think it's arguable what signal is
the most appropriate one but for simplicity I decieded to consider the
address error exception as the cause so SIGBUS is the right signal.  We
simply don't gather sufficient information to deciede what the right
signal to send is and it's a very rare case anyway so nobody noticed yet :)

  Ralf
