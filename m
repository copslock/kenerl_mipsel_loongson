Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2018 10:46:31 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:42054
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992956AbeCOJqYpFe1e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2018 10:46:24 +0100
Received: by mail-io0-x243.google.com with SMTP id u84so7821677iod.9
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2018 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NLT5vfZE6cx64m4TZyjCq+24lPRkCZ2g154DVsO9wh8=;
        b=MQJzoOiZvfVliHQ5uk5/GwGrRJcuXlTVL3Cjy7qgrCLuYDKWa31H+enxKJ1Kax/2NP
         h4OC/TNGCvPnLpAs6H4iumMXQCPRDmgNja5kcIcvDwEdUpORSH8g6nvVM9Jf7lM7D+oJ
         73fzNGK6c4pXK6O6GWFIZBg1FDP+LgAqrMbNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NLT5vfZE6cx64m4TZyjCq+24lPRkCZ2g154DVsO9wh8=;
        b=QBPdfbWVCBVVcLLXqzMlhRvozTAIpEHeCthuSwpuQ6qAJIpKoL0CDIpABrFiaNNbF+
         7x09MoUWnB3JU7dEVdamLDCnQVYc21QZNDwiJ7R2yBoS/NKcnzuzLfDc/gIhgECyorfX
         1bbFPrgqZ53N+Oqxrej3fCCk1F2wNhVXLoF60Nn2OGkj3TIJD4YU1DNje3T/dWHnHSdE
         hXVb18L28Z+zfs4ngNzei6PnWXsS4GivnYH87NTKB95F6YWVnjo5HpB15pZ534aTzlua
         C/bGgOxejl8ocXem9Kc/jwhTBbI0GDK9I41NPVX77xjHuymq1KrQE8149P5uTGI6TXDc
         bI/Q==
X-Gm-Message-State: AElRT7GlKq1RT+AEVCskucS0a1cVmSUjao/I8TsGHvy9SJH9/gtQm1T1
        ljpuF12BDgxglSmFbbWlUW7IZO2D/QJHqv24JThH0g==
X-Google-Smtp-Source: AG47ELuhzRUsu7JJmKW+Pbfyo6tm7+JfydYZil8r1s0sIf2EAXkuXXTzu+VKOhi7TkymsVskh5QLErcUUokaiWe5mFg=
X-Received: by 10.107.132.197 with SMTP id o66mr8086067ioi.119.1521107178456;
 Thu, 15 Mar 2018 02:46:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.101.23 with HTTP; Thu, 15 Mar 2018 02:46:18 -0700 (PDT)
In-Reply-To: <20180312223139.GE21642@saruman>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
 <20180312215554.20770-12-ezequiel@vanguardiasur.com.ar> <20180312223139.GE21642@saruman>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Mar 2018 10:46:18 +0100
Message-ID: <CAPDyKFq2z+f4Zdi8skVb7swGDdspoLqf4LN7u6wh0kCGG2EQ9Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] MIPS: dts: jz4780: Add DMA controller node to
 the devicetree
To:     James Hogan <jhogan@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mips@linux-mips.org,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 12 March 2018 at 23:31, James Hogan <jhogan@kernel.org> wrote:
> On Mon, Mar 12, 2018 at 06:55:51PM -0300, Ezequiel Garcia wrote:
>> From: Ezequiel Garcia <ezequiel@collabora.co.uk>
>>
>> Add the devicetree node to support the DMA controller found
>> in JZ480 SoCs.
>>
>> Tested-by: Mathieu Malaterre <malat@debian.org>
>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
>
> Acked-by: James Hogan <jhogan@kernel.org>
>
> Since the majority of the changes seem to be in drivers/mmc/, I'll
> assume unless told otherwise that the MIPS patches should go via the MMC
> tree with the others.

That's okay by me. I see that you have acked all MIPS changes now, so
I will queued them up via my mmc tree - when the rest have settled and
been reviewed.

Kind regards
Uffe
