Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 12:08:53 +0100 (CET)
Received: from mail-qa0-f54.google.com ([209.85.216.54]:43153 "EHLO
        mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010822AbbA3LIwYkejV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 12:08:52 +0100
Received: by mail-qa0-f54.google.com with SMTP id w8so19360836qac.13
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=q+es9mepj/qm2ZYHGHWncxuOs98PCQfjlXmb/XokLm0=;
        b=NRoPws0DuOETX7wKPw4KC+g7iDYhdBP7lhouezwgeXe/yGzs7JYI31/nvu1zK0tFF7
         rD/qgT55UqICg3oDRDWhnGKQtyGzljZ1r2pwb9iZhsObKG/USrKCMIHsDTNi60RCVZIf
         9z/itcDWK7q4pm6NlvCoeTCW18KxQfc7hgjRvTDa8ZAnXCHsq4ywId0GoN0ynKs1WmWv
         N1S6vPfrPZomjZOLgWGJYA985POABXKVBa0w98dMy3iTeeCCLAPpIc2UJpgWLimjZ1De
         gRjVFojj8rUyfrMCht2+VPEvuLjyactoCVQPnY87bSB3QjyxL5lT2vwjP6ANOahRLiuX
         gkyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=q+es9mepj/qm2ZYHGHWncxuOs98PCQfjlXmb/XokLm0=;
        b=TjqUyYrHwEqgrscpUFK5eh88MsC2HHubEKNGHi8ehUFWDVq9CUwbnLcfeLCEfTbGrC
         mZ3t0GknKVjor7gHgW08ZJpOuRTJGaExqrEuc9vh7cXg0mKOdwEPP7cPQTUAQQqs+hqv
         I0oXZde7KFk399nIrK7pY02aNeTzDjvJxoG2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q+es9mepj/qm2ZYHGHWncxuOs98PCQfjlXmb/XokLm0=;
        b=O2l1PW4uLDMemCfHbu5b9ES6fCak1Akts6S7REW+DbVulZYHr7DUSi1Y/dW1Pz3U3x
         9WweC4RUQQNt71aSjxTaFPOGmfndPN2rS82KNvdD6xZiqh0S7Wq9gDBpLM7RhngjGXS/
         859CefkqOeeFMVCsyfg1AHUsBfXmcdGzyQIFkMT90NRiFCUj+hrIXFAd8BJLtxf7+URC
         K1xH5EvMWbjMYGavMn60h6DQlUnPdmDRRA171243S1xpbd+V2iqWRTr5L9TIo0dM1+qK
         BLjLtJ1aCg6xrCyMlpjUaixsPu5u7vCrYzvvWso1DXydvrDQaOWpgi0Qv+5s5Heks18t
         LYLw==
X-Gm-Message-State: ALoCoQmFQy3XMVRceIkO4ZdLCgucyBw1vVdE1a3ynuwX4faJHQOArhJfetncANTKal0Pzz6mfosI
MIME-Version: 1.0
X-Received: by 10.224.111.194 with SMTP id t2mr10699048qap.86.1422616126564;
 Fri, 30 Jan 2015 03:08:46 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 30 Jan 2015 03:08:46 -0800 (PST)
In-Reply-To: <20150130102612.GE16744@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
        <54BE3369.9000802@imgtec.com>
        <54CA6089.50505@imgtec.com>
        <20150130091832.GA16744@ulmo>
        <CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA@mail.gmail.com>
        <20150130102612.GE16744@ulmo>
Date:   Fri, 30 Jan 2015 11:08:46 +0000
X-Google-Sender-Auth: nA_7rw40JxpbCmp3dFwXb2Ec08c
Message-ID: <CAL1qeaEen_RM8da+KU-+O26M9Z7VksWG+C=C-Oa6cAhyjiXfug@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        vladimir_zapolskiy@mentor.com,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

+linux-mips

On Fri, Jan 30, 2015 at 10:26 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Fri, Jan 30, 2015 at 09:50:46AM +0000, Andrew Bresticker wrote:
>> > Also you're making it especially difficult to build-test by not
>> > providing even the basic bits of your SoC support first. All even
>> > linux-next seems to have for the Pistachio SoC is the addition of a
>> > compatible string to the dw-mmc driver.
>> >
>> > I'll take the PWM driver, but I'll assume that you'll eventually have
>> > more pieces available, in which case I'd appreciate a note so I can
>> > update my build scripts.
>>
>> FYI, I'm hoping to post Pistachio platform support for 3.21.
>
> That'd be great. I can switch over to a proper defconfig then and not
> jump through extra hoops to build test patches.
>
> Also, I'm seeing a bunch of weird errors from building MIPS, mostly
> things like this:
>
>           CC      net/ipv4/netfilter/arp_tables.mod.o
>         {standard input}: Assembler messages:
>         {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
>
> or this later on:
>
>         mips-linux-gnu-ld: Warning: vmlinuz uses -mhard-float (set by arch/mips/boot/compressed/head.o), arch/mips/boot/compressed/decompress.o uses -msoft-float
>
> This is essentially a gpr_defconfig (because it select MIPS_ALCHEMY,
> which in turns pulls in COMMON_CLK that PWM_IMG depends on) and then
> enabling MFD_SYSCON on top so that all dependencies are met.
>
> What am I doing wrong?

What version of binutils are you using?  I believe the latter error
should be fixed by commit 842dfc11ea9a ("MIPS: Fix build with binutils
2.24.51+"), but perhaps the decompressor Makefile requires a fix as
well?  Unfortunately I'm traveling for the next couple of days, but I
may be able to take a look at it on Monday.
