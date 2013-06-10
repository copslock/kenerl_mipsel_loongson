Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:31:29 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61826 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823009Ab3FJLbVgn8UH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 13:31:21 +0200
Received: by mail-lb0-f174.google.com with SMTP id x10so4078113lbi.5
        for <linux-mips@linux-mips.org>; Mon, 10 Jun 2013 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Q0P+wUFs8kANINCh/jfIbyreAspD81HOqsP2HlavJYo=;
        b=guCeYN4IULRdYuERuz6hu2TUtIkKpnH0uTySGj+mqEE0u9bwV7CmeBaulIDaCEul6v
         8BgmJQUNXdPEHs9mtmhJhNCc5j+cw/dQywpgZrgLDvqhEZbApMe3QMf/E/1AZWTZqC1n
         0Bo34tCy+HFQkyG2lEUAE1kaZV6Arq5W3GnoIBM6aGa5PWPrxcqGGtXzmHkzlJ9VE+ci
         CMnTJBEBKCbVHrpbRBBmhWQ200q0I7gyg+gnRjTjNUMh4P1aqyqO9i3JU15P/LzqYBfG
         zBvv82oDV4uUXBNQRN7aBhhP+3hvJz7sCSdqGszCiUu5Mi62Nludfyu60S+GyyF2t7Wv
         5DBA==
X-Received: by 10.152.3.7 with SMTP id 7mr4776280lay.66.1370863875029;
        Mon, 10 Jun 2013 04:31:15 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-148-11.pppoe.mtu-net.ru. [91.76.148.11])
        by mx.google.com with ESMTPSA id p16sm5497159lbi.13.2013.06.10.04.31.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 04:31:14 -0700 (PDT)
Message-ID: <51B5B900.4010007@cogentembedded.com>
Date:   Mon, 10 Jun 2013 15:31:12 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
Subject: Re: [PATCH 2/5] MIPS: Allow kernel to use coprocessor 2
References: <1370849404-4918-1-git-send-email-jchandra@broadcom.com> <1370849404-4918-3-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1370849404-4918-3-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm8cfLoF8pIkuAGcYvlUswndCAqyn1Ivb0CQhEgwydJSikUnOEAgnH0Vznci2aLh/4MTNBS
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36798
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

On 10.06.2013 11:30, Jayachandran C wrote:

> Kernel threads should be able to use COP2 if the platform needs it.
> Do not call die_if_kernel() for a coprocessor unusable exception if
> the exception due to COP2 usage.  Instead, the default notifier for
> COP2 exceptions is updated to call die_if_kernel.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/kernel/traps.c |   15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index beba1e6..142d2be 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1056,15 +1056,9 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
>   {
>   	struct pt_regs *regs = data;
>
> -	switch (action) {
> -	default:
> -		die_if_kernel("Unhandled kernel unaligned access or invalid "
> +	die_if_kernel("COP2: Unhandled kernel unaligned access or invalid "
>   			      "instruction", regs);

    Do not wrap the message please -- it's useful for grepping. 
checkpatch.pl shouldn't complain about the line length.

WBR, Sergei
