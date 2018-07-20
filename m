Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 17:44:29 +0200 (CEST)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:42112
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993354AbeGTPoZDMx00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 17:44:25 +0200
Received: by mail-lf1-x144.google.com with SMTP id u202-v6so2105778lff.9
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2018 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHxPO1o5siLGdoMshFfo7jCJV37JUq1NKh1f6aEWYaU=;
        b=aEv8FPHTp6tWQyyt80RlwLRib9SP/C7H/9Sy/ftcWG276PH2mKzHVfh7hLtTfYjbqU
         RQfSgm1NgCq4s9DYBERL3RSNhcD/cTPJVfgdhEDPDmrlJQIAUXkkpeqGQd5BWvh3dAZn
         HxGsB0x0T9Ttbhbz9rQO0awWaBLLIVMjreUHhZbCN5GZxb65c8xQFo08BNw5u9kQiOMg
         Oeu0buPysD8OIF7rLimfD3gawoX5/GNoL3aoVZssZbc4z9Cw3spqdOAqTo7ucf/WvH7W
         jMQVRtEAxkVC0mYapJii+/w2BzVTV6h2rKG0Hk2Zn98gHM3+0/RbHEdXt04HeBLRagar
         u0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jHxPO1o5siLGdoMshFfo7jCJV37JUq1NKh1f6aEWYaU=;
        b=eZThRJTzJwrc2LvIXe8WTuuGEH/lodF9/O6rkUWkBOVvX1Oe7BPve81lYcmpHiCXv4
         oFX/eE9JwiSdNPhiCqJWQCn7DvbP9bbJxwaNwzy9+5fiKtWHjqPGJFQ3/v+uB5kbfNvd
         Nyy0CCv3VJaWMz0ahgF7Cc+BtQULc3e+zWEvhENtGKu2K911RSzE/mVQgaQeex8tV0aA
         QZy7xmkV+ME5a+w1/rP0Ge3dT8J1zIciD7YWXtcx25ECg7BqDapAfccAFME9Gjssjv//
         /48jvPP03r2n/cc+dlOrljKDcOGja72qEmPeO45sbJHvcMSgPyIi83iQCBAzt3bTDrmV
         ck3g==
X-Gm-Message-State: AOUpUlEle1ix3bgRNWBla7zok+GsB27Oxzs7VcOH+OukcoAhXUIUgE8t
        5p6j3rOy6p3qmyH4xXhUdbuu0w==
X-Google-Smtp-Source: AAOMgpf635y2ArWSYzWUa8VMAqNFov+XKH8hsTWtcwHCCacdn+0pUhwWk7huyRd9E4Cii9pBH6ixXA==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr1698926lfg.142.1532101459247;
        Fri, 20 Jul 2018 08:44:19 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.110])
        by smtp.gmail.com with ESMTPSA id i15-v6sm338955lfb.94.2018.07.20.08.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:44:18 -0700 (PDT)
Subject: Re: [PATCH V2 04/25] MIPS: ath79: fix register address in
 ath79_ddr_wb_flush()
To:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>,
        Alban Bedel <albeu@free.fr>
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-5-john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <828c73e9-ec34-cf52-4d9c-822385f2ce32@cogentembedded.com>
Date:   Fri, 20 Jul 2018 18:44:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180720115842.8406-5-john@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64988
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

On 07/20/2018 02:58 PM, John Crispin wrote:

> From: Felix Fietkau <nbd@nbd.name>
> 
> ath79_ddr_wb_flush_base has the type void __iomem *, so register offsets
> need to be a multiple of 4.
> 
> Cc: Alban Bedel <albeu@free.fr>
> Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  arch/mips/ath79/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
> index fad32543a968..cd6055f9e7a0 100644
> --- a/arch/mips/ath79/common.c
> +++ b/arch/mips/ath79/common.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
>  
>  void ath79_ddr_wb_flush(u32 reg)
>  {
> -	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
> +	void __iomem *flush_reg = ath79_ddr_wb_flush_base + (reg * 4);

   Parens not needed, the operator priorities are natural.

[...]

MBR, Sergei
