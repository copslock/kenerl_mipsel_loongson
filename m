Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jan 2014 11:54:57 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:50015 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378AbaAKKyzMMBRY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Jan 2014 11:54:55 +0100
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com [209.85.216.46])
        by mail.nanl.de (Postfix) with ESMTPSA id DF46C4609E;
        Sat, 11 Jan 2014 10:53:23 +0000 (UTC)
Received: by mail-qa0-f46.google.com with SMTP id ii20so1282395qab.33
        for <multiple recipients>; Sat, 11 Jan 2014 02:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=skyJ1pKYcrCuEIJ3y2dml4djFApJnvYfcqr4CJpEAEA=;
        b=echm9zvBUSrmgi7jNGYvLcbDJOwvasOAPKeL3aopdfbKTECsWtnDaVidtzKbivRexZ
         LB5mwWIgHgRf6yfefjkO1FSonrffUIY2+nl85ogOPgEiBFEHLgdIba7d6FMqMky7r7fZ
         awXxLtHj73u1C3d6s7cE8gyTIVUN0pbQ3BFfUAP5Y2KV3XVZVkldC9TkO4iSCeLjbrPg
         xnLWsuOcTjMPaW+RbjohPI2eNLrHvDCuxmub72oXBmULhFV4MyV01ZzfSgjZBST2jniY
         kcE7BGKpcbPQv4lngSsVp+9lfIA34rWGztMTsxvRMYJSf5UK9l/VJXikk44qXDqPggfm
         g/cQ==
X-Received: by 10.49.41.104 with SMTP id e8mr17573538qel.1.1389437690914; Sat,
 11 Jan 2014 02:54:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.27.117 with HTTP; Sat, 11 Jan 2014 02:54:30 -0800 (PST)
In-Reply-To: <52D120C8.8020102@openwrt.org>
References: <1389386114-31834-1-git-send-email-florian@openwrt.org>
 <1389386114-31834-4-git-send-email-florian@openwrt.org> <52D120C8.8020102@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 11 Jan 2014 11:54:30 +0100
Message-ID: <CAOiHx=mVoimAJ34-LWtK7UFJR=pDXMKZ4nLLKoRjZvdTcrq1vQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value
To:     John Crispin <blogic@openwrt.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Daniel G.C." <dgcbueu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Jan 11, 2014 at 11:45 AM, John Crispin <blogic@openwrt.org> wrote:
> On 10/01/14 21:35, Florian Fainelli wrote:
>>
>> Broadcom BCM63xx DSL SoCs have a L1-cache line size of 16 bytes (shift
>> value of 4) instead of the currently configured 32 bytes L1-cache line
>> size.
>>
>> Reported-by: Daniel Gonzalez<dgcbueu@gmail.com>
>> Signed-off-by: Florian Fainelli<florian@openwrt.org>
>> ---
>>   arch/mips/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 123f7c0..a3fec87 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -139,6 +139,7 @@ config BCM63XX
>>         select SWAP_IO_SPACE
>>         select ARCH_REQUIRE_GPIOLIB
>>         select HAVE_CLK
>> +       select MIPS_L1_CACHE_SHIFT_4
>>         help
>>          Support for BCM63XX based boards
>>
>
>
> Hi Florian,
>
> why is this not part of 1/3

Because 1/3 is a clean-up/refactoring patch, and this one is a fix
(note that BCM63XX did not appear in the default list for "4" in the
old code, so it defaulted to "5"). Mixing cleanup and fixes is just
bad style. ;)


Jonas
