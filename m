Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 14:36:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59135 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1BQNgX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 14:36:23 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p1HDa30g021423;
        Thu, 17 Feb 2011 14:36:03 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1HDa0aM021419;
        Thu, 17 Feb 2011 14:36:00 +0100
Date:   Thu, 17 Feb 2011 14:36:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 4/4] MIPS: perf: Add support for 64-bit perf counters.
Message-ID: <20110217133559.GA12732@linux-mips.org>
References: <1295650776-28444-1-git-send-email-ddaney@caviumnetworks.com>
 <1295650776-28444-5-git-send-email-ddaney@caviumnetworks.com>
 <AANLkTimFnBJeU7BT6ARM=+KSod0UB-XFZTxgWWh1N=i2@mail.gmail.com>
 <4D3F68BE.5080803@caviumnetworks.com>
 <AANLkTim54xV64utR0GdS1r4_LBoAjEOHH9_=TYSLSqMF@mail.gmail.com>
 <4D41BC6B.8010408@caviumnetworks.com>
 <AANLkTi=R86zBH8ZY+CdGyeXsSd0-yHdRVVx0ZWTJf4qe@mail.gmail.com>
 <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikTV-=A8H=h_F+025VB37tHSmxpsNCGndi_dAFW@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 17, 2011 at 06:46:39PM +0800, Deng-Cheng Zhu wrote:

> The reason of the perf-record failure on 32bit platforms is that the 32bit
> counter read function mipsxx_pmu_read_counter() returns wrong 64bit values.
> For example, the counter value 0x12345678 will be returned as
> 0xffffffff12345678. So in mipspmu_event_update(), the delta will be wrong.
> So here's a possible fix for your reference:
> 
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -184,19 +184,21 @@ static unsigned int
> mipsxx_pmu_swizzle_perf_idx(unsigned int idx)
>         return idx;
>  }
> 
> +#define U32_MASK 0xffffffff
> +
>  static u64 mipsxx_pmu_read_counter(unsigned int idx)
>  {
>         idx = mipsxx_pmu_swizzle_perf_idx(idx);
> 
>         switch (idx) {
>         case 0:
> -               return read_c0_perfcntr0();
> +               return read_c0_perfcntr0() & U32_MASK;
>         case 1:
> -               return read_c0_perfcntr1();
> +               return read_c0_perfcntr1() & U32_MASK;
>         case 2:
> -               return read_c0_perfcntr2();
> +               return read_c0_perfcntr2() & U32_MASK;
>         case 3:
> -               return read_c0_perfcntr3();
> +               return read_c0_perfcntr3() & U32_MASK;

read_c0_perfctrl0 etc. are defined in mipsregs.h as 32-bit reads returning
a signed int.  That was ok on 32-bit kernels.  To support the optional
64-bit counters the code will have to be changed to something like:

static u64 mipsxx_pmu_read_counter(unsigned int idx)
{
	idx = mipsxx_pmu_swizzle_perf_idx(idx);

	switch (idx) {
	case 0:
		if (read_c0_perfctrl0() & M_PERFCTL_WIDE)
			return read_c0_64_bit_perfcntr0();
		else
			return read_c0_32_bit_perfcntr0();
	case 1:
		if (read_c0_perfctrl1() & M_PERFCTL_WIDE)
			return read_c0_64_bit_perfcntr1();
		else
			return read_c0_32_bit_perfcntr1();
...

And read_c0_32_bit_perfcntrX need to zero-extend their return value.

  Ralf
