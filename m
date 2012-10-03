Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 13:46:49 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39691 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870412Ab2JDLqjfMoHi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 13:46:39 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so452917pad.36
        for <multiple recipients>; Thu, 04 Oct 2012 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5owT62RKovb8VKGC4Fcvz2u02R3MkBQ5NsoQ7brY/LI=;
        b=oOgozR/IOTUXM/DdGpF0qyd6CP8kK+IHUUotk6GB4MCodTZD4ISmlmxtQPOCFafIJg
         59dbIixscbmfUvffgt8oCZb38XZUyR98Mf1JhndepYghTVw51Yd6K6Mlz1as1gD9dJBn
         euYlJ7oMZh5qujj1MH0aQeFgCHS9Llanuzga21CGeXFSdMYUdOc2pPMuPt/b/D/hyJpw
         tRbxB9Ib6RP3Mpjs4jCTcgNq5SWqX8DYnbNSS5/y9PFh+KJQ/cFSBsqrfbglmc3kUQ58
         bMFWbzicvLSmxBxZz4dgz9pRBZUPBJK+Mci1bdyHMGin+R4Fs1LRLkw9rVfJn/if/xT/
         w7Lw==
Received: by 10.68.138.166 with SMTP id qr6mr14367343pbb.69.1349282751779;
        Wed, 03 Oct 2012 09:45:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ko8sm2855491pbc.40.2012.10.03.09.45.49
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 09:45:50 -0700 (PDT)
Message-ID: <506C6BBC.7090806@gmail.com>
Date:   Wed, 03 Oct 2012 09:45:48 -0700
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
Subject: Re: [PATCH 09/25] MIPS: Octeon: use ehci-platform driver
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-10-git-send-email-florian@openwrt.org>
In-Reply-To: <1349276601-8371-10-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34595
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
>   arch/mips/cavium-octeon/octeon-platform.c |   43 ++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)


NACK.

OCTEON uses device tree now (or as soon as I send in the corresponding 
patches), so this would just be churning the code.

David Daney
