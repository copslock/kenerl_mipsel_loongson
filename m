Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2014 03:18:42 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:41651 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012847AbaKHCSlGc-rV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Nov 2014 03:18:41 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id ED4A01538A; Sat,  8 Nov 2014 02:18:33 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant divisor
References: <1415290998-10328-1-git-send-email-mans@mansr.com>
        <20141107005031.GA22697@linux-mips.org>
        <yw1xbnojkazo.fsf@unicorn.mansr.com>
        <20141107113545.GC24423@linux-mips.org>
        <yw1x389vjbsm.fsf@unicorn.mansr.com> <545D10DE.5000804@gmail.com>
Date:   Sat, 08 Nov 2014 02:18:33 +0000
In-Reply-To: <545D10DE.5000804@gmail.com> (David Daney's message of "Fri, 07
        Nov 2014 10:35:10 -0800")
Message-ID: <yw1xtx2aigee.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43928
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

David Daney <ddaney.cavm@gmail.com> writes:

> On 11/07/2014 07:00 AM, Måns Rullgård wrote:
> [...]
>>
>>> As for access to hi/lo, I tried to explicitly put a variable in the lo
>>> register.  Which sort of works for very simple cases but as expected it's
>>> easy to get GCC to spill its RTL guts because it runs out of spill
>>> registers.  It maybe can be made to work but I'd feel nervous about its
>>> stability unless a GCC guru approved this method.
>>
>> The "x" constraint can be used to move a double-word to/from the hi/lo
>> registers.  On DSP targets, the "ka" constraint provides access to the
>> three additional hi/lo pairs while on a non-DSP targets it degenerates
>> to "x".  The "ka" constraint is available since gcc 4.3.0.  I see no
>> reason not to allow this extra flexibility.
>
> What would the performance penalty be to hand code the assembly so
> that only mips32 instructions are used (i.e. no MADD), and transfers
> from hi/lo were all explicitly coded so that there were no hi/lo
> register constraints, but only clobbers of "hi", "lo"?

It's hard to say in absolute numbers.  However, the pre-mips32
equivalent of MADDU looks something like this:

        multu   $4, $5
        mflo    $6
        mfhi    $7
        addu    $8, $8, $6
        addu    $9, $9, $7
        sltu    $6, $8, $6
        addu    $9, $9, $6

-- 
Måns Rullgård
mans@mansr.com
