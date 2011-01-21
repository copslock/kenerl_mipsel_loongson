Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 18:37:45 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:44423 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491815Ab1AURhl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 18:37:41 +0100
Received: by ewy20 with SMTP id 20so965306ewy.36
        for <multiple recipients>; Fri, 21 Jan 2011 09:37:40 -0800 (PST)
Received: by 10.213.22.142 with SMTP id n14mr1295612ebb.57.1295631422946;
        Fri, 21 Jan 2011 09:37:02 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id b52sm7658697eei.1.2011.01.21.09.37.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 09:37:01 -0800 (PST)
Message-ID: <4D39C3ED.4020401@mvista.com>
Date:   Fri, 21 Jan 2011 20:35:41 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [v2 PATCH 5/5] tracing, MIPS: Fix set_graph_function of function
 graph tracer
References: <1295630970-32044-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1295630970-32044-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

> trace.func should be set to the recorded ip of the mcount calling site
> in the __mcount_loc section to filter the function entries configured
> through the tracing/set_graph_function interface, but before, this is
> set to the self_ra(the return address of mcount), which has made
> set_graph_function not work as expected.

> This fixes it via calculating the right recorded ip in the __mcount_loc
> section and assign it to trace.func.

> Reported-by: Zhiping Zhong <xzhong86@163.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/kernel/ftrace.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index bc91e4a..be3fa7a 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
[...]
> @@ -304,7 +304,14 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
>  		return;
>  	}
>  
> -	trace.func = self_ra;
> +	/*
> +	 * Get the recorded ip of the current mcount calling site in the
> +	 * __mcount_loc section, which will be used to filter the function
> +	 * entries configured through the tracing/set_graph_function interface.
> +	 */
> +
> +	insns = (in_kernel_space(self_ra)) ? 2 : MCOUNT_OFFSET_INSNS + 1;

    You're still keeping the parens around the function call. Why? :-)

WBR, Sergei
