Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 02:23:05 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:49756 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010597AbaJGAXDaqnAR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 02:23:03 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1XbIXD-0000A9-00; Tue, 07 Oct 2014 00:21:47 +0000
Date:   Mon, 6 Oct 2014 20:21:47 -0400
From:   Rich Felker <dalias@libc.org>
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <ddaney.cavm@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141007002147.GE23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx>
 <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx>
 <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com>
 <20141007000514.GD23797@brightrain.aerifal.cx>
 <CA+=Sn1nR2ugXUf=V9F9O6VLAP1d6WhBDioZzu0G05-8z6KMMuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Sn1nR2ugXUf=V9F9O6VLAP1d6WhBDioZzu0G05-8z6KMMuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42981
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

On Mon, Oct 06, 2014 at 05:11:38PM -0700, Andrew Pinski wrote:
> On Mon, Oct 6, 2014 at 5:05 PM, Rich Felker <dalias@libc.org> wrote:
> > On Mon, Oct 06, 2014 at 04:48:52PM -0700, David Daney wrote:
> >> On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
> >> >On 10/06/2014 02:58 PM, Rich Felker wrote:
> >> >>On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
> >> [...]
> >> >>This is a huge ill-designed mess.
> >> >
> >> >Amen.
> >> >
> >> >Can the kernel not just emulate the instructions directly?
> >>
> >> In theory it could, but since there can be implementation defined
> >> instructions, there is no way to achieve full instruction set
> >> coverage for all possible machines.
> >
> > Is the issue really implementation-defined instructions with delay
> > slots? If so it sounds like a made-up issue. They're not going to
> > occur in real binaries. Certainly a compiler is not going to generate
> > implementation-defined instructions, and if you're writing the asm by
> > hand, you just don't put floating point instructions in the delay
> > slot.
> 
> It is not the instruction with delay slot but rather the instruction
> in the delay slot itself.

An instruction in the delay slot for the instruction being emulated?
How would that arise? Are there floating point instructions with delay
slots?

Rich
