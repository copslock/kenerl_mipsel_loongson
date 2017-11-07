Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 17:06:29 +0100 (CET)
Received: from mail-ot0-x234.google.com ([IPv6:2607:f8b0:4003:c0f::234]:52091
        "EHLO mail-ot0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKGQGSchK2y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 17:06:18 +0100
Received: by mail-ot0-x234.google.com with SMTP id n74so12435631ota.8;
        Tue, 07 Nov 2017 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZTqFtMVJ5un9arfMyhtWlwSpCGlk8TucJ1SVVbZY6TY=;
        b=amIOV1n69qY0zYooeL2cxpCKFpv8qMgGkGkk6gVogFgE6/Mt2yHy2NR0V11bQGMI7M
         wKcAzu1LH/di80jOCh81+qyNgU9pCXv9ueiK1aFmwDsQsYbCIh9l9dzpLzLb6XSkd4oh
         SzcNbsGyCLyW52Q/A3L5CQzST8F9SuzHP6CZ9ECHNTjoC7nF3xyMW2cTjp/A/MYYiJk/
         mEVyZCKoRBQf9CMUV09MFtJLiuxXKS+k6z23YkH/S8FFT03bdngWdKVBuXCfk4cREFw8
         GVG+JGWoYAlEVTt9mIqJdpCpGUdQhDZL5/A0QOIefGOu5lGOdyasj6ZJ/mvCPbmdn5rc
         bBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZTqFtMVJ5un9arfMyhtWlwSpCGlk8TucJ1SVVbZY6TY=;
        b=az5GXvt1fjy/175i2KOJlge24mHATfG7GlZ9ckQ08Fi7a0g2d6a01C9zTuQUKhpC8H
         Y5izDrVWsdDQNodqC8UlAbQYEoH0MeaIXdaHBAWw/KbbyHq2MEUfNpYe+nhM3hEtyqXs
         necihM3VSC8OZ3CkcMBMeMz6WwAlJFy6XiHGqHhNr8+/RO1yARt3QNBE09psGTxtA9jT
         5SbSlypBGVgbmD/+hnCsPlFZc9nUZEeWCi0jGuMcwcn50YJaY16ltXCpapfiVi6bLaUU
         XbfxX/NizrSXGLfGj32SSNAogPhBGr/Mcv++jQzsLz+UYNQOIWqIJBGfhPAnQawti8YG
         rqZw==
X-Gm-Message-State: AJaThX54TsOIRG96XPGoKyrP8R1p0XfoUKBcTIvmsnlMc15VHbEvUqvo
        YlSGhI12fY1cgtf1MB8zRSJV0g2DOYRrm+/OEfU92A==
X-Google-Smtp-Source: ABhQp+QObDWEGfeQiaGy+EGjBeSdWqWX06DO1W3BfysMrWBWPD7KNE1dS4lwNdFL89VDciGZs81L/40CPk7lmpNQsSs=
X-Received: by 10.157.9.42 with SMTP id 39mr5366085otp.276.1510070772027; Tue,
 07 Nov 2017 08:06:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.28.152 with HTTP; Tue, 7 Nov 2017 08:06:11 -0800 (PST)
In-Reply-To: <CACRpkdZLggJA_qcRSJv4tndHDU4SG6HhP1U8uJpiKn=gBpAneA@mail.gmail.com>
References: <5a0159b6.08bc500a.ebe4b.25c6@mx.google.com> <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
 <CACRpkdZLggJA_qcRSJv4tndHDU4SG6HhP1U8uJpiKn=gBpAneA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Nov 2017 17:06:11 +0100
X-Google-Sender-Auth: 2IdD1lKEOSxDXXqeuRNAY_0YbWs
Message-ID: <CAK8P3a2ROugscy=WzxsND+fN-g+MX2znXdxLXxG06bH1uST93A@mail.gmail.com>
Subject: Re: next/master build: 214 builds: 26 failed, 188 passed, 28 errors,
 6333 warnings (next-20171107)
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60743
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

On Tue, Nov 7, 2017 at 4:21 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Nov 7, 2017 at 1:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>>> 2 arch/arm/mach-footbridge/dc21285.c:145:2: error: expected ';' before 'else'
>>
>> A harmless rework that Linus Walleij did apparently uncovered an
>> ancient bug. I'm
>> waiting for Linus to suggest a fix.
>
> In footbridge? Oh my. I just sent a fix for an ancient bug in the
> mach-sa1100 simpad.c
> boardfile. Isn't that what you're referring to?
>
> (I intended to CC you but git send-email doesn't pick up Reported-by..
> I'll forward.)

My mistake, I confused the two output lines. This one is one that I
already fixed,
it came from Kees' timer conversion.

      Arnd
