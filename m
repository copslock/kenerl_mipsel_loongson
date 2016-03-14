Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 15:37:26 +0100 (CET)
Received: from mail-io0-f173.google.com ([209.85.223.173]:34709 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013686AbcCNOhYtMkH0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2016 15:37:24 +0100
Received: by mail-io0-f173.google.com with SMTP id m184so224708435iof.1;
        Mon, 14 Mar 2016 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GKf+czCIGDzxeEBvyDgfRMBR8bMS1P6WhedA2g6Q3AA=;
        b=pLXUQohwcTqc0c6DNlj2Emgyym0agFdebC3wHDvUY63OFf1+UwaF9rkiVyI4xH4dxx
         /BnIBsKFLXCK4ykvVx629wCTmd+ohyMtfTx1ubzs+XSFa52pk2rhNHWMlA8r+DvldbgJ
         s/GJ8MI21nrPNR0JbcyP3IDfAi0lGmFBhwEubWeWzPaTo4XBeDNeyf5z3Wd1wsAWInqP
         LyM0qureTSNWJNJSuyEcQrUEGklvYL1Ts9g2iJJ3LXhrzo11MBpOql/7OlbDMrwKiaGN
         WhrfgtWz+Lg4N8d7TP5p3HcuN62AYL9yHRBrOwLnC8xR53H0Zw5q+zepdNAZQZv/NtW3
         baYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GKf+czCIGDzxeEBvyDgfRMBR8bMS1P6WhedA2g6Q3AA=;
        b=HDOttnZoy1rj+i8hbnw0MvAQZXI0myBJ01XTkwxN2dg9rcTk0TjBvwMzwIZezL6eLg
         S52la04SvPQawYqaLasKMev8jQgGhrbXzebCXAJVXdqGzzWS4DRgFSlUUJBEz127Iri7
         AmmtVKp7NDrlueRQkblGsQPMaQN47hbx8tYwPFV/IwD3VdRDIwjUYMo0OuMKfhu/3YCJ
         L6ily3XSHkSEd1S5ylWm8zAnO5bhDcdeG7FyrMmici/lWwI8t/hFOaqzDHq6YAmsrgq6
         lprHXQiRS/F2N6SBpJnzTnrT6OX+SOFAPseucM2+8nI3w8LWZ4SOZOPVqhtYvwKNTfmm
         1DZg==
X-Gm-Message-State: AD7BkJJZ8g0lFvcJjzCZv29ysQZLZOp3rCnPzCa9jUocJORn1F/xmTJg8krORoPoTmIoNUZJwevEUZTXgv9TUA==
MIME-Version: 1.0
X-Received: by 10.107.43.2 with SMTP id r2mr24415131ior.156.1457966238952;
 Mon, 14 Mar 2016 07:37:18 -0700 (PDT)
Received: by 10.107.159.142 with HTTP; Mon, 14 Mar 2016 07:37:18 -0700 (PDT)
In-Reply-To: <1457965305-3258441-1-git-send-email-arnd@arndb.de>
References: <1457965305-3258441-1-git-send-email-arnd@arndb.de>
Date:   Mon, 14 Mar 2016 15:37:18 +0100
Message-ID: <CACna6rwx4Lna-PXNaHFwqn8xWitN=5ReUsAGPsK75YC2SLpDNg@mail.gmail.com>
Subject: Re: [PATCH] Firmware: broadcom sprom: clarifiy SSB dependency
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul@pwsan.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 14 March 2016 at 15:21, Arnd Bergmann <arnd@arndb.de> wrote:
> The broadcom firmware drvier calls into the ssb SPROM code if that
> is enabled, but it fails if the SSB code is in a loadable module
> because the bcm47xx firmware is always built-in:
>
> drivers/firmware/built-in.o: In function `bcm47xx_sprom_register_fallbacks':
> bcm47xx_sprom.c:(.text+0x11c4): undefined reference to `ssb_arch_register_fallback_sprom'
>
> This adds a Kconfig dependency to ensure that we cannot turn on the
> generic sprom support if the ssb sprom is in a module.

Can you attach your config that triggered this build error? I modified
condition to the:
#if IS_BUILTIN(CONFIG_SSB) && IS_ENABLED(CONFIG_SSB_SPROM)
which I believe should be enough.

I'm afraid your patch won't allow compiling SPROM driver with BCMA=y
and SSB as a module.
