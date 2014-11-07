Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 13:43:20 +0100 (CET)
Received: from mail-la0-f42.google.com ([209.85.215.42]:41954 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012860AbaKGMnSOjR6V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 13:43:18 +0100
Received: by mail-la0-f42.google.com with SMTP id gq15so4408801lab.1
        for <linux-mips@linux-mips.org>; Fri, 07 Nov 2014 04:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=r52llT7syWq6VWGzO504xKbTUYMebrcH8jUavV2o9u4=;
        b=jrCJ1dLoQs66pzWjj3kiVjTx2F9U5/3aN5jjM0hxGTeTTt2eNZ3T0Pw7Nnucd4W3B7
         UueEY/LPBNtrot62b8BpXv7NcA+K0GSc7P1Mhy48MYPF1tayUlT5L6fRTNMZtE9Qu9+x
         feOUGMnDLpiTztct3/TrMKTlxxCEIa10s9EgpP1UV7Z/rxfll/ObdF/h/6122aIjixpm
         Lfc9YwjhpGQQLpSO1//YP2df6APoujnN6rAz2G+yKV3SY74d6z60WVcjWsPliOctr0Gl
         3Ti7xQD9d9/xZeVL3Qc1QqPWTm33VBkLJSIs7U7re8lJCL27pGvgmmTrqYvbGXE83kGk
         Xzzg==
X-Gm-Message-State: ALoCoQkQPUHQBV4yt2LkU7qH/Ksrfk8MD/fssNXLF90XQob7mbYALotvbQYMv+Jyc6Tw4oOnD03b
X-Received: by 10.152.27.38 with SMTP id q6mr2060490lag.92.1415364192525;
        Fri, 07 Nov 2014 04:43:12 -0800 (PST)
Received: from [192.168.2.5] (ppp28-203.pppoe.mtu-net.ru. [81.195.28.203])
        by mx.google.com with ESMTPSA id ba19sm3189203lab.31.2014.11.07.04.43.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 04:43:11 -0800 (PST)
Message-ID: <545CBE5E.3050906@cogentembedded.com>
Date:   Fri, 07 Nov 2014 15:43:10 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: FW: Fix parsing u-boot environment
References: <1415359381-27257-1-git-send-email-albeu@free.fr>
In-Reply-To: <1415359381-27257-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43918
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

On 11/7/2014 2:23 PM, Alban Bedel wrote:

> When reading u-boot's key=value pairs it should skip the '=' and not
> use the next argument.

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>   arch/mips/fw/lib/cmdline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
> index ffd0345..cc5d168 100644
> --- a/arch/mips/fw/lib/cmdline.c
> +++ b/arch/mips/fw/lib/cmdline.c
> @@ -68,7 +68,7 @@ char *fw_getenv(char *envname)
>   					result = fw_envp(index + 1);
>   					break;
>   				} else if (fw_envp(index)[i] == '=') {
> -					result = (fw_envp(index + 1) + i);
> +					result = (fw_envp(index) + i + 1);

    Perhaps it's time to drop the useless outer parens?

WBR, Sergei
