Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 20:56:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50131 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492504Ab0CPTzx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Mar 2010 20:55:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2GJtpAM008347;
        Tue, 16 Mar 2010 20:55:51 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2GJtpP1008346;
        Tue, 16 Mar 2010 20:55:51 +0100
Date:   Tue, 16 Mar 2010 20:55:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Preliminary vdso.
Message-ID: <20100316195551.GE20160@linux-mips.org>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
 <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 18, 2010 at 04:13:04PM -0800, David Daney wrote:

> This is a preliminary patch to add a vdso to all user processes.
> Still missing are ELF headers and .eh_frame information.  But it is
> enough to allow us to move signal trampolines off of the stack.  Note
> that emulation of branch delay slots in the FPU emulator still
> requires the stack.
> 
> We allocate a single page (the vdso) and write all possible signal
> trampolines into it.  The stack is moved down by one page and the vdso
> is mapped into this space.

Thanks, applied.

  Ralf
