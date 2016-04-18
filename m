Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 23:23:19 +0200 (CEST)
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34685 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026949AbcDRVXQ5O50i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 23:23:16 +0200
Received: by mail-pf0-f182.google.com with SMTP id c20so84551515pfc.1
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2016 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=st0YYVAuKBmcPfIwhS8rwMLj2AEuT/b7z2Jsli/bp3E=;
        b=Bf8Q/V9Pm4oJs+yyJ5dRp+pmFnl61bCMmW+WonZpk0B/UhBKSXBRZwsJT6FVmDuI5p
         rEUxhHgTqiRv4KYpXrk+BNv4375Cy+ZAlX5E7SRQ8AZRTWweJ3c3sNj4WI5zMkL1p18V
         dhpvrHN+JFwjt1jnvnxhSA1GHdrpI4e6pahPJGo4uxm4hf+nVxvJwiYibIefENfk5JcQ
         MPTA2orZ/HgIR0gGLm4+5L3YjcqkrRgpYTaMWe/iDgNwPhhtzHoGVhSg7Wc7ksJ/KZaE
         oQe57hciBSG0bFiDMZbshzPGMtfYguR5oBLqoSRTCnID84GaP6RvNoBGXbNcSOyD27+4
         Vx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=st0YYVAuKBmcPfIwhS8rwMLj2AEuT/b7z2Jsli/bp3E=;
        b=Mvhkf8qn650px3AjKWcze28hygC4d2TqmGrQgO55+0TvjZlog18nO6iGdwn7wB/YPL
         qy0cs+7TzfHs8wY5CGdMcfln3J9d+43o4/+LJBFko7gyrcz8ilWrqjh28fk1v706KeTi
         7ez39t2YToTkFpZ7ZEpadY+EjLMY3DnO1VCOF3Ks5gpjyDAZw+rUob3Y4W6es2PP+Jit
         vODhaXbHlxToIIWihW85aYhCriHEGqyNH9Alm54PAj7UCDJTe69bphKXuor3+puaBAND
         OySH5NJPFD6TpJhKPXDCMKkwZSctiSfKVb0SrCOWfIkwHkztcE9iM/A2bPPB9mETncHJ
         YXnA==
X-Gm-Message-State: AOPr4FUWVxXcL6SKaC/NIUehbsaNVjjwI/dQKTo6mIkcK4p7VKPePMbxxPNejLAho5AqCA==
X-Received: by 10.98.84.2 with SMTP id i2mr1094959pfb.156.1461014590721;
        Mon, 18 Apr 2016 14:23:10 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id ud5sm86072339pac.11.2016.04.18.14.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 14:23:09 -0700 (PDT)
Subject: Re: [PATCH v2] bus: brcmstb_gisb: Rework dependencies
To:     linux-arm-kernel@lists.infradead.org
References: <1460839575-16869-1-git-send-email-f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@arm.linux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57154FBD.9080903@gmail.com>
Date:   Mon, 18 Apr 2016 14:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1460839575-16869-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53071
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

On 16/04/16 13:46, Florian Fainelli wrote:
> Do not have the machine Kconfig entry point need to select
> BRCMSTB_GISB_ARB, instead, just let it be default ARCH_BRCMSTB which is
> a better way to deal with this. While at it, also make it default
> BMIPS_GENERIC so the legacy MIPS-based STB platforms can benefit from
> the same thing.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to drivers/next
-- 
Florian
