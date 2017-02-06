Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 09:52:29 +0100 (CET)
Received: from mail-lf0-x22a.google.com ([IPv6:2a00:1450:4010:c07::22a]:35542
        "EHLO mail-lf0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991955AbdBFIwUQioR2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 09:52:20 +0100
Received: by mail-lf0-x22a.google.com with SMTP id n124so40676214lfd.2
        for <linux-mips@linux-mips.org>; Mon, 06 Feb 2017 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wjSbXd0jmyDZ5CRydRObMEzbtAziv42q+/O2rp4LNwo=;
        b=kvjd8rpmrUAx7JESS25LmpsPuOKG+XADPod6BaQeeZWnHiequv8SoBPlEe3170bIsF
         MjFk0i7I0rGrad82EJTbydznvUu7r5bc8R/OO5yN+73SF7HUEGxJgmO6YAzxFrd8hUVa
         4iKMkfU1J7uIMI3F1Ln3m9pg+8oOGANj35dlYuRqNoWKv48tiP8Be0BTqW9rAq1wcEkO
         pHUcxn4wFMa23ucsso8gX4mNLDSY+NnhAgNPaWibDTpoJcBgccUpUB6bvU9rE1qUs12V
         m9zNbh68y/RxhbJu+FRZe4wK2Xd2Bpq+Bc2+3eUNoQWtcltmcy1wx4l+pki8qyvVcbBu
         Ub2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wjSbXd0jmyDZ5CRydRObMEzbtAziv42q+/O2rp4LNwo=;
        b=fOecUbKyo67D2cS5Y6NC+1zG83/gifRjk7RPF0K91PlInU+a7UcVD2CBfPhwhwVzTS
         bIg935wKnUwEX1EF0i81XknXfe+arUn1ySXeOo7GwDz7TmfiIfLHZ3VpdiIuuCRvh/GV
         uLcI1rtqXzt+2K/RdNT/a4Zuu6TH3jAFmzvZRqFZp/JhN4LOmlHkuETS8ByZNmVupMVO
         L6iCGOkKWJhB08dqVsIlEcqAoxbLjGyPYYvd0cr7a8QhemrXGxF+RD/FCw9bqN4K37WP
         SZpCG+92PksCH7txyAM5Wc7fxpC2FunElpnaVkA/thj6Ao7UKBMcRve1IRV39+vay+MZ
         dwcg==
X-Gm-Message-State: AMke39kBoq8x8k2tWnmqb4+UYHE7EUwc79JnoWYq0CxERQ56Zrh34z59NJGw6R40bzu5aA==
X-Received: by 10.25.80.66 with SMTP id z2mr2790734lfj.157.1486371130308;
        Mon, 06 Feb 2017 00:52:10 -0800 (PST)
Received: from [192.168.4.126] ([31.173.83.189])
        by smtp.gmail.com with ESMTPSA id s63sm16773lja.49.2017.02.06.00.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 00:52:09 -0800 (PST)
Subject: Re: [PATCH] MIPS: Allow compressed images to be loaded at the usual
 address
To:     Alban <albeu@free.fr>, linux-mips@linux-mips.org
References: <1486326077-17091-1-git-send-email-albeu@free.fr>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1762cdb0-c0f1-f667-e136-cfb40205aa88@cogentembedded.com>
Date:   Mon, 6 Feb 2017 11:52:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1486326077-17091-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56649
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

On 2/5/2017 11:21 PM, Alban wrote:

> From: Alban Bedel <albeu@free.fr>
>
> Normally compressed images have to be loaded at a different address to
> allow the decompressor to run. This add an option to let vmlinuz copy
> itself to the correct address from the normal vmlinux address.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>
[...]

    Just some grammar nitpicking...

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde..8074fc5 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2961,6 +2961,14 @@ choice
>  		bool "Extend builtin kernel arguments with bootloader arguments"
>  endchoice
>
> +config ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
> +	bool "Load compressed images at the same address as uncompressed"
> +	depends on SYS_SUPPORTS_ZBOOT
> +	help
> +	  vmlinux and vmlinuz normally have different load addresses, with
> +	  this option vmlinuz expect to be loaded at the same address as

    Expects.

[...]

MBR, Sergei
