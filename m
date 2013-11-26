Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2013 01:10:06 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46332 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3KZAKBROQe2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Nov 2013 01:10:01 +0100
Received: by mail-ie0-f169.google.com with SMTP id e14so8278300iej.0
        for <multiple recipients>; Mon, 25 Nov 2013 16:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iAdjkq6eDLoEFQ4AxIN06oKrojelWv+lfUka/v2qaXQ=;
        b=dgU0LB9aHAiqT7Ip4JOJs9+90rv0r9RWnlrPIIIQAoqUDIeFPuaqYDHoMJhuD0RlqB
         KntRW6yyyJAlB70DrSknEftkDra0SKHThGV3ZMEN9z+I1Wd0OSOqulUiUbmnFfZk+nZV
         YC/JQ1NrRpYVlI4bE5ImUN+AXbqY7KHo9qOuc64FWTCkFCjCbQ6/MP/OhMBvlASnhah1
         nimtxcPkW2myRs2D774W0lCBMHScWnRrOhAXLjzI+rdiya0ebqIpsBMzEJbdFr7AZqsv
         DHfcYAn9td1TLpH0nBgtJMHE2CFC9qDEruk+U317W2mf7Bo4rg9PbeGCclIS8wt4R9F+
         J4eQ==
X-Received: by 10.42.224.10 with SMTP id im10mr3140523icb.46.1385424594791;
        Mon, 25 Nov 2013 16:09:54 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id x5sm29226459iga.6.2013.11.25.16.09.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 16:09:53 -0800 (PST)
Message-ID: <5293E6D0.3050604@gmail.com>
Date:   Mon, 25 Nov 2013 16:09:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Fix build error seen in some configurations
References: <1385421660-5608-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385421660-5608-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/25/2013 03:21 PM, Guenter Roeck wrote:
> The following build error is seen if CONFIG_32BIT is undefined,
> CONFIG_64BIT is defined, and CONFIG_MIPS32_O32 is undefined.
>
> asm/syscall.h: In function 'mips_get_syscall_arg':
> arch/mips/include/asm/syscall.h:32:16: error: unused variable 'usp' [-Werror=unused-variable]
> cc1: all warnings being treated as errors
>
> Fixes: c0ff3c53d4f9 ('MIPS: Enable HAVE_ARCH_TRACEHOOK')
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/include/asm/syscall.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index 81c8913..33e8dbf 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -29,7 +29,7 @@ static inline long syscall_get_nr(struct task_struct *task,
>   static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
>   	struct task_struct *task, struct pt_regs *regs, unsigned int n)
>   {
> -	unsigned long usp = regs->regs[29];
> +	unsigned long usp __maybe_unused = regs->regs[29];
>
>   	switch (n) {
>   	case 0: case 1: case 2: case 3:
>
