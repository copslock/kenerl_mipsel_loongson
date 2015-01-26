Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 20:39:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54209 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbbAZTjWthrUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 20:39:22 +0100
Date:   Mon, 26 Jan 2015 19:39:22 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <54C68429.4030701@gmail.com>
Message-ID: <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
 <54C68429.4030701@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 26 Jan 2015, David Daney wrote:

> >   Out of curiosity -- what was there that made it so ugly?  The need for
> > case-by-case individual handling of byte-swapping the qualifying members
> > of syscall and signal data structures such as `struct stat'?  Obviously
> > not alignment trap fixups, these are trivial to handle.  And I think
> > pretty much everything else is endianness-agnostic.
> >
> 
> I think *nothing* is endianness-agnostic.  The instruction set reference
> manual (MD00087 MIPS® Architecture For Programmers Volume II-A: The MIPS64®
> Instruction Set, Revision 5.02) is a little cryptic, but I think looking at
> the LB instruction shows how it works.  OCTEON is known to implement this and
> has been verified to work this way.
> 
> aligned 64-bit loads and stores are endianness invariant.
> 
> 32-bit loads and stores have even and odd words swapped in the opposite
> endianness (low order 3 address bits are XOR 4).
> 
> 16-bit loads and stores half words scrambled in the opposite endianness (low
> order 3 address bits are XOR 6).
> 
> 8-bit loads and stores are scrambled such that the low order 3 address bits
> are XOR 7 in the opposite endianness.
> 
> The result that all byte array data is scrambled when switching endianness.

 But that does not matter as long as the endianness used for reads and one 
used for writes is the same.  Which is going to be the case for user 
software as long as it does not call into the kernel.  The two key points 
are syscalls and signals.  Ah, and the binary loader (e.g. ELF) has to 
byte-swap structures in executable and shared library headers too.

> This means that all read(), write() and similar calls could *not* access the
> user data in-place in the kernel.  The kernel would have to  swap around the
> bytes before using it.  mmap() of the same file in processes of opposite
> endianness would be impossible, as one of the processes would see scrambled
> data.

 Well, read(2), write(2) and similar calls operate on byte streams, these 
are endianness agnostic (like the text of this e-mail for example is -- 
it's stored in memory of a byte-addressed computer the same way regardless 
of its processor's endianness).  You're right about this specific use case 
of mmap(2), but why would you want sharing endianness-specific data 
between two processes of the opposite endiannesses in the first place?  
It's already no different to copying such a binary file between systems of 
the opposite endiannesses -- you need to use export/import tools and a 
portable data encoding format such as XDR or text.  This is how you can 
for example make RPC calls between systems of the opposite endiannesses.

 In the simplest scenario you'd run all your userland with the same 
endianness anyway -- e.g. because you want to validate your user software, 
but only have a machine whose bootstrap endianness is hardwired and cannot 
be set to match your requirement.

> For this reason, it really only makes sense to have the kernel and user-space
> use the same endianness.
> 
> And because kernel and userspace must have the same endianness, the endianness
> can be probed in userspace without consulting the kernel.

 Well, I maintain that it's only data structures passed around syscalls 
and signal handlers that matter here.  Their contents will be interpreted 
differently by the kernel and by user code and therefore have to be 
byte-swapped in transit.  There is no issue with integers passed via 
registers, that have no endianness defined.  And we are also lucky enough 
not to swap register pairs for double-precision integers depending on the 
endianness, unlike with ABIs for some other processor architectures.

  Maciej
