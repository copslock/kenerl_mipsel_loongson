Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 20:15:15 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35941 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030121AbcEXSPMeigKP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 20:15:12 +0200
Received: by mail-pa0-f66.google.com with SMTP id fg1so2778816pad.3;
        Tue, 24 May 2016 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=D7dTpZddGGNBx3HoGwXDxL9yzo/Mk5Scd4sdnq43+Tc=;
        b=K2K5HMBofntbp9/133Kl32n+3al0LRn2Yx+vseUeT6fjL8/cNPIPPbxQ4B8tMmo76o
         /AeS8z5ItalXulRxMA99jdIWSLDgpmZKn7xLmWmWQWbQ8+DmoNnwCO5sQ7/7M5glr4rz
         uQNOCyABDkF8hzp9f/gcPAPk3zqCj5s5j81zgWInGfthuUzYWRJS9NN8RtcbbhlsLo9V
         IOMhYwtkf62IOk41dR6Sin5SK/4/zwoJLJQgYxTLOx0wYQgT5yyOKXP98iuksyv/h02H
         IJ54ZC4CHAWVxN1OOCRZXgsV5TmRFFTg975QUPJZX7WXwpHEUsQWPXEhEegBm7ogRrF+
         WaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=D7dTpZddGGNBx3HoGwXDxL9yzo/Mk5Scd4sdnq43+Tc=;
        b=HoYaKuNyMeX9tJkeOTm3rrMGjo3UlsotP5gr/IO1+OU13PGF/b1qKwOqSuhP7Cec15
         39ZvdSB1XOrUvZ0UIhff1kaxoRX5ct4EV6NjyTLOO59ctce853lcUcuNsATtbZrCGZOG
         GzSbC90XyTJoiQfUzX7YVKYffSh+c34jgl5AmPKYE8KNSxjXhuT8QHrjygZ+ewc2OOPm
         10Q2vMkNXX8j/KUSkrMMLyZnkxnxvT276UqwKdV0yqbkfvipcYlLAqJwkbUNfkqqEYHW
         TSKv7QzS0JxrH9UqgdorsM04JGKX6zqtAjyKqvhw6lILbSbicQUkQqdtr6ICgnPwza4e
         7qSw==
X-Gm-Message-State: ALyK8tKV8HJmZ9gaUBRBQU/fH7tbw1KXVMJ3qoHHPKFyuHga6u/pOY1UHUSNlT+bPXQ/Gw==
X-Received: by 10.66.43.143 with SMTP id w15mr9088728pal.76.1464113706763;
        Tue, 24 May 2016 11:15:06 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id e184sm55972510pfe.14.2016.05.24.11.15.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 11:15:05 -0700 (PDT)
Message-ID: <57449A28.3020901@gmail.com>
Date:   Tue, 24 May 2016 11:15:04 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
CC:     linux-kernel@vger.kernel.org, rt@linutronix.de,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add missing FROZEN hotplug notifier transitions
References: <1464095327-55194-1-git-send-email-anna-maria@linutronix.de>
In-Reply-To: <1464095327-55194-1-git-send-email-anna-maria@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53647
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

On 05/24/2016 06:08 AM, Anna-Maria Gleixner wrote:
> The corresponding FROZEN hotplug notifier transitions used on
> suspend/resume are ignored. Therefore the switch case action argument
> is masked with the frozen hotplug notifier transition mask.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

This seems sane, and I don't object, but can you tell us how this was 
tested?

Thanks,
David Daney


> ---
>   arch/mips/cavium-octeon/smp.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -384,7 +384,7 @@ static int octeon_cpu_callback(struct no
>   {
>   	unsigned int cpu = (unsigned long)hcpu;
>
> -	switch (action) {
> +	switch (action & ~CPU_TASKS_FROZEN) {
>   	case CPU_UP_PREPARE:
>   		octeon_update_boot_vector(cpu);
>   		break;
>
>
