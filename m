Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 18:48:17 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:50741
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992381AbdJRQsKeT2PB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 18:48:10 +0200
Received: by mail-wr0-x244.google.com with SMTP id q42so5712275wrb.7;
        Wed, 18 Oct 2017 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNXB+XXuhEvz4YIscBzCGcRsAKxFYNAKv2lpcxlyRdo=;
        b=H72ijs7yqWwx/Rn6piq4K7bQdIl4/vXWx1GnsIt8FX6CgiqdsIOq/5QvEpS0Rd9/61
         2mpJgBI1j9BCABeCeth6UAzEmDZnnr29cS7acJtGYMuJQgnAnWHZYhczZ7ATyIlNpLaS
         nuNiSjKuR6wJJ4bMEU7ahOxbXoOCbe/QFfimZkr73C7HOibz/heFsp/RioVnvPZSiX9M
         S8aK/liK7P6YsT5ijuKmbTE7nqjF3GQ88lFiQf73eQsEzkeQQItN53/BfjSOq6P8oFTK
         XkitIVslsrSaCT70FRjZDdc8HKV/eFNmuT4JOIKCdCJENgLHawMFPkuv69V4hSXwpZrR
         OgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNXB+XXuhEvz4YIscBzCGcRsAKxFYNAKv2lpcxlyRdo=;
        b=E73O0PJNMRoDsfwfs2OrEdNtuJt6abZ/kRl6KK4k9UNe/fHciM4Z4YRflhkU4vsE5J
         o16OJv8MLYgqaMp7VQubLFCRyeewG8ruy5iFONHauc1deCiQMW11595ckPGCuu5jefWU
         4V/CwngpmUu2E9QsJsLD6MystrkDRI3ITKWbi5x0ZdkR2sOOERR8xaQSTIpOQdpjvFkq
         1TNd9cccj99fV/evFd0QJbz8DzTlHoBlQQeKtLEmy3DNq6Rm0iZha4LdQzoER/XfuYfR
         Yv9rtRZG8mqKubX4iyeeN3ZsETPu8cLgZl7ch+MLU+bgayCclUBTU0xAnoheekGE6yfZ
         2Ozw==
X-Gm-Message-State: AMCzsaUripJ6VvNDoFr7Ka4+V12Ok4M7IM2w4YvFqo6KpI0/CPukITTE
        rBJm1X3KXD7y90/ipjNuOAg=
X-Google-Smtp-Source: ABhQp+Tm6TC8nvCKfbFsb+nb7Sxy0SZjSRwaVBGhGQmSXJ7ODf6/bjwLkE3cY/Bas10/Mooy+FInNQ==
X-Received: by 10.223.188.133 with SMTP id g5mr6704801wrh.204.1508345285063;
        Wed, 18 Oct 2017 09:48:05 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id g18sm455317wrb.48.2017.10.18.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Oct 2017 09:48:03 -0700 (PDT)
Subject: Re: [PATCH 1/9] SOC: brcmstb: add memory API
To:     Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
 <20171017082413.GA10574@infradead.org>
 <abdb1e9d-f8c9-8066-48c5-37b4e2474952@gmail.com>
 <20171018064649.GA7734@infradead.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <eebffba7-6fd7-5b34-577b-a6a42b94563b@gmail.com>
Date:   Wed, 18 Oct 2017 09:47:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171018064649.GA7734@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60445
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

On 10/17/2017 11:46 PM, Christoph Hellwig wrote:
> On Tue, Oct 17, 2017 at 09:12:22AM -0700, Florian Fainelli wrote:
>>> Please move this into the arm arch code.
>>
>> No, this needs to work on both ARM and ARM64, hence the reason why this
>> is in a reasonably architecture neutral place.
> 
> So there is no other shared code between the ARM and ARM64 ports for
> this SOC?

The biuctrl.c file is also shared, and there are pending changes for
v4.15-rc1 that also bring more shared files to this directory.

> 
>>>> +EXPORT_SYMBOL(brcmstb_memory_phys_addr_to_memc);
>>>
>>>> +EXPORT_SYMBOL(brcmstb_memory_memc_size);
>>>
>>> Why is this exported?
>>
>> Because the PCIE RC driver can be built as a module.
> 
> Hmm, supporting PCIE RC as module sounds odd, but it seems like there
> are a few others like that.  At least make it EXPORT_SYMBOL_GPL() then
> to document the internal nature.

Fair enough. Thanks
-- 
-- 
Florian
