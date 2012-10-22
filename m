Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 20:19:15 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49232 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825655Ab2JVSTPAtQ8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 20:19:15 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2000702pad.36
        for <linux-mips@linux-mips.org>; Mon, 22 Oct 2012 11:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=n4C7IsvqYv0ChPxGQJJQBG2hB7/WmMkHwUCe/Y9fz1U=;
        b=N6/NKk/XCBtUmNmANLFogpnsZDI1y3VtzIwXaq8RuTDt/HtkbW0nSVqBTlUYoPL+gz
         czRGqhDPnF6zolf3GGuB+wUwM/1tCB0xXzVps+eR8odxOZwoDu1wJngC8OFe7xT3V16h
         FJHlRbLmtdkSMBPuNzYBiXETIeTPEADtVoV63Jxr1+mYF48Akck3gvCXRV4FgiPFkh5T
         wvq81NQGwNS7GuClP/Yc+hVmaZw8HyAIHAuvEYTU2/d9AS6QFVpuUTgCbrYuBC3UApAq
         Ky+4ylO36ZmTf6MZeYt1KrgKXzaTlL7CUGv96N9zpVKQkSpXySxBEcyljVm3ksoS0qkR
         JhYQ==
Received: by 10.68.241.137 with SMTP id wi9mr31977728pbc.158.1350929948146;
        Mon, 22 Oct 2012 11:19:08 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id y5sm6264596pav.36.2012.10.22.11.19.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 11:19:07 -0700 (PDT)
Date:   Mon, 22 Oct 2012 11:19:04 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/32 v4] MIPS: Alchemy: use the ehci platform driver
Message-ID: <20121022181904.GA6077@kroah.com>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
 <1349701906-16481-9-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1349701906-16481-9-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkeAfFiR7tVSCLVdQBMxuvFvXAHRSgo0Pt9o9KIH35OKy2XtV2CJAgOJGTwGa7cCz7Z6HOM
X-archive-position: 34736
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

On Mon, Oct 08, 2012 at 03:11:22PM +0200, Florian Fainelli wrote:
> Use the ehci platform driver power_{on,suspend,off} callbacks to perform the
> USB block gate enabling/disabling as what the ehci-au1xxx.c driver does.
> Update the db1200 and db1300 defconfigs to now select the EHCI platform
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
> - update impacted alchemy defconfigs accordingly
> 
>  arch/mips/alchemy/common/platform.c |   23 ++++++++++++++++++++++-
>  arch/mips/configs/db1200_defconfig  |    1 +
>  arch/mips/configs/db1300_defconfig  |    1 +

These two defconfig files are no longer in Linus's tree, so I'll just
remove them from this patch.  If that's not ok, can you send a follow-on
patch that adds the config option to the correct defconfig file?

thanks,

greg k-h
