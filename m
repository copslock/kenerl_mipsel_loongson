Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 13:18:03 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:45652 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010866AbbAIMSBxnjgl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 13:18:01 +0100
Received: by mail-lb0-f180.google.com with SMTP id l4so7775282lbv.11
        for <linux-mips@linux-mips.org>; Fri, 09 Jan 2015 04:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=reAIogEIKzJJ30I69ZccRPJTfpjg052xAJ2el4zgnH4=;
        b=eTyfymOQfH4AMUrxUN1htQ8IOXYaenTl7Jp2v6psWTkotZICaNCmuKIBh9So3wxx9k
         zox/2r797eLvT9Yxlr4lgRZLOMP4KZlBiRkEbA6MzPAH4u2zhxT6k/r30z+KkmZUtLjt
         xq31nfKE7/avcWQJ05rcLKXUkkaQUogK+jcTeX8W8TwM6bX/6gw3zotd5l0P0/l0klet
         rGh3MdX0SDEqjGB+1p0TqmTy7ZkXwNLQUpmVB8WRU3mKuZJb+mwDQxkcliiOrSdSPI47
         de0IZB1Y9+yK8RZNbvZh2ZEAg/370FzUraLhUNLmrVOBvLgw8nmqpLK/C22xtoO0iTKi
         V9tQ==
X-Gm-Message-State: ALoCoQm3mxAxS2ugYerY7aM50HRMu4G8lFYc59FeHfz1qYRWgBm0NY65hO4KeB63Ci6EMpvGqQhE
X-Received: by 10.152.3.195 with SMTP id e3mr21253203lae.8.1420805876470;
        Fri, 09 Jan 2015 04:17:56 -0800 (PST)
Received: from [192.168.3.68] (ppp18-134.pppoe.mtu-net.ru. [81.195.18.134])
        by mx.google.com with ESMTPSA id an8sm1831115lac.7.2015.01.09.04.17.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2015 04:17:55 -0800 (PST)
Message-ID: <54AFC6F3.1020300@cogentembedded.com>
Date:   Fri, 09 Jan 2015 15:17:55 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Daniel Sanders <daniel.sanders@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
In-Reply-To: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 1/9/2015 3:06 PM, Daniel Sanders wrote:

> Without this, a 'break' instruction is executed very early in the boot and
> the boot hangs.

> The problem is that clang doesn't honour named registers on local variables
> and silently treats them as normal uninitialized variables. However, it
> does honour them on global variables.

> Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>

[...]

> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
> index 99eea59..2a2f3c4 100644
> --- a/arch/mips/include/asm/thread_info.h
> +++ b/arch/mips/include/asm/thread_info.h
> @@ -58,11 +58,11 @@ struct thread_info {
>   #define init_stack		(init_thread_union.stack)
>
>   /* How to get the thread information struct from C.  */
> +register struct thread_info *current_gp_register asm("$28");

    *static* missing?

WBR, Sergei
