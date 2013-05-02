Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 11:58:03 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43763 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834999Ab3EBJ6BvwVG7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 May 2013 11:58:01 +0200
Received: from mail-ve0-f175.google.com (mail-ve0-f175.google.com [209.85.128.175])
        by mail.nanl.de (Postfix) with ESMTPSA id 0AF2C45F79;
        Thu,  2 May 2013 09:57:46 +0000 (UTC)
Received: by mail-ve0-f175.google.com with SMTP id m1so312759ves.6
        for <multiple recipients>; Thu, 02 May 2013 02:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=q9+281XQMLltY3DJAdhxyUb2+zO2TJv6Vz6inGkQhX4=;
        b=Klg7GorurwcCYUL41/9E13G6ylTaF6vSLAhPOONQ5UKLlwFSe3fvlTl6Yl0qWkvjhq
         kCrf1UdEOPFWp8nXyQmya9dae9Lp4j5FlPkousPNsRbxXy8V4qN5Ehd4j1lVAktZiNjT
         ToZAc5+90M1ixKKtXG3ss4cjTLoq5GUg1ZiRRtV2HUV//X5H8U8Yzdxnjk8sR7TfZKbT
         2oE/bYtvT21KkIg30Fa8QCD73Wd/vf20Z4lbSK/3aoqKkFlRRDVTRhtlLsHHn53XQfNp
         JB42+7cE5S7MxiZBKy87ikSPzK4X3TsMnI/yUk+waDMzJc32MPC+H1+Vk8G002cBc8yM
         28FQ==
X-Received: by 10.220.202.138 with SMTP id fe10mr1906179vcb.26.1367488676071;
 Thu, 02 May 2013 02:57:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Thu, 2 May 2013 02:57:35 -0700 (PDT)
In-Reply-To: <6623143.198271367486832742.JavaMail.weblogic@epml20>
References: <6623143.198271367486832742.JavaMail.weblogic@epml20>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Thu, 2 May 2013 11:57:35 +0200
Message-ID: <CAOiHx==2EGhRU9AwvkK_+9FpWpCDSHLsfwBnoK8_9UgWkLAXZA@mail.gmail.com>
Subject: Re: Re: [PATCH] MIPS: remove USB_EHCI_BIG_ENDIAN_{DESC,MMIO} depends
 on architecture symbol
To:     eunb.song@samsung.com
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "florian@openwrt.org" <florian@openwrt.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Thu, May 2, 2013 at 11:27 AM, EUNBONG SONG <eunb.song@samsung.com> wrote:
>
>>These are selects and don't prevent anyone else from also selecting
>> them. If you look at your referenced commit, you see it removed the
>>/depends/, not the selects. It actually added selects to several
>> platforms. Platforms are supposed to select them if they need them.
>
> Hello.
> Every time i config with arch/mips/configs/cavium_octeon_defconfig, the following warning messages
> are showed.
> warning: (MIPS_SEAD3 && PMC_MSP && CPU_CAVIUM_OCTEON) selects USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
> warning: (MIPS_SEAD3 && PMC_MSP && CPU_CAVIUM_OCTEON) selects USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
>
> And after applying this patch, the warning messages were disappeared.

But after this patch likely EHCI is also broken on these platforms.
The solution is to either guard the USB_EHCI_BIG_ENDIAN_MMIO/DESC
selects with if USB_EHCI_HCD etc, or make
USB_EHCI_BIG_ENDIAN_MMIO/DESC not depend on USB_EHCI_HCD etc.

As far as I can tell, USB_EHCI_BIG_ENDIAN_MMIO/DESC only have any
effect on the ehci_hcd code anyway, so removing the dependencies of
these symbols should be fine and without any side effects, thus allow
platforms/drivers to select them unconditionally.

Greg, what do you think?


Jonas
