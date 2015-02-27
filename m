Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 13:34:53 +0100 (CET)
Received: from mail-la0-f46.google.com ([209.85.215.46]:42484 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007566AbbB0MevptVHA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 13:34:51 +0100
Received: by labgf13 with SMTP id gf13so17161267lab.9
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 04:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=c7fAHo+kA8r6h+Wj9ZHZNkMIytiYJcxjrVX0gXRytwU=;
        b=XAnV0VKZQ5wpnoOZvS4PG4/v0tOBwaKF22e4SuvMYVMRuuulL5y7ZuGxhc6JMmVHtd
         2kscW2kBLomEHmrWmLzK/wwfNv+E8FPO9CDvl+k4uByzNGprbXiQ4HQiOnK0xJToojrb
         PDsWlXLmwkQ3iWAii3lkZ5Yoczu5sF9KWHE+yE8tY2AuhQ/691zj9vP4dvggvroDU0ED
         PAGeB6REyT9JATQFJ8z7Ur88ILcHzlmCizVX4avLKyRRoYAr4mM5RprPIK+XaH/zmTeT
         Fy3x9otU3w0LtcNPnJKbx9rga/gSQITbg3gGegyQWodLDyuhm+oCExNark0hKQK1VtY2
         10iQ==
X-Gm-Message-State: ALoCoQnk4wzwiyvcd7hlujWOZzkgdrU6JXHDSBRECDymfrSCHijGQql2kDDEULR1S/PoS2iYBF+h
X-Received: by 10.152.28.5 with SMTP id x5mr12018220lag.112.1425040486790;
        Fri, 27 Feb 2015 04:34:46 -0800 (PST)
Received: from [192.168.3.154] (ppp85-141-192-100.pppoe.mtu-net.ru. [85.141.192.100])
        by mx.google.com with ESMTPSA id si4sm805645lac.32.2015.02.27.04.34.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2015 04:34:45 -0800 (PST)
Message-ID: <54F06464.9040307@cogentembedded.com>
Date:   Fri, 27 Feb 2015 15:34:44 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Malta: malta-memory: Detect and fix bad memsize
 values
References: <1425023492-23248-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1425023492-23248-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46044
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

On 2/27/2015 10:51 AM, Markos Chandras wrote:

> memsize denotes the amount of RAM we can access from kseg{0,1} and
> that should be up to 256M. In case the bootloader reports a value
> higher than that (perhaps reporting all the available RAM) it's best
> if we fix it ourselves and just warn the user about that. This is
> usually a problem with the bootloader and/or its environment.

> Cc: <stable@vger.kernel.org> # v3.15+
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/mti-malta/malta-memory.c | 5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
> index 8fddd2cdbff7..3a0a06450ef8 100644
> --- a/arch/mips/mti-malta/malta-memory.c
> +++ b/arch/mips/mti-malta/malta-memory.c
> @@ -53,6 +53,11 @@ fw_memblock_t * __init fw_getmdesc(int eva)
>   		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
>   		physical_memsize = 0x02000000;
>   	} else {
> +		if (memsize > (256 << 20)) { /* memsize should be capped to 256M */
> +			pr_warn("Unsupported memsize value (0x%lx) detected! Using 0x10000000 (256M) instead\n",
> +				memsize);
> +			memsize = (256 << 20);

    () not needed here.

[...]

WBR, Sergei
