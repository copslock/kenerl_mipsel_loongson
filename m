Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 12:32:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36487 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010829AbaJHKcAw8V0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 12:32:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C72BC70F6B0E4;
        Wed,  8 Oct 2014 11:31:51 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 8 Oct
 2014 11:31:54 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 8 Oct 2014 11:31:53 +0100
Received: from localhost (192.168.159.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 8 Oct
 2014 11:31:51 +0100
Date:   Wed, 8 Oct 2014 11:31:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Rich Felker <dalias@libc.org>,
        "David Daney" <ddaney.cavm@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141008103149.GO4704@pburton-laptop>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
 <20141007232019.GA30470@linux-mips.org>
 <54347E47.1080809@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <54347E47.1080809@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Tue, Oct 07, 2014 at 04:59:03PM -0700, David Daney wrote:
> On 10/07/2014 04:20 PM, Ralf Baechle wrote:
> >On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
> >
> >>>As an alternative, if the space of possible instruction with a delay
> >>>slot is sufficiently small, all such instructions could be mapped as
> >>>immutable code in a shared mapping, each at a fixed offset in the
> >>>mapping. I suspect this would be borderline-impractical (multiple
> >>>megabytes?), but it is the cleanest solution otherwise.
> >>>
> >>
> >>Yes, there are 2^32 possible instructions.  Each one is 4 bytes, plus you
> >>need a way to exit after the instruction has executed, which would require
> >>another instruction.  So you would need 32GB of memory to hold all those
> >>instructions, larger than the 32-bit virtual address space.
> >
> >Plus errata support for some older CPUs requires no other instructions
> >that might cause an exception to be present in the same cache line inflating
> >the size to 32 bytes per instruction.
> >
> >I've contemplated a full emulation - but that would require an emulator that
> >is capable of most of the instruction set.  With all the random ASEs around
> >that would be hard to implement while the FPU emulator trampoline as currently
> >used has the advantage of automatically supporting ASEs, known and unknown.
> >So it's a huge bonus for maintenance.
> >
> 
> Unfortunatly it breaks when our friends at Imgtec introduce their PC
> relative instructions in mipsr6, so an emulator may be unavoidable.
> 
> David Daney

Just to note, this was also discussed when I submitted my much older
patch with a similar goal:

  http://patchwork.linux-mips.org/patch/6125/

...and the conclusion there also began converging towards full ISA
emulation (or at least, the subset of the ISA which userland can
execute):

  http://www.linux-mips.org/archives/linux-mips/2014-07/msg00034.html

For the record my preference is for emulation. It is in some ways more
work, but it's also much cleaner. Given that more instructions will need
to be emulated to run pre-R6 binaries on R6 systems anyway, the emulator
would only become increasingly useful.

Paul
