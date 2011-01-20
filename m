Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 12:04:36 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:59382 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491182Ab1ATLE2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jan 2011 12:04:28 +0100
Received: by ewy20 with SMTP id 20so137119ewy.36
        for <multiple recipients>; Thu, 20 Jan 2011 03:04:28 -0800 (PST)
Received: by 10.213.34.5 with SMTP id j5mr2722695ebd.27.1295521467969;
        Thu, 20 Jan 2011 03:04:27 -0800 (PST)
Received: from [192.168.2.2] ([91.79.106.16])
        by mx.google.com with ESMTPS id t50sm6443808eeh.6.2011.01.20.03.04.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 03:04:26 -0800 (PST)
Message-ID: <4D381677.3000502@mvista.com>
Date:   Thu, 20 Jan 2011 14:03:19 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] tracing, MIPS: Fix set_graph_function of function
 graph tracer
References: <cover.1295464855.git.wuzhangjin@gmail.com> <9967898043e58db7b311d35695e9422e67cef5f6.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <9967898043e58db7b311d35695e9422e67cef5f6.1295464855.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 19-01-2011 22:28, Wu Zhangjin wrote:

> trace.func should be set to the recorded ip of the mcount calling site
> in the __mcount_loc section to filter the function entries configured
> through the tracing/set_graph_function interface, but before, this is
> set to the self_ra(the return address of mcount), which has made
> set_graph_function not work as expects.

    Expected?

> This fixes it via calculating the right recorded ip in the __mcount_loc
> section and assign it to trace.func.

> Reported-by: Zhiping Zhong<xzhong86@163.com>
> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   arch/mips/kernel/ftrace.c |   11 +++++++++--
>   1 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index bc91e4a..62775d7 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
[...]
> @@ -304,7 +304,14 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
>   		return;
>   	}
>
> -	trace.func = self_ra;
> +	/*
> +	 * Get the recorded ip of the current mcount calling site in the
> +	 * __mcount_loc section, which will be used to filter the function
> +	 * entries configured through the tracing/set_graph_function interface.
> +	 */
> +
> +	insns = (in_kernel_space(self_ra)) ? 2 : (MCOUNT_OFFSET_INSNS + 1);

    Unneeded parens.

> +	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);

    Here too.

WBR, Sergei
