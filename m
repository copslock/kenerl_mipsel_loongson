Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 14:50:18 +0100 (CET)
Received: from mail-oi0-x22f.google.com ([IPv6:2607:f8b0:4003:c06::22f]:33144
        "EHLO mail-oi0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdB1NuKBX-Bs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 14:50:10 +0100
Received: by mail-oi0-x22f.google.com with SMTP id 2so5951450oif.0;
        Tue, 28 Feb 2017 05:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fgEEo5826a4Fu8QcKoGvMPwhLUHDO5YJ/0rSMXGjJzY=;
        b=QPCraCOLtC9Jf5SuqUDzY5cyUqMcP4XAVFOlS5sKbPBEzG4y0cpoYa6KFX42f31Qgg
         5KYSeo4kym5w3OeCn9S/vIurGjvnl+a+I132AivixEFpiqQ/IyaIDM0ZPFktttf8vyPR
         aTynIvg6aV2Zg5VPV7IkGvcJdsxiJpM7sGAQ3N2dQRXyVFku+310SBH/Wd936XdXhmkR
         ZkQqSAbMpRvk8NaIZEO3Vpp8WI4DK0qVmL14EHEeMfBOsTwT5GfICUZe6fEzMwb8/7ts
         jZpb/pT0mkgZpbgQLGCZKVxJcaB5Y/4175zNA6jeypCkpVVM9JzCf+qYHDbmfuzyV+kC
         gxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fgEEo5826a4Fu8QcKoGvMPwhLUHDO5YJ/0rSMXGjJzY=;
        b=aECliGTOGQHd2cW5kYkSUzIiG4LFsvfRppbUP2KiR0hjyBTUZxMfOptafEw/qz1zHN
         7Dz5MCvKXaPjDUZWObUL7a1ILd3Ta4DIW6XafMo8nGUUFBJ1fBZROV4mcRMg5K1dufAg
         DNq8/8Gd9amdTfntp5DaSq2e/5pPDYXrRKHKV1LnctMJh1hJLIXUHmCtPh8q2H/2B+mI
         NMTw3KjTSPV/017ZkZw4UY04ppiO4N+xFMMdQqSKha7lFEkFNG/mwj2BREXNL2WsAaks
         ZlQPs1lxZZNuSpHKOptVvoSVZdcA043Zejp6/4Vakgx6OdLbl0RkXlKX206iLgFKrIo4
         slJw==
X-Gm-Message-State: AMke39kc6enIEcZtAQUoaS6Et6AHaU2UJqkpeYv+7raKBvp3TDcRMYIWvEjzkD/pBRshvJfknG1RwsRrx3tLYg==
X-Received: by 10.202.199.68 with SMTP id x65mr1132930oif.113.1488289803968;
 Tue, 28 Feb 2017 05:50:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Tue, 28 Feb 2017 05:50:03 -0800 (PST)
In-Reply-To: <58b2dd95.18532e0a.7645f.aec1@mx.google.com>
References: <58b2dd95.18532e0a.7645f.aec1@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Feb 2017 14:50:03 +0100
X-Google-Sender-Auth: aIfb9W1CYCC8RB9fQr7XVK6hG9g
Message-ID: <CAK8P3a2nhoxgCT3467=+CLe9zeWqJa1oKFtcPoCut-1z5jacqw@mail.gmail.com>
Subject: Re: stable build: 203 builds: 3 failed, 200 passed, 5 errors, 28
 warnings (v4.9.13)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     kernel-build-reports@lists.linaro.org,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56919
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

On Sun, Feb 26, 2017 at 2:52 PM, kernelci.org bot <bot@kernelci.org> wrote:
>
> stable build: 203 builds: 3 failed, 200 passed, 5 errors, 28 warnings (v4.9.13)

Only one warning that doesn't also show up in v4.10-stable

> bcm63xx_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1130:3: warning: 'phydev' may be used uninitialized in this function [-Wmaybe-uninitialized]

df384d435a5c ("bcm63xx_enet: avoid uninitialized variable warning")

     Arnd
