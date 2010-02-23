Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 22:35:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34239 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492409Ab0BWVfY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Feb 2010 22:35:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1NLZKr2020289;
        Tue, 23 Feb 2010 22:35:20 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1NLZI0n020288;
        Tue, 23 Feb 2010 22:35:18 +0100
Date:   Tue, 23 Feb 2010 22:35:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Preliminary vdso.
Message-ID: <20100223213518.GA19715@linux-mips.org>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
 <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com>
 <f861ec6f1002231240l40e1b07di6e751e40a2caa110@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f1002231240l40e1b07di6e751e40a2caa110@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 23, 2010 at 09:40:38PM +0100, Manuel Lauss wrote:

> > This is a preliminary patch to add a vdso to all user processes.
> > Still missing are ELF headers and .eh_frame information.  But it is
> > enough to allow us to move signal trampolines off of the stack.  Note
> > that emulation of branch delay slots in the FPU emulator still
> > requires the stack.
> >
> > We allocate a single page (the vdso) and write all possible signal
> > trampolines into it.  The stack is moved down by one page and the vdso
> > is mapped into this space.
> 
> Is there anything special required (i.e. special glibc, ..) to make use of these
> fine patches?

No - the way the signal handlers return is almost entirely hidden from
userland.  Only a few applications that have the need to unwind beyond
the signal stackframe may run into problems and have to be updated and
GDB is one of those that we identified.

  Ralf
