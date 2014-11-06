Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2014 18:42:42 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:34535 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012733AbaKFRmkzCU3z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Nov 2014 18:42:40 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id AAB491538C; Thu,  6 Nov 2014 17:42:34 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant divisor
References: <1415290998-10328-1-git-send-email-mans@mansr.com>
        <545BAB03.7050600@gmail.com>
Date:   Thu, 06 Nov 2014 17:42:34 +0000
In-Reply-To: <545BAB03.7050600@gmail.com> (David Daney's message of "Thu, 06
        Nov 2014 09:08:19 -0800")
Message-ID: <yw1x8ujokyyd.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43883
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

> On 11/06/2014 08:23 AM, Mans Rullgard wrote:
>> This is an adaptation of the optimised do_div() for ARM by
>> Nicolas Pitre implementing division by a constant using a
>> multiplication by the inverse.  Ideally, the compiler would
>> do this internally as it does for 32-bit operands, but it
>> doesn't.
>>
>> This version of the code requires an assembler with support
>> for the DSP ASE syntax since accessing the hi/lo registers
>> sanely from inline asm is impossible without this.
>
> It is easy to access hi/lo from inline asm.  It is true that it is
> difficult to use them as input/output registers.

Of course they can be accessed directly, but that tends to produce worse
code since the compiler then can't schedule the mfhi/mflo (or mthi/mtlo
on entry to the asm) around other instructions to avoid stalling.

> You should use MFHI/MFLO and to move the results to some general
> purpose registers.  Then mention "hi", "lo" in the clobbers statement
> for the inline asm.

In some cases, results in needless bouncing between hi/lo and gprs.
It's better to let the compiler decide if and when to retrieve the
values.

Moreover, using "ka" constraints lets the compiler use the additional
accumulator registers available on CPUs with the DSP ASE.

> FWIW, it seems like you are missing the clobbers in your inline asm below.

No clobbers are needed when using explicit input/output arguments.  In
fact, if hi/lo were marked as clobbered this would fail to compile as
these would then be unavailable as inputs or outputs.

Is there a compelling reason to support old assembler versions without
this syntax?  I'm not sure when this was added, but I see references to
it from 2005.

-- 
Måns Rullgård
mans@mansr.com
