Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 12:59:05 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:40716 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009651AbbAQL7DULO44 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 12:59:03 +0100
Received: by mail-lb0-f173.google.com with SMTP id b6so9330789lbj.4
        for <linux-mips@linux-mips.org>; Sat, 17 Jan 2015 03:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=pusUBxBJuW+SBkgqesunDrBYw8THXJ5QK4CLSJeAWJA=;
        b=Fdo4+lPpdPqZBFM+zWNatQBCKNKc9sxpzeq92LHZn9MHv9nNEk+e8V4zIR4OqGek5P
         KidFNfqMsIADkt66UhwjbgUu1xSn1phy6muYUUz234cvl9xZyis1kF5ynzclvj+nLJmQ
         r54QK3tI+DllYe3g65gK7len//ROI5Y7MXCWOzX6BbmxRDkz3nj3sjRjq+HqEtoBqy//
         ye6ZCVEhcuZbsvHZWcRVH426BNEk1df0/+5Obqin6ydmvytgNUpKkDoasq9tO7zmZxTW
         eiOsf8hzgNBAzMe5RQBiCS/vW60KpyKH9kSKXOo7xuTTgLsIksTYmqQt+ikBt4ixtbYd
         Jgew==
X-Gm-Message-State: ALoCoQmiRgjoXDMD/wdMXIqON7jgzRZ8vk6JWP1hwXm3LD4kPZVzBi5uDSDRNf0kC/Iq7NQjXtqO
X-Received: by 10.112.147.10 with SMTP id tg10mr20552686lbb.92.1421495937708;
        Sat, 17 Jan 2015 03:58:57 -0800 (PST)
Received: from [192.168.3.68] (ppp30-219.pppoe.mtu-net.ru. [81.195.30.219])
        by mx.google.com with ESMTPSA id z6sm1512507lby.7.2015.01.17.03.58.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2015 03:58:56 -0800 (PST)
Message-ID: <54BA4E7F.5020208@cogentembedded.com>
Date:   Sat, 17 Jan 2015 14:58:55 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 40/70] MIPS: mm: page: Add MIPS R6 support
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-41-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-41-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45241
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

On 1/16/2015 1:49 PM, Markos Chandras wrote:

> The MIPS R6 pref instruction only have 9 bits for the immediate
> field so skip the micro-assembler PREF instruction is the offset
> does not fit in 9 bits.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/mm/page.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)

> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index b611102e23b5..b84e0b2ce140 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -72,6 +72,20 @@ static struct uasm_reloc relocs[5];
>   #define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
>   #define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
>
> +/*
> + * R6 has a limited offset of the pref instruction.
> + * Skip it if the offset is more than 9 bits.
> + */
> +#define _uasm_i_pref(a, b, c, d)		\
> +do {						\
> +	if (cpu_has_mips_r6) {			\
> +	    if ((d > 0xff) || (d < -0x100))	\

    Please indent with tabs only. Inner () not necessary. And it looks like 
you've reversed the conditions.

> +		uasm_i_pref(a, b, c, d);	\
> +	} else {				\
> +		uasm_i_pref(a, b, c, d);	\
> +	}					\
> +} while(0)
> +
[...]

WBR, Sergei
