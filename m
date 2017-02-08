Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 23:12:02 +0100 (CET)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36049 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbdBHWLywexx3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 23:11:54 +0100
Received: by mail-oi0-f68.google.com with SMTP id u143so12034695oif.3;
        Wed, 08 Feb 2017 14:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VFWnoCDBJlzcx+VROAEBdtJl3RpoxZprMlMij7XOvwg=;
        b=OEjP5rtnbRl6Q2qf3zfUVKx3Eab0GqpqJGhSaMwoWS7Bi+H014owOyO2Q3TZfie+Go
         HMQkmJYVcniMtnAMjBIeTcSVxVoy1AmP09AyMRBBM9LsF4xhDhZid1ehMJtd+b0puvur
         whyiyrg50VaG5xXz3iUzw8IGUtnj97oZ2rxQgZMjJdEZQLyJKgTZsTZv9DxXzMFV83px
         vqy+pILkvHIUz4YJCq9fIu28xDhtipAIp+K+sqbWn+W5N2ZlW2UzfcACcinB5yoePxT9
         kI73+BGQg8ZimUOZJafCOOOuljO0CdWGjE071lK/P1YDVE8ZzwsbWIl2cFcj6mK01Y0h
         ZCHA==
X-Gm-Message-State: AMke39ksKRCPUnfez7bWwBp+Q5SER3PBhQBvfXHL1ea1ihLH1ZNmtoischja+0HPLzwctw==
X-Received: by 10.202.245.214 with SMTP id t205mr11172392oih.52.1486591909001;
        Wed, 08 Feb 2017 14:11:49 -0800 (PST)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id y19sm4727090oie.12.2017.02.08.14.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2017 14:11:48 -0800 (PST)
Date:   Wed, 8 Feb 2017 16:11:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alban <albeu@free.fr>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 3/3] MIPS: ath79: Fix the USB PHY reset names
Message-ID: <20170208221147.rwoirkib23s6wuzz@rob-hp-laptop>
References: <1486324352-15188-1-git-send-email-albeu@free.fr>
 <1486324352-15188-3-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486324352-15188-3-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56738
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

On Sun, Feb 05, 2017 at 08:52:32PM +0100, Alban wrote:
> From: Alban Bedel <albeu@free.fr>
> 
> The binding for the USB PHY went thru before the driver. However the
> new version of the driver now use the PHY core support for reset, and
> this expect the reset to be named "phy". So remove the "usb-" prefix
> from the the reset names.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  Documentation/devicetree/bindings/phy/phy-ath79-usb.txt | 4 ++--
>  arch/mips/boot/dts/qca/ar9132.dtsi                      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
