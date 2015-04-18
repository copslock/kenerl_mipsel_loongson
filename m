Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 05:09:44 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36630 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbDRDJmVsz6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2015 05:09:42 +0200
Received: by obbeb7 with SMTP id eb7so84121239obb.3;
        Fri, 17 Apr 2015 20:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YFFQinj7Ddgv1MoO/Hqlm17AUbQLJLHSJoqCgQLW5I4=;
        b=Pylh6/rXnhU/lB4xaf3WkY/7qX6bManmYGo45IrBni5LRZSknyoXR5dYbEv/Di/+Xb
         Ct/nI9WyGm32QafaqtrH0xyR3ttsiwO9+j60PhSBueN8zvTlK3Oui3FlR17kh8bszU2v
         vxtYvwVZAwioY2X+2vmU1GK4JcoQmj40zobtqB5OIohbUr6lOCy83+huSFAtbzmr8XUQ
         xARpd9+VFhT1N2HPPSyJbwHKr9XuBVJh45vyUqwnywSfJ1Vh1hfMxDV+uAd4641dXQ1Z
         PvpFAEWeERz1xn/u/4Hu8Fj4Te+911JdB2QbKPiIiqVei9QyqXrSdxiPqY3+hIB/vbxk
         JB8Q==
X-Received: by 10.202.197.148 with SMTP id v142mr5186194oif.13.1429326577846;
        Fri, 17 Apr 2015 20:09:37 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:591e:8f59:3f26:7007? ([2001:470:d:73f:591e:8f59:3f26:7007])
        by mx.google.com with ESMTPSA id e203sm7733826oic.29.2015.04.17.20.09.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 20:09:37 -0700 (PDT)
Message-ID: <5531CAEF.9090606@gmail.com>
Date:   Fri, 17 Apr 2015 20:09:35 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org
CC:     devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: Re: [PATCH RFC v3 4/4] MIPS: BMIPS: accept UHI interface for passing
 a dtb
References: <1428834301-12721-1-git-send-email-jogo@openwrt.org> <1428834301-12721-5-git-send-email-jogo@openwrt.org>
In-Reply-To: <1428834301-12721-5-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46903
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

Le 12/04/2015 03:25, Jonas Gorski a écrit :
> Detect and use passed dtb address using the UHI interface. This allows for
> booting with a vmlinux.bin appended dtb instead of using a built-in one.

No particular objections to this change, current platforms support by
this change fall under 3 categories:

- BCM7xxx using a CFE providing a firmware interface you call into using
code from arch/mips/fw/cfe/
- BCM63xx CFE
- BCM33xx using Aeolus [1]

The first two are likely not going to be changed since these are
currently deployed products/systems, however the latter could be changed
to match UHI as Kevin proposed a while ago.

> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/bmips/setup.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index fae800e..526ec27 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -149,6 +149,8 @@ void __init plat_mem_setup(void)
>  	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
>  	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
>  		dtb = phys_to_virt(fw_arg2);
> +	else if (fw_arg0 == -2) /* UHI interface */
> +		dtb = (void *)fw_arg1;
>  	else if (__dtb_start != __dtb_end)
>  		dtb = (void *)__dtb_start;
>  	else
> 
