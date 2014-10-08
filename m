Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 04:38:42 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49823 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006151AbaJHCikVM3EE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 04:38:40 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1Xbh89-0003Fx-00; Wed, 08 Oct 2014 02:37:33 +0000
Date:   Tue, 7 Oct 2014 22:37:33 -0400
From:   Rich Felker <dalias@libc.org>
To:     Chuck Ebbert <cebbert.lkml@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141008023733.GO23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
 <20141007232019.GA30470@linux-mips.org>
 <54347E47.1080809@caviumnetworks.com>
 <20141007191833.4d625472@as>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141007191833.4d625472@as>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@libc.org
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

On Tue, Oct 07, 2014 at 07:18:33PM -0500, Chuck Ebbert wrote:
> On Tue, 7 Oct 2014 16:59:03 -0700
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
> > On 10/07/2014 04:20 PM, Ralf Baechle wrote:
> > > On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
> > >
> > >>> As an alternative, if the space of possible instruction with a delay
> > >>> slot is sufficiently small, all such instructions could be mapped as
> > >>> immutable code in a shared mapping, each at a fixed offset in the
> > >>> mapping. I suspect this would be borderline-impractical (multiple
> > >>> megabytes?), but it is the cleanest solution otherwise.
> > >>>
> > >>
> > >> Yes, there are 2^32 possible instructions.  Each one is 4 bytes, plus you
> > >> need a way to exit after the instruction has executed, which would require
> > >> another instruction.  So you would need 32GB of memory to hold all those
> > >> instructions, larger than the 32-bit virtual address space.
> > >
> > > Plus errata support for some older CPUs requires no other instructions
> > > that might cause an exception to be present in the same cache line inflating
> > > the size to 32 bytes per instruction.
> > >
> > > I've contemplated a full emulation - but that would require an emulator that
> > > is capable of most of the instruction set.  With all the random ASEs around
> > > that would be hard to implement while the FPU emulator trampoline as currently
> > > used has the advantage of automatically supporting ASEs, known and unknown.
> > > So it's a huge bonus for maintenance.
> > >
> > 
> > Unfortunatly it breaks when our friends at Imgtec introduce their PC 
> > relative instructions in mipsr6, so an emulator may be unavoidable.
> > 
> 
> The x86 kprobes code deals with executing relocated insns with
> PC-relative offsets by adjusting the offset in a relocated instruction
> before executing it.
> 
> See arch/x86/kernel/kprobes/core.c::__copy_instruction()

This only works if you have an ISA that can represent the full range
of possible relative addresses. It does not work for MIPS where the
range is quite restricted by the fixed instruction size.

Rich
