Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 16:00:33 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:38767 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012876AbaKGPAcH63pK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 16:00:32 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 76A071538A; Fri,  7 Nov 2014 15:00:25 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant divisor
References: <1415290998-10328-1-git-send-email-mans@mansr.com>
        <20141107005031.GA22697@linux-mips.org>
        <yw1xbnojkazo.fsf@unicorn.mansr.com>
        <20141107113545.GC24423@linux-mips.org>
Date:   Fri, 07 Nov 2014 15:00:25 +0000
In-Reply-To: <20141107113545.GC24423@linux-mips.org> (Ralf Baechle's message
        of "Fri, 7 Nov 2014 12:35:45 +0100")
Message-ID: <yw1x389vjbsm.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Ralf Baechle <ralf@linux-mips.org> writes:

> On Fri, Nov 07, 2014 at 02:20:11AM +0000, Måns Rullgård wrote:
>> Date:   Fri, 07 Nov 2014 02:20:11 +0000
>> From: Måns Rullgård <mans@mansr.com>
>> To: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant
>>  divisor
>> Content-Type: text/plain; charset=iso-8859-1
>> 
>> Ralf Baechle <ralf@linux-mips.org> writes:
>> 
>> > On Thu, Nov 06, 2014 at 04:23:18PM +0000, Mans Rullgard wrote:
>> >
>> >> This is an adaptation of the optimised do_div() for ARM by
>> >> Nicolas Pitre implementing division by a constant using a
>> >> multiplication by the inverse.  Ideally, the compiler would
>> >> do this internally as it does for 32-bit operands, but it
>> >> doesn't.
>> >> 
>> >> This version of the code requires an assembler with support
>> >> for the DSP ASE syntax since accessing the hi/lo registers
>> >> sanely from inline asm is impossible without this.  Building
>> >> for a CPU without this extension still works, however.
>> >> 
>> >> It also does not protect against the WAR hazards for the
>> >> hi/lo registers present on CPUs prior to MIPS IV.
>> >> 
>> >> I have only tested it as far as booting and light use with
>> >> the BUG_ON enabled wihtout encountering any issues.
>> >> 
>> >> The inverse computation code is a straight copy from ARM,
>> >> so this should probably be moved to a shared location.
>> >
>> > Can you explain why you need __div64_fls()?  There's __fls() which on
>> > MIPS is carefully written to make use of the CLZ rsp. DCLZ instructions
>> > where available; the fallback implementation is looking fairly similar
>> > to your code.
>> 
>> The regular __fls() doesn't necessarily evaluate at compile-time, which
>> is required here.  The normal __fls() could of course be amended to
>> bypass the CLZ instruction for constant arguments.
>> 
>> > MADD is named MAD on some older CPUs; yet other CPUs don't have it
>> > at all.  I take it you tried to make GCC emit the instruction but it
>> > doesn't?
>> 
>> GCC generates MADDU instructions only in the most trivial of cases.  For
>> instance, (x >> 32) * (u32)y with 64-bit x and y produces far from
>> optimal code.  In fact, looking at it again, I see it is even more
>> stupid than I thought, so there needs to be more asm, not less.
>> 
>> Reading the manuals more carefully, it appears that MADDU is only
>> reliably available starting with MIPS32 (btw, this information is
>> annoyingly hard to find).  Thus this code should be restricted to such
>> targets (which probably covers most current users) unless someone feels
>> like writing a version for these older CPUs.
>
> I'm primarily concered about not enabling MADD where it's not available.
> As for pre-MIPS32 processors - we can do the manual reading about where
> to enable MAD(D) later.

A simple ifdef will take care of that.

> As for access to hi/lo, I tried to explicitly put a variable in the lo
> register.  Which sort of works for very simple cases but as expected it's
> easy to get GCC to spill its RTL guts because it runs out of spill
> registers.  It maybe can be made to work but I'd feel nervous about its
> stability unless a GCC guru approved this method.

The "x" constraint can be used to move a double-word to/from the hi/lo
registers.  On DSP targets, the "ka" constraint provides access to the
three additional hi/lo pairs while on a non-DSP targets it degenerates
to "x".  The "ka" constraint is available since gcc 4.3.0.  I see no
reason not to allow this extra flexibility.

-- 
Måns Rullgård
mans@mansr.com
