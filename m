Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 02:09:36 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:45295
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993095AbdKBBJ2H38bm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 02:09:28 +0100
Received: by mail-pf0-x243.google.com with SMTP id d28so3302735pfe.2;
        Wed, 01 Nov 2017 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8wW9B21Ys61HDGHKKP8CwoNUv7p+LCSmtxpQcgX6CWM=;
        b=PHfvGPHOYwwMpkBYW+ZgI5NayeQVmEZ+benV72UH7V0bbAhapnQ5gKre3m7qr73v8r
         OHb9D76aU6xjN71C2vx5qktarEdaN56yMV9TkivzS/LiIwhocKNKn9XurOQQ+hALtMsP
         ls7rAI5OtfOwqqUbd0/vgaMTu5LFOJpsnOM+CT08uT2mJaAFcBKjiu8hxzmh9bcsait+
         /6RxNoNOqujhZHCzoWtPJNBYa7uS6/4HPuJxbgmR64QWO9ztZojpWlL9mSBLU4xtOGuH
         W3kKDGOq/RSRLFfEBLSmiuQAAHGl8zN8rGtgjM9vLaMpps3cDnnIsOHwACkDtnkoTRyX
         8qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wW9B21Ys61HDGHKKP8CwoNUv7p+LCSmtxpQcgX6CWM=;
        b=Cea4VCyC7HkX06P7sS6KhWWcpeztS5xcGwDRyAdhM5+RusJgQH6RMnj8NQwanePv2v
         D1lZMH31s8KKNoDUR71b6cUbW4xo4lJM4ScQvvh1Lbs42jKGU+VTjLvVEtRjQRntEtLA
         t8c8njzooY1stLPeSn7V45Lpwji3Gj30X+36kfYX9CIT2KI2Ycs0/X8M1CVCIE0asmk/
         9qIQl2nvkt3m07Jxc9Hk1cfE1KU+fbYj7269SDBoCjbGL4FOO6KST0epY1G8GKV3MvfD
         qGOf8ZdYyUO7ciyFp680wU7C8bztc5kbdZT9EbEJjxqUmiCwLzD8fmEbbmFW47sXOLNT
         s25A==
X-Gm-Message-State: AMCzsaXZ2nLlGkz3AJs6LJF7jhKMwvMpZaQhzy1Zksw0zws1pUmtiUsn
        vZ9/PZpA2UQWoy1oUhQ8/Bs=
X-Google-Smtp-Source: ABhQp+R/Rrkh/3L9KfEarHQ6LmsaUH6lucnQTbEo1cCtilFgvydNcJyUid88+1zwJVzeSMc9hCUO1w==
X-Received: by 10.99.3.213 with SMTP id 204mr1661116pgd.407.1509584960188;
        Wed, 01 Nov 2017 18:09:20 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id p21sm3899223pfk.185.2017.11.01.18.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 18:09:19 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-2-david.daney@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <af0de889-a34b-8346-9eeb-171498cc61ca@gmail.com>
Date:   Wed, 1 Nov 2017 18:09:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171102003606.19913-2-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60653
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

On 11/01/2017 05:36 PM, David Daney wrote:
> From: Carlos Munoz <cmunoz@cavium.com>
> 
> Add bindings for Common Ethernet Interface (BGX) block.
> 
> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
[snip]
> +Properties:
> +
> +- compatible: "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs.
> +
> +- reg: The index of the interface within the BGX block.
> +
> +- local-mac-address: Mac address for the interface.
> +
> +- phy-handle: phandle to the phy node connected to the interface.
> +
> +- cavium,rx-clk-delay-bypass: Set to <1> to bypass the rx clock delay setting.
> +  Needed by the Micrel PHY.

Is not that implied by an appropriate "phy-mode" property already?
-- 
Florian
