Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 14:05:08 +0100 (CET)
Received: from p508B5AAD.dip.t-dialin.net ([80.139.90.173]:54674 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224847AbSLDNFH>; Wed, 4 Dec 2002 14:05:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB4D4vB31228;
	Wed, 4 Dec 2002 14:04:57 +0100
Date: Wed, 4 Dec 2002 14:04:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021204140457.C30560@linux-mips.org>
References: <3DEDBDFC.D87C1B84@mips.com> <005701c29b74$f1f76870$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005701c29b74$f1f76870$10eca8c0@grendel>; from kevink@mips.com on Wed, Dec 04, 2002 at 10:09:54AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 10:09:54AM +0100, Kevin D. Kissell wrote:

> > It look like you are only able to compile the kernel, if you got a
> > MIPS32/MIPS64 compliant compiler.

Assembler.  I'm building with egcs 1.1.2 + binutils 1.13 btw.

> I mean, sure, we'd like to move more people toward SDE, 
> but "force" is putting it a bit strongly!  And if those directives
> are really being used unconditionally, I worry that the code
> being generated is likewise emitting MIPS32 instructions
> that won't work on the "ghost fleet" of abandoned workstations
> now running Linux on R4K/R5K CPUs.

It isn't.  We've been dragging around .word stuff in our code for years
and it was time to clean tht mess.  Further we had stuff like:

  read_32bit_cp0_register(CP0_STATUS)

which is a ridiculous long macro name for something that just expands
into a single machine instruction; the macro also didn't provide for
access to another cop0 register set than set 0.  For a few TLB-related
functions we already had functions with shorter names, so two names for
doing the one and same thing.  Another problem was that the name did
already hardcode the size of the access intothe code, so the user of
those macros had to know if it was 32-bit or 64-bit.  In short it was
time to clean the mess and as it seemed that pretty much everybody was
already having a MIPS32 / MIPS64 assembler, simply always emitting a
.set mips32 / .set mips64 seemed the right thing.  That's necessary even
for accessing cop0 set 0 because gas rejects something like

  mfc0 $2, $12, 0

unless running in MIPS32 or MIPS64 mode - even though the generated opcode
is perfectly valid for MIPS I.  The 64-bit kernel was another reason for
me to go with the assumption of rather current binutils - and I'd like
to make the same assumptions on tools versions for both 32-bit and 64-bit
versions.

Anyway, it seems that my assumptions about tools versions were a bit too
agressive, so I'm going to kludge things a bit for pre-MIPS32/MIPS64
assemblers.

Deprecating support for MIPS I - IV legacy CPUs is definately not something
I'd support.  Not before x86 has died out that is ;-)

  Ralf
