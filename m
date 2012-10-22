Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 20:28:09 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52037 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825656Ab2JVS2Iu8pam (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 20:28:08 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2005802pad.36
        for <linux-mips@linux-mips.org>; Mon, 22 Oct 2012 11:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=LQGVIgWAFO1akSwbhPh8f1/2hBRDYkz8IDkYyeijMoo=;
        b=mGOR/Q/kB24K6FmjuI02fLLXDBuPYhiXrRnAkN+eOs8p/N3tfaysBY4TM2jii1qzgw
         xgcMciQADDcmUP/ZjbAH/5nRxamj6whh6XU83+1mRDjuEKjYFVTWGM2CK2SR2vqRk5bT
         PiZaXxjo3T34ywa2++qWaiDPC+vAbg9PcJ7D12Km7Ej+JDEqT4uvS3Js+KvIQRqhKojl
         5JnG/tr695w3MjnRC0NwpdhgKv+GNklIIX1MiTZ/VZLsMaTRtAV+vwEZO/QZkkETsg8j
         638O33lw9rNQWbMsszV5DXzM66mKjdGw+VUfvTcAX2y3S/2srRqgh8ixznaj1q3UB71e
         QXCw==
Received: by 10.68.252.168 with SMTP id zt8mr2966687pbc.43.1350930482226;
        Mon, 22 Oct 2012 11:28:02 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id sa2sm6305427pbc.4.2012.10.22.11.27.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 11:28:01 -0700 (PDT)
Date:   Mon, 22 Oct 2012 11:27:58 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32 v4] MIPS: Alchemy: use the OHCI platform driver
Message-ID: <20121022182758.GA31971@kroah.com>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
 <1349701906-16481-25-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1349701906-16481-25-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkWEqiMA9jbDxXtxkFxrHDGqYFi2D3tZ4GR1VZU7U+MbATBMcN9fhuGpP5UKMJMspWWSDfO
X-archive-position: 34737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Oct 08, 2012 at 03:11:38PM +0200, Florian Fainelli wrote:
> Convert the Alchemy platform to register the ohci-platform driver, now that
> the ohci-platform driver properly handles the specific ohci-au1xxx resume
> from suspend case.
> 
> This also greatly simplifies the power_{on,off} callbacks and make them
> work on platform device id instead of checking the OHCI controller base
> address like what was done in ohci-au1xxx.c.
> 
> Impacted defconfigs are also updated accordingly to select the OHCI platform
> driver.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> Changes in v4:
> - rebased against greg's latest usb-next
> 
> No changes in v3
> 
> Changes in v2:
> - updated defconfigs accordingly
> - really instantiate "ohci-platform" instead of "ohci-au1xxx"
> - rebased on top of the latest OHCI HCD changes
> 
>  arch/mips/alchemy/common/platform.c |   35 +++++++++++++++++++++++++++++++++--
>  arch/mips/configs/db1000_defconfig  |    1 +
>  arch/mips/configs/db1200_defconfig  |    1 +
>  arch/mips/configs/db1300_defconfig  |    1 +
>  arch/mips/configs/db1550_defconfig  |    1 +
>  arch/mips/configs/gpr_defconfig     |    1 +
>  arch/mips/configs/mtx1_defconfig    |    1 +
>  arch/mips/configs/pb1100_defconfig  |    1 +
>  arch/mips/configs/pb1500_defconfig  |    1 +
>  arch/mips/configs/pb1550_defconfig  |    1 +

Same issue with the defconfigs in this patch, they aren't around
anymore, so I've removed them from this patch.  If they just moved,
please send a follow-up patch to fix them up.

thanks,

greg k-h
