Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:11:33 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49808 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010745AbaJGTLboVu5H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:11:31 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1Xba8l-0002Mp-00; Tue, 07 Oct 2014 19:09:43 +0000
Date:   Tue, 7 Oct 2014 15:09:43 -0400
From:   Rich Felker <dalias@libc.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141007190943.GM23797@brightrain.aerifal.cx>
References: <20141006215813.GB23797@brightrain.aerifal.cx>
 <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com>
 <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com>
 <20141007004915.GF23797@brightrain.aerifal.cx>
 <54337127.40806@gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
 <543431DA.4090809@imgtec.com>
 <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43081
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

On Tue, Oct 07, 2014 at 11:44:35AM -0700, Andy Lutomirski wrote:
> > 4)  The voice for doing any instruction emulation in kernel - it is not a
> > MIPS business model to force customer to put details of all Coprocessor 2
> > instructions public. We provide an interface and the rest is a customer
> > business. Besides that it is really painful to make a differentiation
> > between Cavium Octeon and some another CPU instructions with the same
> > opcode. On other side, leaving emulation of their instructions to them is
> > not a wise after having some good way doing that multiple years.
> 
> IMO this is all backwards.  If MIPS customers put proprietary
> instructions into their ISA, they leave out the FPU, and they put a
> proprietary insn in a branch delay slot, then I think that they
> deserve a fatal signal.

I agree completely here. We should not break things (or, as it seems,
leave them broken) for common usage cases that affect everyone just to
coddle proprietary vendor-specific instructions. The latter just
should not be used in delay slots unless the chip vendor also promises
to provide fpu branch in hardware.

Rich
