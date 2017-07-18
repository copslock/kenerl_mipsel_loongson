Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 21:53:13 +0200 (CEST)
Received: from mail-qk0-x22e.google.com ([IPv6:2607:f8b0:400d:c09::22e]:36438
        "EHLO mail-qk0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994850AbdGRTxFgMl7Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 21:53:05 +0200
Received: by mail-qk0-x22e.google.com with SMTP id d136so25749783qkg.3
        for <linux-mips@linux-mips.org>; Tue, 18 Jul 2017 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/PrZ38oreRSS2TlHanZHyg9Uxx1v92GjlRWyP+VVaw=;
        b=bL5h/ilXaXXUHVG9Vu6sN3fg5m3GAde/+V4zidwM91nDE7tIWAqybSy0qLjwSIh+mI
         y73P5yQpDGoY6/EX1VBkUzAxHNABV/C5bLE7cRUQ48MqFMC0IyskZh/QHYX6ljBbGKk7
         v+CUhFPQlGsmCV4uqcmy6UswfMBK1A34F2yaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/PrZ38oreRSS2TlHanZHyg9Uxx1v92GjlRWyP+VVaw=;
        b=SQswyjuUuDcLmo3z5ZUUadORoJG5050tDp9wV/a4bFODDFOVbpMvBqZ2dDbzrygdHT
         r1F30P/vuiygC4ioEnOCcsK2JBlTkH3XEwNXYi8jd7yQwqAOvN+GTsNwUTAP3UifMQIl
         e7OMwfRVjlwsHN/a0b0d/+3ayKdgtZ9YWd3DPdIhcV0eR9NDtXrSu78MlqnU9MDhl0R6
         eOioNswgXBwOQFFBYVqee3V7ZS6kmQowrI4sNKaY0gLUjWMnTkyNzHeDFN05fZ7OMEb+
         DSK1nl4lcCLAM5wsQrfUATFnUrGdyDO9SEek61V5xqlwg6G5estshvIcAyXDj6yyd6OE
         LM+w==
X-Gm-Message-State: AIVw110IxIoJrySN0VyHczycieB7FBdXHLYfXwD5RF7SqGN35zyKqhIB
        lSfoj4G7YfFMOmBj
X-Received: by 10.55.31.150 with SMTP id n22mr4432702qkh.46.1500407579533;
        Tue, 18 Jul 2017 12:52:59 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id i18sm3066812qkh.18.2017.07.18.12.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 12:52:58 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org
References: <20170706222225.9758-1-f.fainelli@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <72d54e9c-6a50-2eac-52db-b1e8c234c552@broadcom.com>
Date:   Tue, 18 Jul 2017 12:52:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170706222225.9758-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <florian.fainelli@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@broadcom.com
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

On 07/06/2017 03:22 PM, Florian Fainelli wrote:
> Hi,
> 
> This patch series adds support for S2/S3/S5 suspend/resume states on
> ARM and MIPS based Broadcom STB SoCs.
> 
> This was submitted a long time ago by Brian, and I am now picking this
> up and trying to get this included with support for our latest chips.
> 
> Provided that I can collect the necessary Acks from Rob (DT) and other
> people (Rafael?) I would probably take this via the Broadcom ARM SoC
> pull requests.

Rafael, any feedback on this?

> 
> Thank you!
> 
> Changes in v3:
> 
> - make SRAM mapping uncached
> - make SWAP_STACK + brcmstb_pm_s3_finish a single asm volatile statement
> - added Rob's Acked-by to first patch
> 
> Changes in v2:
> 
> - clarify the first patch's subject (Rob)
> - removed patch #2 which was creating a bisectability problem (kbuild)
> - added proper AFLAGS to get s2-arm.S to build properly (kbuild)
> - improved MIPS power management binding document (Rob)
> 
> Brian Norris (1):
>   soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)
> 
> Florian Fainelli (2):
>   dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management
>     binding
>   dt-bindings: Document MIPS Broadcom STB power management nodes
> 
> Justin Chen (1):
>   soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)
> 
>  .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
>  .../devicetree/bindings/mips/brcm/soc.txt          | 153 ++++
>  drivers/soc/bcm/Kconfig                            |   2 +
>  drivers/soc/bcm/brcmstb/Kconfig                    |   9 +
>  drivers/soc/bcm/brcmstb/Makefile                   |   1 +
>  drivers/soc/bcm/brcmstb/pm/Makefile                |   3 +
>  drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 836 +++++++++++++++++++++
>  drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
>  drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
>  drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
>  drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
>  drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
>  13 files changed, 2094 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/bcm/brcmstb/Kconfig
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S
> 


-- 
Florian
