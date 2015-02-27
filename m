Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 02:46:58 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:52553 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007512AbbB0BqzqXI1s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 02:46:55 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 377E21538A; Fri, 27 Feb 2015 01:46:49 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: elf: Set O32 default FPU flags
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
        <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
        <20150227012816.GA590@fuloong-minipc.musicnaut.iki.fi>
Date:   Fri, 27 Feb 2015 01:46:49 +0000
In-Reply-To: <20150227012816.GA590@fuloong-minipc.musicnaut.iki.fi> (Aaro
        Koskinen's message of "Fri, 27 Feb 2015 03:28:16 +0200")
Message-ID: <yw1xoaog5do6.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46030
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

Aaro Koskinen <aaro.koskinen@iki.fi> writes:

> Hi,
>
> On Thu, Feb 26, 2015 at 11:11:30AM +0000, Markos Chandras wrote:
>> Set good default FPU flags (FR0) for O32 binaries similar to what the
>> kernel does for the N64/N32 ones. This also fixes a regression
>> introduced in commit 46490b572544 ("MIPS: kernel: elf: Improve the
>> overall ABI and FPU mode checks") when MIPS_O32_FP64_SUPPORT is
>> disabled. In that case, the mips_set_personality_fp() did not set the
>> FPU mode at all because it assumed that the FPU mode was already set
>> properly. That led to O32 userland problems.
>> 
>> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Reported-by: Mans Rullgard <mans@mansr.com>
>> Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
> This seems to fix some strange openssl issues on my Loongson system
> (O32, hard-float) with 4.0-rc1.

I have also seen openssl problems that I verified were caused by this
(it uses floating-point to measure entropy).

-- 
Måns Rullgård
mans@mansr.com
