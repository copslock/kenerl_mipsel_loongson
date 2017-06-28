Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 01:23:59 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:34842 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993975AbdF1XXv6V4ie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 01:23:51 +0200
Received: by mail-io0-f195.google.com with SMTP id 84so6575567iop.2;
        Wed, 28 Jun 2017 16:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kReLa+HpF4hw+4YILwCoEJSwAcvFObk/LWQuPH7MrPo=;
        b=KvWhmJchqYTT8mxj9kh4WuQTpiE6Ar84DcxqBxq1eOd02wPfExZDhypfP8n8mSKHHi
         yIRHFPKTRLeq+nVewMgvCb7d2TKwKd6sU4sfWquhHOPXfVaxjDLVzBPwrFOnsbGaEagb
         4+U4dgRmWL36wt4EdJFz99M0vceyDqxeLJBpCYIrhgMglYqBFpIMUOj8Vcu5XZuTiidh
         pihTnPE+Z/k91izUYenvCrVXehxq/8jgkVUC6MFQy9XilTZ7eWXQlCqZUTp7KAZSiQKo
         VrpQIK6gTvBuEwF6cfbkuT69ZkS+iG0orLuMhLhpLMdouO7enZ8FqX5wvfYkD2TKRhHX
         BGOw==
X-Gm-Message-State: AKS2vOwASapPttdPIaJ48wLXNmbaWaEcpGhDQ8/f8AUDOzRbcUYf04hU
        0bKBGZDVEjmDIA==
X-Received: by 10.107.138.36 with SMTP id m36mr14360231iod.232.1498692226215;
        Wed, 28 Jun 2017 16:23:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o14sm3666394itb.8.2017.06.28.16.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Jun 2017 16:23:45 -0700 (PDT)
Date:   Wed, 28 Jun 2017 18:23:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/4] dt-bindings: ARM: brcmstb: Update Broadcom STB
 Power Management binding
Message-ID: <20170628232344.rb4jus266yeq5yoj@rob-hp-laptop>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
 <20170626223248.14199-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626223248.14199-2-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58888
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

On Mon, Jun 26, 2017 at 03:32:41PM -0700, Florian Fainelli wrote:
> Update the Broadcom STB Power Management binding document with new
> compatible strings for the DDR PHY and memory controller found on newer
> chips.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
