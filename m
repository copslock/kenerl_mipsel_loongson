Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2014 15:50:10 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40058 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822100AbaDSNuBHmWPL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Apr 2014 15:50:01 +0200
Received: by mail-lb0-f182.google.com with SMTP id n15so2128441lbi.27
        for <linux-mips@linux-mips.org>; Sat, 19 Apr 2014 06:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=a1qEWOiiQEHgyZ/tpqXVHTHzeBBTzVUAAkJgqHOZ66w=;
        b=GPTIOM9FmhfbUEsnAYGhl4XuzssT2BQc6n/lGTmkMrFyqelDObEcl9chry1G0jkkOX
         tO9WriSeS+MdYKJB+qp56GQcwCRP1NFj6K20NDUZI9Ex5yXVSXwgTcjCTJHC+uxSTmCt
         HqD5O3NujTLgg/bk5axJqlnbldGPHpeACCDsVWgBK3xpuEZocS3x65GQTEOR0wWXYeeQ
         7QgQCeLSmybQqFCNHztrv8UU6HHnVQGiN/tN45jeDfyXta8NV/U71+GzlKvoyZCQXVA9
         Pt8XtbgFMcjWU2c7aakSPGZmGNCiatajlHEfT7ZRfaCFo/1t+Qrr3BgQAGsDgUYbEwZY
         1WqQ==
X-Gm-Message-State: ALoCoQl0vSqiSbF35w4B5dttmB9FDDWaUYFsA7EAhX+W/kQsUVCl819J1icJGr42/1H98dT1yWL7
X-Received: by 10.112.89.10 with SMTP id bk10mr77598lbb.64.1397915395283;
        Sat, 19 Apr 2014 06:49:55 -0700 (PDT)
Received: from [192.168.2.4] (ppp85-140-143-140.pppoe.mtu-net.ru. [85.140.143.140])
        by mx.google.com with ESMTPSA id dl4sm30851878lbc.4.2014.04.19.06.49.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 06:49:54 -0700 (PDT)
Message-ID: <53527F01.30003@cogentembedded.com>
Date:   Sat, 19 Apr 2014 17:49:53 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Prem Karat <pkarat@mvista.com>, linux-mips@linux-mips.org
CC:     ddaney.cavm@gmail.com
Subject: Re: [RFC PATCH 1/1] MIPS: Enable VDSO randomization.
References: <20140419093302.GH2717@064904.mvista.com>
In-Reply-To: <20140419093302.GH2717@064904.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39865
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

On 19-04-2014 13:33, Prem Karat wrote:

> Based on commit 1091458d09e1a (mmap randomization)

> For 32-bit address spaces randomize within a
> 16MB space, for 64-bit within a 256MB space.

> Signed-off-by: Prem Karat <pkarat@mvista.com>
[...]

> @@ -67,7 +69,18 @@ subsys_initcall(init_vdso);
>
>   static unsigned long vdso_addr(unsigned long start)
>   {
> -	return STACK_TOP;
> +	unsigned long offset = 0UL;
> +
> +	if (current->flags & PF_RANDOMIZE) {
> +		offset = get_random_int();
> +		offset = offset << PAGE_SHIFT;

    Why not:

		offset <<= PAGE_SHIFT;

> +		if (TASK_IS_32BIT_ADDR)
> +			offset &= 0xfffffful;
> +		else
> +			offset &= 0xffffffful;
> +	}
> +
> +	return (STACK_TOP + offset);

    Parens not needed.

WBR, Sergei
