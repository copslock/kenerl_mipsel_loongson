Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 08:45:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50553 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993420AbdFZGo41T1oE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 08:44:56 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 223797ADC2FE;
        Mon, 26 Jun 2017 07:44:48 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 26 Jun
 2017 07:44:49 +0100
Subject: Re: [PATCH] MIPS: perf: fix build failure
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
References: <1498254731-5248-1-git-send-email-sudipm.mukherjee@gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <2816265a-d5be-60eb-1428-4dd93e2aeb72@imgtec.com>
Date:   Mon, 26 Jun 2017 08:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1498254731-5248-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Sudip,

This patch fixes the build error, but leaves the I6500 handling incorrect.
I had explained to Ralf how the build should be fixed a while ago so 
hopefully he will fix it up in his -next branch (dd71e57bacb5 should 
have been applied on top of f7a31b5e7874, but in Ralf's tree 
f7a31b5e7874 is applied on v4.12-rc4 while dd71e57bacb5 is applied on 
v4.12-rc2).
You can see what those commits should look like by examining patchwork 
submissions (links available in commit descriptions).

Marcin

On 23.06.2017 23:52, Sudip Mukherjee wrote:
> The build of gpr_defconfig is failing with the error:
> arch/mips/kernel/perf_event_mipsxx.c:
> 	In function 'mipsxx_pmu_map_raw_event':
> arch/mips/kernel/perf_event_mipsxx.c:1614:2:
> 	error: duplicate case value
> 
> Patch - f7a31b5e7874 ("MIPS: perf: Remove incorrect odd/even counter
> handling for I6400") removed the previous case and added it as a
> separate case. But patch dd71e57bacb5 ("MIPS: perf: add I6500 handling")
> added it back to its old location and thus giving us two duplicate case.
> 
> Fixes: dd71e57bacb5 ("MIPS: perf: add I6500 handling")
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> The build log is available at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/246092909
> 
>   arch/mips/kernel/perf_event_mipsxx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> index 4b93cc0..733b612 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -1597,7 +1597,6 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
>   		break;
>   	case CPU_P5600:
>   	case CPU_P6600:
> -	case CPU_I6400:
>   	case CPU_I6500:
>   		/* 8-bit event numbers */
>   		raw_id = config & 0x1ff;
> 
