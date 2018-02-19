Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 03:17:45 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:45897
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994650AbeBSCRhdcFDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2018 03:17:37 +0100
Received: by mail-ot0-x244.google.com with SMTP id f11so1770678otj.12
        for <linux-mips@linux-mips.org>; Sun, 18 Feb 2018 18:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aj81d2Jc3hscmAX+oeSGsvBotpBxamOYP2KuoQcrrp4=;
        b=sDblaCZ7j0sFbJ3iJgAHvrOwkKSMEy66hgot01llK722MXkqYzUpevj1cYV9hqRFuJ
         e16ZXApLKc2jw0diSL4JEzsvotU5DEmzCLo3PKin+KDRsF1JwzSYcKX/oOuDtiMv1g6b
         Q2KHO5X1RJCY0RX7qP68y6q5VRTpM8Re3xOQlufesFgeDTPWM9RNVkIXZ70lWJhizXBZ
         UgXsLUTjW4G6B4qztJF2enEW3FDRjTLC9l+TVCHG8yr5zbOz1HQBQuNhPUVe9kuIkbsN
         yzgkJNFEkG3YZhzqX9ER813gyGJw35eZ4ztr2L12/yEpLsf7gOWk3Jl7pUD+YYYMv4k+
         7Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aj81d2Jc3hscmAX+oeSGsvBotpBxamOYP2KuoQcrrp4=;
        b=Sq9TmB8MqLX1F5er7KGRnCh2cyGhrD/BWQ32A9X/en19/pyELxdsQsofWwNCH3PN2J
         Urt366rgeon2LqRWNeHNZ6pJWAS5zakduZrGDvD/GXM0hzi6raD2O3kh3Ws6g7D2yf1G
         5rgtC7HkwndAd+zFKnyxfWxnvfGxwCIMl9p7+B7QiRPseXwtMCZz9VtyTxVKjZWPqJA7
         MqrafjcgxBveUW59mmx4hyVSGPCDxUACxJTPCoNOgLth9julqx53uKbiERGBm3yA7oLF
         nLTGnWR1YF1wpxJsGbakLT0jNWbE9NNoXKIb7c5MqkxJK7GzCNnJz+TUAj8ZDda9VrK6
         p9hg==
X-Gm-Message-State: APf1xPDPDWHdRCc3mc1am+Zpwe1aHYze7eLjS0cjFThqP5jubY6EVNg3
        8fpQn8kjC3Juu1LV0uKS+PfcqohX
X-Google-Smtp-Source: AH8x227n8retxPk+8F0ezXSEBM1qaoD+HLnTVQBYQsqNHza4gMeQ0IH9MVaPNtWbGHwb0m6dv7o6VQ==
X-Received: by 10.157.75.144 with SMTP id k16mr2757134otf.201.1519006650712;
        Sun, 18 Feb 2018 18:17:30 -0800 (PST)
Received: from [192.168.1.3] (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.gmail.com with ESMTPSA id j67sm4559835otc.10.2018.02.18.18.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2018 18:17:29 -0800 (PST)
Subject: Re: [PATCH v5 00/14] net: pch_gbe: Fixes & MIPS support
To:     David Miller <davem@davemloft.net>, paul.burton@mips.com
Cc:     netdev@vger.kernel.org, hassan.naveed@mips.com,
        matt.redfearn@mips.com, linux-mips@linux-mips.org
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180218.103112.1461192916516173265.davem@davemloft.net>
 <20180218170310.lpwjtnxe6awrhgen@pburton-laptop>
 <20180218.201529.723706104813615973.davem@davemloft.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5075d1c4-804b-d1c5-a109-87fdc20dbc73@gmail.com>
Date:   Sun, 18 Feb 2018 18:17:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180218.201529.723706104813615973.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62618
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



On 02/18/2018 05:15 PM, David Miller wrote:
> From: Paul Burton <paul.burton@mips.com>
> Date: Sun, 18 Feb 2018 09:03:10 -0800
> 
>> Hi David,
>>
>> On Sun, Feb 18, 2018 at 10:31:12AM -0500, David Miller wrote:
>>> Nobody is going to see and apply these patches if you don't CC: the
>>> Linux networking development list, netdev@vger.kernel.org
>>
>> You're replying to mail that was "To: netdev@vger.kernel.org" and I see
>> the whole series in the archives[1] so it definitely reached the list.
>>
>> I'm not sure I see the problem?
> 
> Sorry.
> 
> The issue is that your patch series didn't make it into patchwork
> properly, I wonder what happened since you did send it to netdev.
> 
> Hmmm...

The guys at buildroot seem to have seen a number of their patches not
making it to patchwork, thread starts here:

http://buildroot-busybox.2317881.n4.nabble.com/patchwork-ozlabs-org-down-and-e-mails-not-recorded-td183918.html
-- 
Florian
