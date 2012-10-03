Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 14:15:05 +0200 (CEST)
Received: from mail-da0-f49.google.com ([209.85.210.49]:40133 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870258Ab2JDMPBxpEBi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 14:15:01 +0200
Received: by mail-da0-f49.google.com with SMTP id q27so231123daj.36
        for <multiple recipients>; Thu, 04 Oct 2012 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6C98hi/fm6G/jfLbQpj9jm08YSrDaVoEwhZ24X6NwCs=;
        b=sFNBsBRZNwg93ENPq4dD5qc798P/yNxbMMbzFgHjrUCptrJQzvyFXcIAMO/gaLE+nB
         EHbaRYg0VrEu/nokv9UPkoRcmGXKcwuprSlcR9uXOmQjqVqLErmkJ5+duEKWEVEhWXTj
         jF7phAF2ICCayuR33Z00BFK9Ho9lkPG4GStaZVPQfeYsbmSInde717xdh+awEZUjpHtw
         VF5Z/2/lJjGgnIlQt3mu7+pVzmRDy0lGz3nXa24b/R72qupqPcClrkQjcFEbij9v0egD
         MW9EW+30Z/IA/A4I6H7bgDNyoeVekEBme2G+V3oyyFNCOeEOTboQqy77M8X3ldsiGeKF
         Sv+A==
Received: by 10.68.190.71 with SMTP id go7mr14636923pbc.66.1349282864289;
        Wed, 03 Oct 2012 09:47:44 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qq9sm2862124pbb.24.2012.10.03.09.47.39
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 09:47:43 -0700 (PDT)
Message-ID: <506C6C2A.2060203@gmail.com>
Date:   Wed, 03 Oct 2012 09:47:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <w.sang@pengutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/25] MIPS: Octeon: use OHCI platform driver
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-20-git-send-email-florian@openwrt.org>
In-Reply-To: <1349276601-8371-20-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/03/2012 08:03 AM, Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>   arch/mips/cavium-octeon/octeon-platform.c |   37 ++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
>

NACK.

Same reason as for the EHCI one (09/25):

OCTEON uses device tree now (or as soon as I send in the corresponding 
patches), so this would just be churning the code.

David Daney
