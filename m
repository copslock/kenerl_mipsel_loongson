Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 10:43:45 +0100 (CET)
Received: from mail-lf0-x231.google.com ([IPv6:2a00:1450:4010:c07::231]:35509
        "EHLO mail-lf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992162AbdARJngoprGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 10:43:36 +0100
Received: by mail-lf0-x231.google.com with SMTP id n124so6127444lfd.2
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 01:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RAQxJS8M0mTdSHmkfdupqSXWVkaYfBwSiuJDIxvJhK4=;
        b=LgNLdIyYKKuP2HnwdGrRBgeVNAIRYzEYn6QTf+gRdaMjlOS0202+CcDkesJbCw008a
         Lx3b9vHj1s6J/I4x7IoxAeX6gHPhrsNY+iOqNkSqqLXpdL5ikXFn2hMISW0YCJRJCNK5
         QpztybEDBNpYbQ9iSL4CqdRUXGISRcXQACfhaAtO97qbxuvi9/fa2Y5WbvhHwqo3BWCH
         X0b3tNAuqsoC+hD/zKoGC/YpizY1pmQtSZgMTTdqxnV5KhVrwWOBokX46UrR1UAVvs5w
         iiLFQ75Ocnoqn5Ap1gRxEJpvc+e0lF0Qqu+vEgVSIKilw912vkJciX2OlD7/KWqLQQMl
         RnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RAQxJS8M0mTdSHmkfdupqSXWVkaYfBwSiuJDIxvJhK4=;
        b=niincjPhmvoo8F80tSVCUJPTnh4OOhQVfnOy5PQcUZkn+h7yPFeXFXItaBUJHCp7EV
         YfMuDbYlZE0W2NzAa9REYVkD+mMjVWKTm++Sa134q9eAsUmtamtMRGkCq+AQIucH0/zv
         ilTk5uPMXhFsonTDmBD6ya28/hBLoozmN6O4T3WKKtqZMJoC02TbYvOLxKVf376mdCgJ
         jUVbNlky8zHzAe/YcUbSTAVpvR+acE8ZEQWoUhqH1SQpg7brDPQtbhitYrSeMmSTtE3u
         9HsoWsCGXkwnv67vd2xqa17MBI5lIU8sbfzPqcHKp2C5+SCxegDDf9uIA0hxL+CWo14U
         Sq/Q==
X-Gm-Message-State: AIkVDXIbk38FGum7cnp+hgpg/pI/OrR8a7WRIqnChV22s9er40bw2kHxON9nRv06pRJ8nA==
X-Received: by 10.46.9.20 with SMTP id 20mr1064025ljj.0.1484732611295;
        Wed, 18 Jan 2017 01:43:31 -0800 (PST)
Received: from [192.168.4.126] ([31.173.81.240])
        by smtp.gmail.com with ESMTPSA id 9sm10129710lju.28.2017.01.18.01.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2017 01:43:30 -0800 (PST)
Subject: Re: [PATCH 04/13] MIPS: zboot: fix 'make clean' failure
To:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>
References: <20170117151911.4109452-1-arnd@arndb.de>
 <20170117151911.4109452-4-arnd@arndb.de>
Cc:     linux-mips@linux-mips.org, Alban Bedel <albeu@free.fr>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <da86f6a2-e0b6-9202-baa5-c2dde188afb6@cogentembedded.com>
Date:   Wed, 18 Jan 2017 12:43:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170117151911.4109452-4-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56387
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

Hello!

On 1/17/2017 6:18 PM, Arnd Bergmann wrote:

> The filter-out macro needs two arguments, passing only one is
> clearly the result of a typo that leads to 'make clean' failing
> on MIPS:
>
> arch/mips/boot/compressed/Makefile:21: *** insufficient number of arguments (1) to function 'filter-out'.  Stop.
>
> Fixes: afca036d463c ("MIPS: zboot: Consolidate compiler flag filtering.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[...]
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index 5347cfe15af2..c66db8169af9 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -80,6 +80,9 @@ extern u64 __ua_limit;
>
>  #define segment_eq(a, b)	((a).seg == (b).seg)
>
> +extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
> +extern size_t __copy_user(void *__to, const void *__from, size_t __n);
> +
>  /*
>   * eva_kernel_access() - determine whether kernel memory access on an EVA system
>   *

    Unrelated change?

MBR, Sergei
