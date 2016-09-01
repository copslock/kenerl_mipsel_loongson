Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 12:54:52 +0200 (CEST)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35012 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990521AbcIAKyo4OvvD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 12:54:44 +0200
Received: by mail-lf0-f50.google.com with SMTP id e198so23870837lfb.2
        for <linux-mips@linux-mips.org>; Thu, 01 Sep 2016 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=w2dvDm98DhNyCgAEhlkJv+IlnzsJuntSNpnoD9tkb00=;
        b=FloaT8zJVMF0Ny1+qa8wjWgmTyHeLrx42RwHaiEoVMSMZz/NwalR+fNyzA0TMk0J9b
         MA1bv0HDgJuSpKlvd7bVMIYR9pCFkLDXtjjzz01bnEp5S7vpPLojRMI3lgm713DKterV
         RbXGPHHshLJumADc5Ak7lOiCnkOmiWCaGXnqfW8X5I4R5jHcmZ1lyXPcxgRH9uexm/1A
         ibwmREvj9lIQSuYT7R5qFLNPraVZ+wrh4apLaGX1FWXIlpDFZTotd7DlkcX/RYj5S7sv
         JmdYusmbAA2fYjpzkH3XghhNh6GuvlweVVB8o6uzBYi08zyooxdkVzbo9z7+gRERqOIA
         eNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w2dvDm98DhNyCgAEhlkJv+IlnzsJuntSNpnoD9tkb00=;
        b=Cdoazti47XKo48VuW86Y9vfOzfEaQki3ZZ50In7yLv0/WtEYZMBgVq+yjdZogYcNjS
         cQGOkDhQ2gQqyihkY2EwKR7UkOUjTFRVZGV4a5s74UN94sCImzSAMZ/BNJA+qFMIxrUr
         T7sinOsYDMG2wcFusqBFFaRH5zPvO9gGEhX3VdgMNWfZ5qj0CktqbSgiViwIo0T8uFTt
         w/u7KPAmJUPY59XKnKh9qtyudoCrX+kAblFyv1uwrP6z/OrFD+HTK3cwysT2sUYN9Suc
         zujqY8nyLDCPwUjVtF9r9Z5Fw0pJE9f/XUIQ8kkrUBjh9Az0nQiInIBPBZYAVVQj02UA
         l0rQ==
X-Gm-Message-State: AE9vXwNLnKKVhhijMtt8URx0/drEr2SP7daai5aY9YfwNY1se9lfRyyIQyoqLuunrKuD/Q==
X-Received: by 10.25.92.65 with SMTP id q62mr2715125lfb.3.1472727277104;
        Thu, 01 Sep 2016 03:54:37 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.49])
        by smtp.gmail.com with ESMTPSA id i80sm839465lfg.6.2016.09.01.03.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 03:54:36 -0700 (PDT)
Subject: Re: [Patch v3 09/11] net: ethernet: xilinx: Enable emaclite for MIPS
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com
References: <1472661352-11983-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472661352-11983-10-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, michal.simek@xilinx.com,
        netdev@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <52b2d771-7490-efcc-734f-2caaad6c35e4@cogentembedded.com>
Date:   Thu, 1 Sep 2016 13:54:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472661352-11983-10-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54918
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

On 8/31/2016 7:35 PM, Zubair Lutfullah Kakakhel wrote:

> The MIPS based xilfpga platform uses this driver.
> Enable it for MIPS
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

[...]

> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 4f5c024..ae5c404 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -5,7 +5,7 @@
>  config NET_VENDOR_XILINX
>  	bool "Xilinx devices"
>  	default y
> -	depends on PPC || PPC32 || MICROBLAZE || ARCH_ZYNQ
> +	depends on PPC || PPC32 || MICROBLAZE || ARCH_ZYNQ || MIPS
>  	---help---
>  	  If you have a network (Ethernet) card belonging to this class, say Y.
>
> @@ -18,7 +18,7 @@ if NET_VENDOR_XILINX
>
>  config XILINX_EMACLITE
>  	tristate "Xilinx 10/100 Ethernet Lite support"
> -	depends on (PPC32 || MICROBLAZE || ARCH_ZYNQ)
> +	depends on (PPC32 || MICROBLAZE || ARCH_ZYNQ || MIPS)

    Parens not needed here, you could remove them while at it.

[...]

MBR, Sergei
