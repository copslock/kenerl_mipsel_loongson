Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 15:38:18 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35719 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492592Ab0FBNiO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 15:38:14 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o52DcBXK015715;
        Wed, 2 Jun 2010 14:38:11 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o52Dc98r015713;
        Wed, 2 Jun 2010 14:38:09 +0100
Date:   Wed, 2 Jun 2010 14:38:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     adnan iqbal <adnan.iqbal@seecs.edu.pk>
Cc:     linux-mips@linux-mips.org
Subject: Re: Details of MIPS(Octeon) system call semantics
Message-ID: <20100602133809.GA13625@linux-mips.org>
References: <AANLkTino_WFpj8aueN4zGwkRV-SCVqA5NGsKQOGU9qho@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTino_WFpj8aueN4zGwkRV-SCVqA5NGsKQOGU9qho@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 1352

On Wed, Jun 02, 2010 at 03:17:38PM +0500, adnan iqbal wrote:

> I am able to find system call list (o32 and n64) in
> /usr/include/asm/unistd.h over octeon/debian board. I am looking for details
> about these system calls so that for each system call i know exactly
> 
> 1. What parmeters should be set in which registers before syscall
> 2. Which registers contain output of those system calls.

The basic concept for all ABIs is that syscalls are working almost like
subroutine calls, so:

 o arguments are passed in $a0 - $a3 for o32
 o arguments are passed in $a0 - $a7 for N32 and N64
 o argument that don't fit into the argument registers are passed on the
   stack.
 o for details such as alignment of 64-bit arguments the usual ABI
   conventions apply
 o the result is return in $v0

In addition to normal subroutine calls:

 o $a3 on syscall return will indicate success or error.  0 means success,
   non-zero means an error happened in which case $v0 will contain an
   errno.h error code.
 o Many syscalls deviate from this convention.  For example the sigreturn
   family of syscalls doesn't return a result or error status.
 o pipe() will return the 2nd filedescriptor of the result in $v1.
 o vfork is even more weird.
 o The ABI differences mean there are many subtle difference between the
   syscall handlers.

  Ralf
