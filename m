Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 06:05:58 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:43016
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990485AbdJCEFut0jSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 06:05:50 +0200
Received: by mail-oi0-x243.google.com with SMTP id c77so10319271oig.0;
        Mon, 02 Oct 2017 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LK4IqudTwAJ3YeHYxUTWnvDGqAMFZfY498i8FhVMAo0=;
        b=gHENIIGRG/PBKVufZ1qcM/e/4HYx2/rNu1sAedJMeC4DWGnsQNhx+q2tnq9yZz0QKA
         eI1AfiB9dqbzSOSHDL4ufocp9bakleczA44fPsLM/7UcqMU2/ipj4K4zKJrHXcIv5GUX
         wbKdTxDNRbSYX5p2GKdJB/ZyzvqjwJkpScBlqSDZRdG5C3jcoWBkIsbK6lATL6MxC4Xf
         cKD4kHtzzJx4DK3plMexTG3uUK2oAGBaKkc4hfX1Lr9WYs3GokL0vG2k/ck7Pa5itEUJ
         jnlY06HBsM1UO9WR8NErNud8exiA7DKitHyY56OxaKZAIcu5EYts94mDps8lMjfm1VUt
         SwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LK4IqudTwAJ3YeHYxUTWnvDGqAMFZfY498i8FhVMAo0=;
        b=GpOyfYnocvwdBKBIACfWWmk80caf/6fBfIMOB0s22W16ZpAJLemc0CQy6uQ9BLfPsq
         xiZbLIVCdJ2YuJ9MXpgYpnedFKkJjNq0P/7NoXCgtqAsz1I+W4G+nq2y4/3rvR1bwqKg
         i2jcGG0C7kdBbmoKWYunuuASCkl45+ppRpOLp3ddorawFu8rUwhozAu8c8kL6IXhoX2b
         zt0UdoEv4v7E7q5+dQr7taBARcemNC+jxS4fki4AqVzPSovICB6krnMOiAsOsATPlt+d
         s5mPecFSP1Dtb2c+VDEtV4LCoXWsluJM456g9TfPLNTNqHYgQkb4YpYfVpvs49PhDFe2
         2f2A==
X-Gm-Message-State: AMCzsaXchKLpEbY+SyDk7TWurWcLVX9t5mnMf0jkw9TilJ/0ZdKgWYqb
        OfPGiFJw9W7X90LvE2tamQ5REcDq
X-Google-Smtp-Source: AOwi7QAYHzQaXsemZktJMck90yTPZhzTVnvALJrJuP9LIBxpT/x8kcZCJdl/zu5tiWJr4ytmn0AytA==
X-Received: by 10.202.83.140 with SMTP id h134mr8307941oib.305.1507003544075;
        Mon, 02 Oct 2017 21:05:44 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:652b:c970:4c77:9022? ([2001:470:d:73f:652b:c970:4c77:9022])
        by smtp.gmail.com with ESMTPSA id k124sm6228610oib.0.2017.10.02.21.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 21:05:42 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix sparse CPU id space build error.
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
References: <1506965989-5043-1-git-send-email-steven.hill@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5b5111e8-c6c5-0814-d109-b325969c27b5@gmail.com>
Date:   Mon, 2 Oct 2017 21:05:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1506965989-5043-1-git-send-email-steven.hill@cavium.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 10/02/2017 10:39 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> Patch "MIPS: Allow __cpu_number_map to be larger than NR_CPUS" was
> incomplete, thus breaking all MIPS builds.

Did not you submit a corrected version as part of [PATCH v2 00/12] Add
Octeon Hotplug CPU Support.? Was v1 already merged?

> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> ---
>  arch/mips/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 87ed0ff..da74db1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2726,6 +2726,14 @@ config NR_CPUS
>  config MIPS_PERF_SHARED_TC_COUNTERS
>  	bool
>  
> +config MIPS_NR_CPU_NR_MAP_1024
> +	bool
> +
> +config MIPS_NR_CPU_NR_MAP
> +	int
> +	default 1024 if MIPS_NR_CPU_NR_MAP_1024
> +	default NR_CPUS if !MIPS_NR_CPU_NR_MAP_1024
> +
>  #
>  # Timer Interrupt Frequency Configuration
>  #
> 

-- 
Florian
