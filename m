Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 21:55:38 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:36032
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdKSUzcO4KBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 21:55:32 +0100
Received: by mail-oi0-x242.google.com with SMTP id n16so4962520oig.3;
        Sun, 19 Nov 2017 12:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kvd//8kDGngJsnfPXx9Vfu0J2k2o2dFzMx8JrHF5hvU=;
        b=WuXIxGKBL2clYWLCCxL9IRUH2GsdUqUazGmsnuvuTf9LhZ0XJ3ltMGwVxjG07Wknzz
         PhUXfJXpGsk1c/9xh0nRNguBa7QmwvqDRBmyBH/CdiUn5cxnCPgcuEF10IH/SXxOd3U8
         4jCPDX+tSiNYetOF3TYvsyEQjXPU4cTdcYS3Gnv5XPQkhA1ulM++S7bwG4xQ2ywWpLqD
         9QcDo6UTnOzEgcODDCUHmNKZSy4h10VDBWIWDBQ7eK9xH5JN19TEDwLmr6x79nQ53/wA
         m7MT9U22Ech9JQIq0qxVaGxHAkKHGOyVqbOH9JQ/80Fz+feRlsbV07oX3f/0CfNjn0RF
         8d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kvd//8kDGngJsnfPXx9Vfu0J2k2o2dFzMx8JrHF5hvU=;
        b=Klk7i1qN9p8qDj2k8jitIqGRsVJDIj0gAmSMuoe/tqMmueCenHrw18jmfMmm3126Ke
         lIH7pQKlUfQ7hqhLkQCv6ap6IlfK1Mfxfs4MwWxl3m/Z87vLjEsbmx48Ieuf9uNQeu+Y
         vIDVTDB6EFB/RaqpnVa8YmuZd42fObT+/fwbSc9XEhKlYPxi/9nrpDIW2iYl6PFk/1o/
         jmo088t+jNlM17R5isC9U6zAnm++Rh0UOkzVWO3aaszzkImOorPASaXAzqCFRy/RiDY0
         JWaeuHej9FEjqjdXJBbDLatVekvA/7hkvfmftwQ6jBAq3oBzmJwKqxzwVK3SBbq3JLCN
         QF9Q==
X-Gm-Message-State: AJaThX5igBC+GfSnR5iOEwjktfFi2o3zixr5YD6EPV0oCgUWnuVqC8mA
        woRKXbgj0CMUv/aaUU5cUnR4zi+RwbEcQICJsjs=
X-Google-Smtp-Source: AGs4zMZdAJ9+0VWEZPq8T36vLE5r9Ka9sLPqJKD4R5AFk7z2u7c/JcG2X/2L4tJ3bPZD93DThnM0kx7aEyEBhoz0pyY=
X-Received: by 10.202.62.198 with SMTP id l189mr6001462oia.281.1511124925876;
 Sun, 19 Nov 2017 12:55:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Sun, 19 Nov 2017 12:55:25 -0800 (PST)
In-Reply-To: <CAK8P3a2QcYoFHFrR+DPFs1Oo6Li1NO=VMxoAyoh=yWF24j4YMg@mail.gmail.com>
References: <5a11b2d4.17f71c0a.5dc3f.fef5@mx.google.com> <CAK8P3a2QcYoFHFrR+DPFs1Oo6Li1NO=VMxoAyoh=yWF24j4YMg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 19 Nov 2017 21:55:25 +0100
X-Google-Sender-Auth: k_c3zq8R0kKBgCkqBkD3MVisz0k
Message-ID: <CAK8P3a1TCQR1gDRL_Ns5tTJyj8x_NJupM74i8rKpUZ0hRa1mcQ@mail.gmail.com>
Subject: Fwd: stable-rc/linux-4.4.y build: 182 builds: 60 failed, 122 passed,
 60 errors, 60 warnings (v4.4.99-60-g803704b287d8)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

[Adding the others to cc]

---------- Forwarded message ----------
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, Nov 19, 2017 at 9:53 PM
Subject: Re: stable-rc/linux-4.4.y build: 182 builds: 60 failed, 122
passed, 60 errors, 60 warnings (v4.4.99-60-g803704b287d8)
To: "kernelci.org bot" <bot@kernelci.org>, gregkh <gregkh@linuxfoundation.org>
Cc: Tom Gall <tom.gall@linaro.org>, Sumit Semwal
<sumit.semwal@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, Arnd
Bergmann <arnd.bergmann@linaro.org>, Anmar Oueja
<anmar.oueja@linaro.org>


On Sun, Nov 19, 2017 at 5:35 PM, kernelci.org bot <bot@kernelci.org> wrote:
> stable-rc/linux-4.4.y build: 182 builds: 60 failed, 122 passed, 60 errors, 60 warnings (v4.4.99-60-g803704b287d8)
>
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.99-60-g803704b287d8/
>
> Tree: stable-rc
> Branch: linux-4.4.y
> Git Describe: v4.4.99-60-g803704b287d8
> Git Commit: 803704b287d89efcd70fade9e650176282a1d766
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Built: 4 unique architectures
>
> Build Failures Detected:
>
> mips:    gcc version 6.3.0 (GCC)
>
>     allnoconfig: FAIL
>     ar7_defconfig: FAIL
>     ath79_defconfig: FAIL
>     bcm47xx_defconfig: FAIL
> ...
>
> Errors summary:
>
>      60  arch/mips/kernel/setup.c:439:8: error: implicit declaration of function 'PHYS_PFN' [-Werror=implicit-function-declaration]

All mips builds failed with this error, apparently caused by the
backport of d9b5b658210f2 ("MIPS: init: Ensure bootmem does not
corrupt reserved memory").

        Arnd
