Return-Path: <SRS0=EetP=VH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47144C74A21
	for <linux-mips@archiver.kernel.org>; Wed, 10 Jul 2019 15:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CA22087F
	for <linux-mips@archiver.kernel.org>; Wed, 10 Jul 2019 15:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY67Qqzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfGJPo4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:44:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38852 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfGJPo4 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 10 Jul 2019 11:44:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so2772926wmj.3
        for <linux-mips@vger.kernel.org>; Wed, 10 Jul 2019 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtOOR2nEu//DGOMUejq+6mfdm7EgmWFyTPqFW/hZNEg=;
        b=DY67Qqzg8l5sGMLitlWOUm/qzQ2NhqQ9Db12bmwsYd4wnB6rushO8O/ab2p8CxPx0A
         1WsSAHX8Z84rQ/xQUHoU5CmUje5IAYvZH0mYD1OhVkH3AeegsnCBhCoeCACxKoyZxe5H
         9S7xCeV+scTCi+NWNYdfV6JzV/ALBwtiFqdGKbxIkeguyVuk/obU+WoexQo4hGkjO6+6
         0Fr1hgGDjgjCLdlv+LcmtrtSGqrW9oQfc3X48T193n2XMAqFhMRVRETjEynSPHk/tvxT
         aMv2O4k4gFAhmL/ivOMGxt1DGbmppZeL0jGqtM2tnK9tLwU4MpDB8m1LL1YSAbWx5231
         EnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtOOR2nEu//DGOMUejq+6mfdm7EgmWFyTPqFW/hZNEg=;
        b=j8Xq9DCWwjqbDZbV36RL/sv5bCw6oCdoKz55zm3X4xUbaQSsrXgHuuhRu2fxU3BSZi
         iS6svmLDcyXNaYGPfuZk8FcTe7Kz1Sj0z/GhGaR4lw2iaPlyFp1+66gUjdjx8fI0r7DC
         aQAlpdYs/u/WhLfIROMJRffZHWvU+XLkw5fQ4Xjz4qAArOFQx6HIZPQWZTTgXOx+F/xX
         RjpJQt/FxtmW1KDK8BR+K85v0Un0qEidolwxvBP6FQBvRWchFQ8v71eTO/+Y0oGghza9
         RLJl3MrcVC57nOnISDvmuLko88dKvt4hhbhBRDVk9WX0MEkyfghKXpJufsidvUsrUCKr
         he6A==
X-Gm-Message-State: APjAAAW1a8Bcsv3kg1I4pZy+klEYATJXYEBsAWgK1ZW+IaaLesvx0qNQ
        Vlz6O3tLM1acAjgYfP4eA4m7GYFQWkHW9K851FXtRg==
X-Google-Smtp-Source: APXvYqxWuFYdRc3oezY5CyAazr9+mnSggdhSKTQQUlfs/r4ufXqeKNR1JiskvJeNZu0AbFrkKC6ypVSymVpP5xMNcCk=
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr5991172wmg.152.1562773494692;
 Wed, 10 Jul 2019 08:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190621095252.32307-11-vincenzo.frascino@arm.com> <20190710140119.23417-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190710140119.23417-1-vincenzo.frascino@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 10 Jul 2019 08:44:43 -0700
Message-ID: <CALAqxLVnf_hyxxmx72F360PbJUTZowuD3wJx0nJ=dCTyW+w-Tw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: vdso: Fix ABI regression in compat vdso
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Jul 10, 2019 at 7:01 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Prior to the introduction of Unified vDSO support and compat layer for
> vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
> In the current implementation, AT_SYSINFO_EHDR is defined even if the
> compat vdso layer is not built and this causes a regression in the
> expected behavior of the ABI.
>
> Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
> tasks is defined only when CONFIG_COMPAT_VDSO is enabled.
>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This seems to solve it for me!
Thanks so much for the quick turnaround on a fix. I really appreciate it!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
