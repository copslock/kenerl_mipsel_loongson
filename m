Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 01:20:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48650 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010787AbaJGXU0fxZVN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Oct 2014 01:20:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s97NKMa9015628;
        Wed, 8 Oct 2014 01:20:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s97NKKF3015627;
        Wed, 8 Oct 2014 01:20:20 +0200
Date:   Wed, 8 Oct 2014 01:20:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Rich Felker <dalias@libc.org>, David Daney <ddaney.cavm@gmail.com>,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141007232019.GA30470@linux-mips.org>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5433071B.4050606@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:

> >As an alternative, if the space of possible instruction with a delay
> >slot is sufficiently small, all such instructions could be mapped as
> >immutable code in a shared mapping, each at a fixed offset in the
> >mapping. I suspect this would be borderline-impractical (multiple
> >megabytes?), but it is the cleanest solution otherwise.
> >
> 
> Yes, there are 2^32 possible instructions.  Each one is 4 bytes, plus you
> need a way to exit after the instruction has executed, which would require
> another instruction.  So you would need 32GB of memory to hold all those
> instructions, larger than the 32-bit virtual address space.

Plus errata support for some older CPUs requires no other instructions
that might cause an exception to be present in the same cache line inflating
the size to 32 bytes per instruction.

I've contemplated a full emulation - but that would require an emulator that
is capable of most of the instruction set.  With all the random ASEs around
that would be hard to implement while the FPU emulator trampoline as currently
used has the advantage of automatically supporting ASEs, known and unknown.
So it's a huge bonus for maintenance.

  Ralf
