Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2017 17:45:08 +0100 (CET)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35930 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993417AbdBVQo7gwN0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Feb 2017 17:44:59 +0100
Received: by mail-ot0-f195.google.com with SMTP id l26so824340ota.3;
        Wed, 22 Feb 2017 08:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVGHoLXNiGBus/ymQAUkrBLuPxc04nO2/RRXk11PVLw=;
        b=m0JHv3T7PRPszS3BOTw7FVXXNAEulmH1ABjCvpgTdNmPVPRZj3keUX64fI+CoLU1wB
         8vklEuhkRaZ7dCql1iABfxmRsJtQYQlzXjB8AAA2SmfWZEZM1QOm558kMi2Xyi4LZVLG
         k+o86sgsDI2Faw5IRv2ZY2oSgbcK2Guc+L1IHL6UwDawfOJ8EqnpTlWnPdz0/Sfl8ja1
         IYetqf9jGpHz9Iya5H+8SIaYmETdkj9lJ8ooi1/6fr5RSjVyn3e9Kibu6Kpcp8T5CDB1
         pAqkTjRA1jIDh4wPz2wLnIhyZRsHIy/mAkEkrS2Oq3+cHMIudHDRAihFQ/YlpFdatiid
         Q9MQ==
X-Gm-Message-State: AMke39kvLtLQyZ0cNBoJdXKWRzbiNXtHfp/W8J/Bfn1z5j9srrqw6hJEk83GEtwoCp0QsQ==
X-Received: by 10.157.42.193 with SMTP id e59mr15943129otb.127.1487781891426;
        Wed, 22 Feb 2017 08:44:51 -0800 (PST)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id t130sm569717oie.5.2017.02.22.08.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Feb 2017 08:44:50 -0800 (PST)
Date:   Wed, 22 Feb 2017 10:44:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alban <albeu@free.fr>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 3/3] MIPS: ath79: Fix the USB PHY reset names
Message-ID: <20170222164450.lr2njfrvv6wwsacl@rob-hp-laptop>
References: <1487024746-32082-1-git-send-email-albeu@free.fr>
 <1487024746-32082-3-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487024746-32082-3-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Feb 13, 2017 at 11:25:46PM +0100, Alban wrote:
> From: Alban Bedel <albeu@free.fr>
> 
> The binding for the USB PHY went thru before the driver. However the
> new version of the driver now use the PHY core support for reset, and
> this expect the reset to be named "phy". So remove the "usb-" prefix
> from the the reset names.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> Changelog:
> v5: * Also fix the AR9331 dtsi
> ---
>  Documentation/devicetree/bindings/phy/phy-ath79-usb.txt | 4 ++--
>  arch/mips/boot/dts/qca/ar9132.dtsi                      | 2 +-
>  arch/mips/boot/dts/qca/ar9331.dtsi                      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
