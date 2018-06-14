Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2018 11:33:40 +0200 (CEST)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:41432
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993016AbeFNJddbsFXi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2018 11:33:33 +0200
Received: by mail-lf0-x243.google.com with SMTP id d24-v6so8349873lfa.8
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2018 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v2V26h1+TlBelp24NjgInjkPcqhakOECsBnVpct2PkA=;
        b=lONg7tV8jsNROKy/2C8o0JUvNhuRgddtY3E1e8iAvRb/08ktloOD6LFelA2FHU3yva
         ZpAAQHCT9OtpDcCqFVlI1gZzN+GQRovCebH5/VIM7d9XPdep4PvOL7m5Mc6m/Pl8VECK
         6XAWyer5tpB54ZpTThrDIKHT9k7dc5ZQGkzIHaTA/zk98g7Nj1cdp1ciGOgY5JRrSsJE
         9ycjweG/YdUiyaC7jChKMyWaFE/CD4gdmSYl9w29FkHOfZNeL8SI9y8C7AlR2HJ11kLX
         /XWsDcMV0Dq7Hep8V4TVpaz5bYDpaLNh8zqBANPTtVjN4xrPLuSRE+LCXbA2WhsyN9Rq
         cuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2V26h1+TlBelp24NjgInjkPcqhakOECsBnVpct2PkA=;
        b=b78vpU9FrT/gEGRPsoP3wPOShkjILRBPGo/EBHdaLl7pNt/SgKiKeG2ujlDgPaBTIH
         zwD4AxLTgg+Cpt68CxZ26jhAiNhnutDVdxCo9h/itRtn6aEypDxv9PQH9eQnociRSi01
         on/LfpWc0tNHL/3wctidxii5tLEcFuffE641mwZ9Z2JPCymwYtEzn72VHQVgOEiPAzkF
         VVdeZDNGntgIm80PWUCSrrgh2YwSnvsmzsPda0QZHMLwqsz2ElCumdMhSfRi5huS3FJm
         /ABSBfqTYE+w1J6QVMPKH1Fg3lCDPdFT9wdQ1SKDwZNvMUp2DlPKaKFnGtF3i//VgoRt
         c5cw==
X-Gm-Message-State: APt69E3qX/Q5apG0BALSfwygGcBDOrePfid6+clTVNnLGNUWUdGfGy5D
        uYy+Xqme2M6GtzCD5pPxHrjpnKGy
X-Google-Smtp-Source: ADUXVKK/gL+puz8Hx2oxjEwGdp9v1EyOcJUJqiZUb6w3nLS7D4Sey4YrWduagxahNfzQ+yikfSMAYA==
X-Received: by 2002:a2e:1155:: with SMTP id f82-v6mr1181396lje.75.1528968807551;
        Thu, 14 Jun 2018 02:33:27 -0700 (PDT)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id a195-v6sm997889lfe.44.2018.06.14.02.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 02:33:26 -0700 (PDT)
Subject: Re: [vmlinuz.bin] Does u-boot support loading vmlinuz[.bin]?
To:     Paul Burton <paul.burton@mips.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, linux-mips@linux-mips.org
References: <90a06531-2663-3982-962d-ff8025ee4388@gmail.com>
 <20180613153510.GB31768@makrotopia.org>
 <2cfa098d-46f4-b4b2-10f9-e447b89c7fda@gmail.com>
 <20180613214811.zvuyf5e6hajutv6j@pburton-laptop>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <d16e3b7f-1cd7-5bd6-a8f3-234d25a9ab65@gmail.com>
Date:   Thu, 14 Jun 2018 12:33:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613214811.zvuyf5e6hajutv6j@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crashing.kernel@gmail.com
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

Hi, Paul,

On 06/14/2018 12:48 AM, Paul Burton wrote:
> Hi Yuri,
> 
> On Wed, Jun 13, 2018 at 07:28:43PM +0300, Yuri Frolov wrote:
>> On 06/13/2018 06:35 PM, Daniel Golle wrote:
>>> On Wed, Jun 13, 2018 at 02:19:06PM +0300, Yuri Frolov wrote:
>>>> do I understand correctly, that the native format for mips arch.
>>>> u-boot uses is uImage?
> 
> Easy options are to use the legacy uImage or FIT as Daniel mentioned.

so it was my suggestion to the engineer who reached me and asked to provide support
for vmlinuz.bin boot in u-boot for p5600-based development board.
Basically, my recomendation was to change somehow the type of kernel built in their
machine-specific yocto *.conf; afaik, yocto/bitbake allows to do that.
Hopefully, KERNEL_IMAGETYPE variable will work for them.

> 
> As an example, when running U-Boot the older MIPS Malta platform
> generally uses a legacy uImage whilst the newer MIPS Boston platform
> uses a FIT (.itb) image.
> 
>>>> Yocto's default for mips is vmlinuz.bin for some reason, here is
>>>> the question.
> 
> Please note that, at least when targeting MIPS, vmlinuz.bin is not a
> zImage - those are 2 different things. If you build vmlinuz.bin for MIPS
> then what you get is a flat binary containing some decompression code
> and a compressed version of vmlinux.bin.

Yeah, I've got this surfing linux build scripts and 'decompression' directory.

> The file has no special header as it appears the ARM zImage format does.

Good to know, thank you. I've tried to find mips-specific header structure
in attempt to set things up as "in arm world", but failed.
So, there is no such header, ok.

> 
>>> You got to enable U-Boot's CONFIG_CMD_BOOTZ and use the bootz command
>>> in order to boot that. Or change that default to generate FIT or legacy
>>> uImage instead.
>>>
>>
>> bootz_setup is properly defined only for arm (arch/arm/lib/zimage.c);
>> default bootz_setup returns an error.
>>
>> So, is bootz supposed to work for architectures other than arm?
> 
> So far as I can see it isn't - it's ARM specific.

Ok, thanks.

Thank you very much,
Yuri
