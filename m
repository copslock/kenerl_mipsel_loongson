Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 12:25:36 +0200 (CEST)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34108 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992663AbcITKZ2hFz2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 12:25:28 +0200
Received: by mail-lf0-f49.google.com with SMTP id y6so9533847lff.1
        for <linux-mips@linux-mips.org>; Tue, 20 Sep 2016 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LeYhtj5ux4nknrLCb5ULlbPyctpg9f2Z9jq0MwWGyww=;
        b=ePb+xxc0VcEgBZ5tkVbew0XWl6gc7Xy/ACGW99+lj+zcjcr5ulS/mLEQiBPcGk02ei
         LHN8Grx+e/EmBYCuYpuGxD4J4hpJ5dlr5fufqNpZpIirqfRy9yD2zMVZAnb3cxY3JztL
         03x+BpoTK/4UNAh9Necki35Zxj8qC6ThhyYkTbLIzjvjyOz4B4XQX1UzosKvQEonCjn/
         LvXVjgGumRDufGYXDRkRl0pzZtSKK8573BgchhRyrGG5V2fR+SmkNTeLhFIyZV1jay8Q
         040rLnTWN0h/mE8x8k4PvIbdIU6AJArxBAnT0s9uHBu17pudzVsppgAawlRiVdERX/Bp
         /pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LeYhtj5ux4nknrLCb5ULlbPyctpg9f2Z9jq0MwWGyww=;
        b=Qo5kWNUY+K7bau7OQWXmlPj9V/syTV6r7IUzBUQHIUWBYGFWLfb1VCvXSet5raEFQm
         LiCAGlYSUSCYkHidBYBd7Szm7/r8hNC8zaKdyLc7DyXJwMKy8gxc+qUU3ejowyQFsho+
         Pi3QCfldhUcpQ3xRyJpn55t8TpqMsHLIyxZX7dsxilC0IGKhpqJn9gS/ihRiKpjsgO8s
         uumC3jkBqiH9AQHhSVDzeOvge0NVGzI1TC/NxCobVxjiypgeKyvnMmRIzlgt47OIa9pn
         8ac6ciJLQVcz4/2oDiYCiFtnC0wF8CKOh0vqeQqv8r2dLHlWQ7DtO6jO95j7r07iyvGG
         KVIQ==
X-Gm-Message-State: AE9vXwOiOLD/dQqt23hLprxOKRrImMSOeY4fV5c82WiOfwBDPMGe5e4lKmKyWDEa/TYuTw==
X-Received: by 10.25.152.83 with SMTP id a80mr13046187lfe.144.1474367123185;
        Tue, 20 Sep 2016 03:25:23 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.178])
        by smtp.gmail.com with ESMTPSA id 1sm5621432ljf.48.2016.09.20.03.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2016 03:25:22 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] MIPS: Deprecate VPE Loader
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
 <1474361249-31064-7-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-remoteproc@vger.kernel.org,
        lisa.parratt@imgtec.com, linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1eeeef2e-0825-94ea-77b3-07f46fcef2ca@cogentembedded.com>
Date:   Tue, 20 Sep 2016 13:25:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1474361249-31064-7-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55203
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

On 9/20/2016 11:47 AM, Matt Redfearn wrote:

> The MIPS remote processor driver (CONFIG_MIPS_RPROC) provides a more
> standard mechanism for using one or more VPs as coprocessors running
> separate firmware.
>
> Here we deprecate this mechanism before it is removed.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>
> Changes in v2: None
>
>  arch/mips/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2094cbcea0d4..071fc4585265 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2263,7 +2263,7 @@ comment "MIPS R2-to-R6 emulator is only available for UP kernels"
>  	depends on SMP && CPU_MIPSR6
>
>  config MIPS_VPE_LOADER
> -	bool "VPE loader support."
> +	bool "VPE loader support. (DEPRECATED)"

    I think the period should be after (DEPRECATED), if at all.

[...]

MBR,Sergei
