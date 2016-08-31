Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 12:21:33 +0200 (CEST)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35658 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbcHaKVZxq2rz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 12:21:25 +0200
Received: by mail-lf0-f47.google.com with SMTP id f93so33278528lfi.2
        for <linux-mips@linux-mips.org>; Wed, 31 Aug 2016 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bGMT3Xp3VYC+2zlcLFQAqkaS8mxp6K6CB342HdGxJGg=;
        b=tzRHoJZ2tGI99mSM5GzVVuJ+C5wZPQflKBb0FPMnXidnX/mi9Vp9te6CNO74g7Z/Y6
         YCAuSMtsmnc49VlE0dSdnj6IFZauo22PCXYpUStg8ApThcx4lWdtEaNnJxvVVfwFdLcT
         mh1H8irPsxAeAEElROLReUnroI1SOSnZKGmoWOziUYWQZJ9miDtu6P9AvoOnCJuAvtrq
         1ZG/a/vvH/D78QkTS6qNTvdtTz0YwSYLNEwuei/sne9MT8vYkGgZeG2sH0rFtouihU/I
         ppnc99UXLxT56/JhwX0bCYEZAlmjKtd5AFcvw8suunofVwE1aOjzNmCYscaSvu/7m4a3
         eDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bGMT3Xp3VYC+2zlcLFQAqkaS8mxp6K6CB342HdGxJGg=;
        b=eO9FCR7K0LcQuX7d3ZdNeES4zUag1PYBMyvnK+qKJhr7KK8r7QtG9B3YEHFW4OebD5
         cPFdGx1tkMj9fbyxp1tW44tdKUsb6y3v2tRnGeyyrn6HCKPyzvZsW4wlmSw//CeRFRnG
         WljqE/pv/adgPY5qONfy4bf8ukYXfXC72pDjOzHe2PtNX2M226Oq1y1UEMO2y6Y1/6Q/
         iEOaV3wQNi6omCeGfxD/gqD8tPAMPoHWnM/YoFvtobXIJoVaqtk2mjP2vuFy9Sw5fhQr
         bNcLGbxgCRp3WqGXMzDFQZhtZtVKnfNZnHqkI+kn8I0VxaWlnTl7fyqBlxTYjtqs1HiJ
         Mg4Q==
X-Gm-Message-State: AE9vXwPTCjX6bnKe26GNxO3Q29sNc5m5X4UpGkkMs/HQ5oYsm8gQcFAX7ItCZ+XKP+tMOw==
X-Received: by 10.25.215.35 with SMTP id o35mr3138467lfg.40.1472638877527;
        Wed, 31 Aug 2016 03:21:17 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.80.179])
        by smtp.gmail.com with ESMTPSA id f22sm8252328lji.13.2016.08.31.03.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 03:21:14 -0700 (PDT)
Subject: Re: [PATCH v2 12/26] MIPS: CPC: Provide a default
 mips_cpc_default_phys_base
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
 <20160830172929.16948-13-paul.burton@imgtec.com>
Cc:     linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6f7cbf5c-7a74-069b-6205-be0c3cf369fd@cogentembedded.com>
Date:   Wed, 31 Aug 2016 13:21:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160830172929.16948-13-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54881
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

On 8/30/2016 8:29 PM, Paul Burton wrote:

> Provide a weak default implementation of mips_cpc_default_phys_base
> which reads the base address of the CPC from the device tree if
> possible, and failing that returns the existing physical address of the
> CPC as read from CPC base address GCR. This allows for platforms to make
> use of the CPC without requiring platform code.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
> Changes in v2: None
>
>  arch/mips/kernel/mips-cpc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index 566b8d2..b188787 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
[...]
> @@ -21,6 +23,22 @@ static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
>
>  static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
>
> +__weak phys_addr_t mips_cpc_default_phys_base(void)

    I think it would look better as:

phys_addr_t __weak mips_cpc_default_phys_base(void)

    The other weak function you touch further in the patchset looks this way...

[...]

MBR, Sergei
