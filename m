Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Feb 2014 16:52:41 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1706 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822682AbaBSPwg3HjnC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Feb 2014 16:52:36 +0100
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     Viller Hsiao <villerhsiao@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: ftrace: Fix icache flush range error
Thread-Topic: [PATCH] MIPS: ftrace: Fix icache flush range error
Thread-Index: AQHPLYKmtXKbQf1ZoEy1oTk70KTxUZq8t8AQ
Date:   Wed, 19 Feb 2014 15:51:25 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D140AE3A@LEMAIL01.le.imgtec.org>
References: <1392821678-18556-1-git-send-email-villerhsiao@gmail.com>
In-Reply-To: <1392821678-18556-1-git-send-email-villerhsiao@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.95]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2014_02_19_15_51_27
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Qais.Yousef@imgtec.com
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

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Viller Hsiao
> Sent: 19 February 2014 14:55
> To: linux-mips@linux-mips.org
> Cc: Viller Hsiao; Steven Rostedt; Frederic Weisbecker; Ingo Molnar; Ralf Baechle
> Subject: [PATCH] MIPS: ftrace: Fix icache flush range error
> 
> 
> In 32-bit machine, the start address of flushing icache is wrong after calculated
> address of 2nd modified instruction in function tracer. The start address is shifted
> 4 bytes from ordinary calculation.
> 
> This causes problem when the address of 1st instruction is the last word of one
> cache line. It will not be flushed at this case.
> 
> Signed-off-by: Viller Hsiao <villerhsiao@gmail.com>
> ---
>  arch/mips/kernel/ftrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c index
> 185ba25..5bdc535 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -107,12 +107,12 @@ static int ftrace_modify_code_2(unsigned long ip,
> unsigned int new_code1,
>  				unsigned int new_code2)
>  {
>  	int faulted;
> +	unsigned long ip2 = ip + 4;

I think better to omit this variable...

> 
>  	safe_store_code(new_code1, ip, faulted);
>  	if (unlikely(faulted))
>  		return -EFAULT;
> -	ip += 4;
> -	safe_store_code(new_code2, ip, faulted);
> +	safe_store_code(new_code2, ip2, faulted);

And just do the addition directly here instead.

>  	if (unlikely(faulted))
>  		return -EFAULT;
>  	flush_icache_range(ip, ip + 8); /* original ip + 12 */

Care to fix this comment by removing it? I can't rationalise it and made me confused for a bit.
If you do remove it please mention the change in the commit message.

Nice catch by the way.

Cheers,
Qais

> --
> 1.8.4.3
> 
