Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 18:51:01 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:38425 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492050Ab0GSQu4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jul 2010 18:50:56 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 81C701C000BC;
        Mon, 19 Jul 2010 18:50:55 +0200 (CEST)
X-Auth-Info: EgcEcfZznLWqc0bE9WIkpdkcvvfzNweSxoJKd6MxGm0=
Received: from lancy.mylan.de (p4FE647BA.dip.t-dialin.net [79.230.71.186])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 314D41C00161;
        Mon, 19 Jul 2010 18:50:55 +0200 (CEST)
Message-ID: <4C44827C.8030401@grandegger.com>
Date:   Mon, 19 Jul 2010 18:51:08 +0200
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Wolfgang Grandegger <wg@denx.de>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [RFC PATCH v2] au1000_eth: get ethernet address from platform_data
References: <1279544125-28104-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1279544125-28104-1-git-send-email-manuel.lauss@googlemail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 07/19/2010 02:55 PM, Manuel Lauss wrote:
> Modify au1000_eth to receive an ethernet address from platform data,
> or choose a random one.
> 
> The default address is usually provided by the firmware; modify
> platform device registration to use it if the board code has not
> already overridden it.
> 
> Cc: Wolfgang Grandegger <wg@denx.de>
> Cc: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> v2: diffed against linus-git, on top of Wolfgang's patch
>     "mips/alchemy: define eth platform devices in the correct order"
>     This one should actually apply cleanly.
> 
> 
> IMHO a device driver should not call firmware-specific functions
> (be it MIPS-style prom_get_*(), OF properties or whatever) to
> get missing information.  Instead this should be done by the
> platform code which sets up the device.  This patch does just that.
> 
> Compile-tested only.  Florian, Wolfgang: could you please give this
> a try on your boards?  If it works and you agree to it, I'll
> resubmit it also to linux-netdev.  Thank you! (I don't have
> accessible au1000-eth hardware).

I will give the patch a try tomorrow morning when I'm back in the office.

Wolfgang.
