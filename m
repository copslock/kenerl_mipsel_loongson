Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:37:36 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:34436
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993970AbdFZWfjAShft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:35:39 +0200
Received: by mail-wm0-x244.google.com with SMTP id f134so2773762wme.1;
        Mon, 26 Jun 2017 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDxfobamwSq/8Hm2czrVftMDvvKP6gKPjWfvPnulsg8=;
        b=fEiBy98Tfi3mXX145GsAa1NUgezJjtsMPDdx2yalf/VAo2o94t+CVFE9MxlJZL2xd8
         1UeQLOFPvKK+w1UgV+DyOh5auHGd0u3vSh2WQyi14W/4ZYwSSHaLVZCoxHr1702VIUqk
         SqewknSiql8EE5QPmY9xlCiIamEFnxEPA8QWvICyM6nFsn2C016Rciy1aP2Q2Rd4+ayG
         un/Qnuo2eDhtzFikOHiPgG6OFoCMK5bDYKq9cCoioNY6IbREQP/m5r+jxqyYqGklixk+
         kOxMX25ihiMEfoQfeT1lHT9WSZd50ZBYOtHQO9LJphGlxsLhQcbeMyT+iHr3xABL6AQl
         XIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDxfobamwSq/8Hm2czrVftMDvvKP6gKPjWfvPnulsg8=;
        b=TAr4WCu5Lh2yZkugUL8ZvNh96jAYzF6msuUHoSrx2GcAPaqaaY93soK5l5EsIAllZv
         gMaS54pnpXoy0hgNI9dQVd+NMq5yptgAhUUqcGp1cl7d7Un+9qW6dkF7thmkf8lIyeBR
         dYo+8xx9KYR9LylaU1s9jDSVW7CR/12YKT9jKnZGdfofq9Shf1zJlwzkXAJpa267GtAP
         gmH9MistUEvIUTJBUZ7mb1Vg+YURdGamF+wtMNoKYZjZ87qQQF1p4f+/WFPjOrWhQqVO
         CfNkWCRpmhHgy9Z0ZNN8oj9R7xWPpT3Tvz8P03xTSM9yz2vGGCdSkZmyJS4uQqZ293RT
         EVAA==
X-Gm-Message-State: AKS2vOwP5bW3SjUrwlAujVrNQ2DgQs7d28cxsX72ISHXc2HwbxLVRRfv
        k3s5F8wrKsWiTQ==
X-Received: by 10.28.135.5 with SMTP id j5mr1064134wmd.47.1498516533549;
        Mon, 26 Jun 2017 15:35:33 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 92sm24391442wrb.55.2017.06.26.15.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:35:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
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
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <94d1c634-99fd-e488-0aab-157396c0c86a@gmail.com>
Date:   Mon, 26 Jun 2017 15:35:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 06/26/2017 03:32 PM, Florian Fainelli wrote:
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
> 
> Thank you!

I managed to get other patches submitted from a related series, please
disregard those for now.

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
