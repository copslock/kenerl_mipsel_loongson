Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 01:06:48 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:36177
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994675AbeCFAGlaoDh6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2018 01:06:41 +0100
Received: by mail-qt0-x242.google.com with SMTP id c7so22589276qtn.3;
        Mon, 05 Mar 2018 16:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HU0DKao2J5r+51T/QABlOq9Nu9tnI4bwI5QTFnQKbXg=;
        b=clheTvcGeBjo4aoZspSALczX8MyeTIJHRyNscOjGHh0owoRjE6KvGI32EgVdx0AIZ4
         sDnIMWZFjBM5Ma3YeS3+6cqhS4bAYFKTIVfj1FEXClVWtXcyaMVEhrQwp8MevkDrBAIy
         NQqz3Ot3YchUCWX8uG6HreOUTFxlF1do+FpCFW1HyryMW29HCJxOJ+8ovoPKQWynQ9Lc
         3EJ3vWKMmDdnaQLFMLtJL+1BXv18hePbb81RKpeOe7kW/FMhLtVs6LGKcr3mmuaKS87Q
         kA+A+dSUvy37M/4H4aNi7ugxFJUsZ5kzxcyRvclOpQp97rYPMPPo+DhA3ScIwo0JLx7N
         KIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HU0DKao2J5r+51T/QABlOq9Nu9tnI4bwI5QTFnQKbXg=;
        b=MeO4LgYKAR6Plnwkh0GriLqZpx4D4ZhFloKB8b8Y8lJ/Pw3FhGNk7JY2nAIY7ivHss
         E/9251gtirraS6YdiR5tTxV5Tj1F8fvOYowRwmJ3AF1yk+ka2p7OMt1aNAJyXO7rqGpw
         6bian8LZP/YqRCn2UrOO9AoCqWUd2CLyOJkf22KQm9pdGdHEyr2GFU0Uv06cSgFnrjQk
         sN3S6WrAEVMUh7c3QyXpKTPdt05tZCy/MNb6jghJ4Xx3jC3mvX4WkykvOKeG+DGME4EN
         8BFflmaAS2y9aCfmoEihThX8YrWt/NtJimCrqGGZGrl3+zx9y95KUc3OAjixq/9ntLCW
         aaUw==
X-Gm-Message-State: AElRT7Gwod4nW62fq7EBnyqMqZZTOlZRbE48chxoGRaJV5c2WA76+5d5
        3kakAPvRJL8wv6UoXkgAu8Q=
X-Google-Smtp-Source: AG47ELuhImnBLvGsVh/O4sP1N0w9lyms5efiywTp9yvG/yvZtjfqOIeWuc3pB8Ci8CInZMnb3rqRjA==
X-Received: by 10.200.63.60 with SMTP id c57mr26524703qtk.286.1520294795096;
        Mon, 05 Mar 2018 16:06:35 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x8sm9969498qta.64.2018.03.05.16.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 16:06:34 -0800 (PST)
Subject: Re: [PATCH 0/3] MIPS: BMIPS: Add Broadcom STB device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
References: <20171117021944.894-1-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56e80e5d-8cdd-3b32-c0f5-ac33c45346b8@gmail.com>
Date:   Mon, 5 Mar 2018 16:06:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171117021944.894-1-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62812
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

On 11/16/2017 06:19 PM, Jaedon Shin wrote:
> This series adds power and memory management related devie tree nodes for
> Broadcom STB platforms.
> 
> Jaedon Shin (3):
>   MIPS: BMIPS: Add Broadcom STB power management nodes
>   MIPS: BMIPS: Add Broadcom STB wake-up timer nodes
>   MIPS: BMIPS: Add Broadcom STB watchdog nodes

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> 
>  arch/mips/boot/dts/brcm/bcm7125.dtsi      |  7 +++
>  arch/mips/boot/dts/brcm/bcm7346.dtsi      | 62 +++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7358.dtsi      | 17 ++++++
>  arch/mips/boot/dts/brcm/bcm7360.dtsi      | 62 +++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7362.dtsi      | 62 +++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7420.dtsi      |  7 +++
>  arch/mips/boot/dts/brcm/bcm7425.dtsi      | 89 +++++++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7435.dtsi      | 89 +++++++++++++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 ++
>  arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 +++
>  arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 +++
>  arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 +++
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 +++
>  arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 ++
>  arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 +++
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 +++
>  16 files changed, 451 insertions(+)
> 


-- 
Florian
