Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2017 18:18:07 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:33235
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993418AbdDUQSBVmpfs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2017 18:18:01 +0200
Received: by mail-oi0-x243.google.com with SMTP id a189so21803698oib.0
        for <linux-mips@linux-mips.org>; Fri, 21 Apr 2017 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y8tkexsmeXSKW0z7Vx+/J9K8K8YanlWfpC7EEVsNVXg=;
        b=TKaPqkgkR3xvowrP7iC3o4dYuEOYzHhm8G+ID4EYJDEBvKxvlYkSicx3iriFDVYEMw
         fTET8TcJGdpla4ownFoM17hwHnpCrwYg9g5MHa2apSuCTJQovgt46uT2fFyAmHdrzlKs
         U75rxMQw4dazUrN9bl6PPZU4NRF4CaT5oAGeEqdpQL7DFtbuagHRQsyUpwJdz94BLfMu
         jh23gWR2OeMqEC58hPfjRLj5XU4e6gG45CclsCojEdS3Dea5ZJ7b/ZZj5jwBNnQYIpwi
         CRgItS74OF6+PbYPNNWQmDmhTQRpdH6ueN7FAbpzqrsmZsvjgGLUuWjkJ42X7sYYFjzB
         nSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Y8tkexsmeXSKW0z7Vx+/J9K8K8YanlWfpC7EEVsNVXg=;
        b=NnFCJ0OJ1mQE1yWOihW6XtK7+nagibwK+9H2FGAABt2wVrnLyxlHUReVSVvoXr8rDE
         BdwBuKbbIVBx3LGJrAOaalSWe3VipE94pOLePNepbDOpwD5plOCQJw6CVtdM/uCkf+hR
         bxPM1kYQyV7WNwB6SfLGj5gEtTbyogmyS8cCD2wLaCwv20BKkKhygUGZnQdq5Rrr9WQt
         8PqxdC6L00sAth9os6iW4gyShRmiI+YqYipAlcYhGQY8Km6XSCicNqGGsXxm4Oti3UV/
         XUwaN7UEsag8h8xfL79c+2FsltzMy8T0j/nPwXN3pVhp1M0R49enrDrzp/SDZeERCtOI
         XA9A==
X-Gm-Message-State: AN3rC/6+wJDqQ5EyYt1fucP4c7WmLu4yAZ+IRcvGCk1J2nbOgXfQJ9xQ
        W1Jmq208V4JKCKZDMi4ZdZsl2X1yFQ==
X-Received: by 10.157.0.39 with SMTP id 36mr8073311ota.179.1492791475317; Fri,
 21 Apr 2017 09:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.20.240 with HTTP; Fri, 21 Apr 2017 09:17:54 -0700 (PDT)
In-Reply-To: <20170421145901.3wcft3ou7wwywuiu@sirena.org.uk>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com> <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
 <20170421145901.3wcft3ou7wwywuiu@sirena.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Apr 2017 18:17:54 +0200
X-Google-Sender-Auth: i36oRz4oj--xaagaitAFCwqNHXc
Message-ID: <CAK8P3a0j_cnd9j2UuFD5eRVN8q-=dPh2-LBaibb8qdpDQbHpJA@mail.gmail.com>
Subject: Re: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
To:     Mark Brown <broonie@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        gregkh <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-build-reports@lists.linaro.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57759
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

On Fri, Apr 21, 2017 at 4:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
>> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
>> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)
>
>> > 2 arch/mips/mm/fault.c:321:1: error: the frame size of 1104 bytes is larger
>> > than 1024 bytes [-Werror=frame-larger-than=]
>
>> This is a result of a newer compiler version, combined with the -Werror
>> flag that is applied to arch/mips/, and two of the mips defconfigs overriding
>> CONFIG_FRAME_WARN to 1024 on a 64-bit architecture (probably by
>> accident).
>
> I'm wondering how good an idea it is to leave -Werror on in stable
> kernels given that they're very likely to get used with newer compilers
> at some point.  But then I've never been a fan of -Werror in the first
> place.

I agree it's problematic as you never know what future compilers will warn
about. At the moment, alpha, mips, sh and sparc turn on -Werror
unconditionally for architecture specific code and there are only five
device drivers do this as well. The powerpc architecture and the i915
driver have a Kconfig option to control whether the warnings are enabled,
and they are turned off in allmodconfig.

I think this is just an artifact from the old days when we always had tons of
warnings in a given build, but we should try to replace it with something
better instead of just removing it (which would be easy enough to do).

I personally build with 'make CC="gcc -Werror" and fix all the warnings I
run into. I have some plans to improve it by hooking into the
scripts/Makefile.extrawarn infrastructure. Today, we can use "make W=1"
or "make W=12" to turn on extra levels of warnings, and I'd like to
add "make E=0" or "make E=012" as a way to turn on errors for
the default (0) or higher (1, 2, 3) levels, but this takes a little more
preparation.

    Arnd
