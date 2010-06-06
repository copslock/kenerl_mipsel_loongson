Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jun 2010 23:19:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60373 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492372Ab0FFVTR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jun 2010 23:19:17 +0200
Date:   Sun, 6 Jun 2010 22:19:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     adnan iqbal <adnan.iqbal@seecs.edu.pk>, linux-mips@linux-mips.org
Subject: Re: Details of MIPS(Octeon) system call semantics
In-Reply-To: <20100602133809.GA13625@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1006062144490.20820@eddie.linux-mips.org>
References: <AANLkTino_WFpj8aueN4zGwkRV-SCVqA5NGsKQOGU9qho@mail.gmail.com> <20100602133809.GA13625@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4340

On Wed, 2 Jun 2010, Ralf Baechle wrote:

> In addition to normal subroutine calls:
> 
>  o $a3 on syscall return will indicate success or error.  0 means success,
>    non-zero means an error happened in which case $v0 will contain an
>    errno.h error code.
>  o Many syscalls deviate from this convention.  For example the sigreturn
>    family of syscalls doesn't return a result or error status.
>  o pipe() will return the 2nd filedescriptor of the result in $v1.
>  o vfork is even more weird.
>  o The ABI differences mean there are many subtle difference between the
>    syscall handlers.

 All of the above plus $v0 holds the syscall number upon entry -- which 
you may effectively consider the "zeroth argument" to the call (the code 
field of the SYSCALL instruction is not used by Linux).

 Also it is mandated by the syscall restart mechanism used by signal 
delivery code that it must be the instruction physically immediately 
preceding the SYSCALL operation that places the syscall number in $v0.  
In most cases a LI operation is used, but this is not a requirement (such 
as utilised by the syscall(3) library wrapper) as long as no temporary 
registers are used to obtain the value, because in the case of a restart 
these will have been clobbered by the syscall being restarted (so e.g. lw 
$v0, 0x100($fp) is fine, but move $v0, $a3 is not).

  Maciej
