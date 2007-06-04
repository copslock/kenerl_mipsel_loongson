Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 21:57:15 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:1667 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20022535AbXFDU5N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 21:57:13 +0100
Received: (qmail 13127 invoked from network); 4 Jun 2007 20:56:59 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 4 Jun 2007 20:56:59 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.63)
	(envelope-from <joseph@codesourcery.com>)
	id 1HvJbl-0004bH-Hs; Mon, 04 Jun 2007 20:56:57 +0000
Date:	Mon, 4 Jun 2007 20:56:57 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: 64-bit syscall ABI issue
Message-ID: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

When arguments of types narrower than a register are passed to a C 
function in a register, the ABI typically requires that they be 
sign-extended or zero-extended to the full width of the register.  The 
compiler, generating code for the called function, may presume that the 
registers have been properly extended (and GCC is getting increasingly 
good at avoiding redundant sign and zero extensions).  In turn, it may 
generate instructions for which the processor presumes the values for 
properly extended - for example, on MIPS64, 32-bit arithmetic instructions 
are documented as yielding unpredicatable results if the operands are not 
sign-extended to 64 bits.

Consider, for example, 
<http://sourceware.org/bugzilla/show_bug.cgi?id=4459>.  Here glibc has 
passed an improperly extended value to a syscall, so the syscall 
implementation (written in C) receives a register value not conforming to 
the ABI, and undefined behavior in the kernel duly ensues.  Depending on 
the particular form the undefined behavior takes for a given function, 
compiler and CPU implementation, security issues might arise if sanity 
checks of the arguments to a syscall fail to allow for values that can be 
passed in registers but are beyond those permitted by the ABI.

What should the kernel syscall ABI be in such cases (any case where the 
syscall implementations expect arguments narrower than registers, so 
mainly 32-bit arguments on 64-bit platforms)?  There are two obvious 
possibilities:

(a) The upper bits of 32-bit syscall arguments are undefined, the kernel 
should deal with this.

(b) The upper bits of 32-bit syscall arguments must be extended according 
to the ABI, the kernel should detect invalid register values and treat 
them as erroneous syscall arguments (probably returning EINVAL).


In either case, the kernel needs a way to handle the improperly extended 
syscall arguments.  Possibilities include:

* For (a), a new compiler option (or function attribute) to change the ABI 
so that improperly extended arguments are valid; the compiler would then 
generate the necessary code to convert them to properly extended values in 
registers.

* Code at the assembly level, before syscalls get passed to their C 
implementations, that uses a table of which arguments to which syscalls 
are narrower than registers and either extends (for (a)) or returns EINVAL 
for improperly extended values (for (b)).

* Making the C syscall implementations take register-sized arguments, with 
some macros to check they are properly extended (for (b)) or reduce them 
in width to variables of the narrower type (for (a)).


If (a), existing glibc is fine for 32-bit arguments on all targets - but 
cases which glibc passes a 64-bit argument and the kernel expects a 32-bit 
one (e.g. passing size_t where the kernel expects int) would have such 
arguments silently truncated to 32 bits.

If (b) (which I prefer), MIPS64 (only) would need a new glibc that 
properly sign-extends 32-bit syscall arguments to 64-bit values, in order 
to work with a kernel that detects improper extension.  This mainly 
affects -1 as a uid/gid argument - a case we see is currently broken 
anyway.  Such a glibc should work on older kernels as well, and this need 
for a glibc change should not affect platforms where unsigned 32-bit 
values are zero-extended rather than sign-extended to 64 bits.

-- 
Joseph S. Myers
joseph@codesourcery.com
