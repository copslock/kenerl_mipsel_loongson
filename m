Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2016 11:12:44 +0100 (CET)
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34603 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbcKCKMfg9VgO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Nov 2016 11:12:35 +0100
Received: by mail-lf0-f51.google.com with SMTP id b81so33608332lfe.1
        for <linux-mips@linux-mips.org>; Thu, 03 Nov 2016 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cANtHYDEUTfoWuFPHkNKB5MCpJOD7F26AZ8Dj9KN5+w=;
        b=P2R9EXQkua+RgzBtC1EDKymtK4RmHX/eEN1Z5OKozFCTt1Yd7Zuak+GioEdluXEogE
         iTzlOkETO7jBDU3dyvxvzML4ZhQZVguM1T1EPpwB89T0TZkUKpMPASp1DNZwG7huaGcR
         R+dguU4X/Isfjexd8IH37hIdflY+U1foizzwI6PDArJgy+QD6TaAQupjINZ1TjX02JXb
         AhKMfe3cA11TB2HRcDpBH8FCMwmCygga10FooMQo7etkcv2nD3QTIXDGWh/NWHfjkVcT
         YSjd6uln1mBaaOOMWioVMlB7LzydS0kkOM0cB87YknuW9Fxt4UuCvK6QXJL+2tkez1QM
         9AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cANtHYDEUTfoWuFPHkNKB5MCpJOD7F26AZ8Dj9KN5+w=;
        b=QOiqNOpHQbl9HXdr6eFt81Qafn3NP6l6GN7nex3fpBKB/oKn/kfQEhG77NCei8R3p7
         05hXLPYNDsVXAM8Ip8enfh6s0Za2o+bvVKEeI7RHHBDcM0DU32E/ZJ1bUhHCBnnVxPch
         m6lP186PtDbnUz5Is06MAP0JXtzUb0Vssgg0yY02uLJsHADTH0CEf49/j2zefzQoXNt6
         mzhSGLJyeVkUaysAqDZP0dPBd+t+2I7hQ+BitFz4H7X2RSsmLHyM9M1DNvhvvzuJ3gPD
         G+aHa1dJNtnP8+T603HmKqqQAaXkXEGWVV056ylz+AjZRkTU1l3n6cs3DlDm2VY3tse0
         9w6Q==
X-Gm-Message-State: ABUngvehHfdNiPKeYePFC4YQd5v4gQx1ObF3NFF1x5W5Dt2BMPGjjifW2NxSACiMA6j2gQ==
X-Received: by 10.25.19.106 with SMTP id j103mr4927585lfi.68.1478167949991;
        Thu, 03 Nov 2016 03:12:29 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.185])
        by smtp.gmail.com with ESMTPSA id g21sm1262792lfe.47.2016.11.03.03.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2016 03:12:29 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] MIPS: Deprecate VPE Loader
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1478103063-17653-1-git-send-email-matt.redfearn@imgtec.com>
 <1478103063-17653-5-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-remoteproc@vger.kernel.org,
        lisa.parratt@imgtec.com, linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <540026e5-a839-b4db-ec8c-bd5d03d9faca@cogentembedded.com>
Date:   Thu, 3 Nov 2016 13:12:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1478103063-17653-5-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55658
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

On 11/2/2016 7:11 PM, Matt Redfearn wrote:

> The MIPS remote processor driver (CONFIG_MIPS_REMOTEPROC) provides a
> more standard mechanism for using one or more VPs as coprocessors
> running separate firmware.
>
> Here we deprecate this mechanism before it is removed.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  arch/mips/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 6faf7c96ee15..d5b5a25a49e8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
[...]
> @@ -2307,6 +2307,9 @@ config MIPS_VPE_LOADER
>  	  Includes a loader for loading an elf relocatable object
>  	  onto another VPE and running it.
>
> +	  Unless you have a specific need, you should use CONFIG_MIPS_REMOTEPROC
> +          instead of this.

    Please indent using a leading tab (like above). There's too many spaces too...

[...]

MBR, Sergei
