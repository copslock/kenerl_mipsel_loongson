Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 00:45:27 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:59198 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492145Ab0FBWpX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Jun 2010 00:45:23 +0200
Received: by bwz5 with SMTP id 5so564182bwz.36
        for <multiple recipients>; Wed, 02 Jun 2010 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZgipcGyPoipBa6Qm147izHbM17JLh/LNSOO/coYCuas=;
        b=qF7cNvqw6SThJYWStBOiam5ho+1Qa9z4p64l3fqq/TbzBZB7XLUBcJ98qRYyav51EM
         +YQS/qHEUeDVH542Vb0ASWSf8asMdcM3hl4SHRHm6FiKI0WniyY9M75MP7YKtlEkTOgi
         YNcPu5IpzEPxgHZ9gTKe72tqxFzVe/En4fRgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A9EtH66o7M9LIklBs2+7jgDvkpfvcTjrNPNpR3wSEkk13zXGnPC3+eg7zo3GKepUJL
         sfNZEbvU290XYPGJf1Po5Sl9QH1BNdywl6Uh3q2SlwRhd5ptUBXFuIHR5YDQj7UejzwA
         6qt6ArT0N6dXiIUvgZP6UDU4FX55iyj5Yy4Wc=
MIME-Version: 1.0
Received: by 10.204.3.65 with SMTP id 1mr2246221bkm.210.1275518722173; Wed, 02 
        Jun 2010 15:45:22 -0700 (PDT)
Received: by 10.204.72.197 with HTTP; Wed, 2 Jun 2010 15:45:22 -0700 (PDT)
In-Reply-To: <1275505397-16758-4-git-send-email-lars@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
        <1275505397-16758-4-git-send-email-lars@metafoo.de>
Date:   Thu, 3 Jun 2010 08:15:22 +0930
Message-ID: <AANLkTimVM637peyrPP7dZ3Uy2S-3DAEXspGi-FONcW6p@mail.gmail.com>
Subject: Re: [RFC][PATCH 03/26] MIPS: JZ4740: Add clock API support.
From:   Graham Gower <graham.gower@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1871

On 3 June 2010 04:32, Lars-Peter Clausen <lars@metafoo.de> wrote:

> +       {
> +               .name = "dma",
> +               .parent = &jz_clk_high_speed_peripheral.clk,
> +               .gate_bit = JZ_CLOCK_GATE_UART0,
> +               .ops = &jz_clk_simple_ops,
> +       },

Presumably this should be JZ_CLOCK_GATE_DMAC.

-Graham
