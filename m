Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 18:19:45 +0100 (CET)
Received: from mail-qc0-f170.google.com ([209.85.216.170]:63835 "EHLO
        mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013783AbaKQRTnmBWV4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 18:19:43 +0100
Received: by mail-qc0-f170.google.com with SMTP id x3so1966168qcv.1
        for <multiple recipients>; Mon, 17 Nov 2014 09:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kpqR/5CvzEUVeCWuF9NHp1vT117q2VV3FofgsyGcMo4=;
        b=oykphuTw75SpkQbJSkYyiKhQXs4rR62OKCo7iTyuRTlxtyXLrVyaSKpplU3yR0GH7w
         e1NPbC++gJPTCU0Les3IbOQU0Hf5anVlTRrXQeP90bJZ0iorXo7dFamWtqvy4YeZteZr
         hIzxediuphic53faqiiOYlkvzQVKcgyYyxm4MUhgbRXbrx2ZLuqBxlyTjWbciMr/eHJn
         ZHWS5FB2Ju2KTCtvZY714mSLRSxSTj8oM/dfpDWfgeha/EMlcoEQdS3lbhJXoI63jo3U
         XEGMTOkJxD24MAlPJGWhvpwyVsLs7ylniHsl7JdEqq/xcfhsIPCiQlJUR1MhTeUxbQLK
         5Epw==
X-Received: by 10.229.79.132 with SMTP id p4mr35954518qck.14.1416244778125;
 Mon, 17 Nov 2014 09:19:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 17 Nov 2014 09:19:17 -0800 (PST)
In-Reply-To: <2018325.yOrLZndTTm@wuerfel>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <3480616.V2TMJFc7uE@wuerfel> <CAOiHx=ky5T7z3T3gX382d=3sw+gGUEfnwXwpcLGa_Oi5YyBwgw@mail.gmail.com>
 <2018325.yOrLZndTTm@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 17 Nov 2014 09:19:17 -0800
Message-ID: <CAJiQ=7An5eZ3j2+Zkx1crV9pBSVodkEQ+6ESGcFk5z0tDV7cHA@mail.gmail.com>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Nov 17, 2014 at 8:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> This is not just DT, it's actually an implementation of a boot
> interface. The situation here seems much more to what we had on
> PowerPC a long time ago than what we had on ARM before the DT
> conversion. I think the best approach here would be to move the
> platform specific bits into the decompressor code, and allow
> multiple implementations of that. This way you can have the
> generic vmlinux file that has a common DT parser, and you wrap
> that into one decompressor per platform, some of which can have
> their own board detection logic or pre-boot setup where necessary.
>
> To be honest, I think having multiple DT files linked into the
> kernel is a really bad idea, because it doesn't solve the
> scalability problem at all. What we did on ARM was to force those
> hacks out into external projects such as the PXA impedence
> matcher [https://github.com/zonque/pxa-impedance-matcher]. This
> can handle all weird boot protocol and adapt them to the normal
> well-defined interfaces we have in the kernel.

To some extent this is how BCM3384 was done[1].

There is a tradeoff here: to add support for the older platforms it is
easy to build a new DTB file into the kernel image, but it is a lot of
trouble to write a new 3rd stage bootloader.  Do we want to maximize
our list of supported boards, or are we shooting for a super clean
kernel implementation right off the bat?

>> And unless there is one, having a
>> multiplatform kernel does not make much sense, as there is no sane way
>> to tell apart different platforms on boot.
>
> How do you normally tell boards apart on MIPS when you don't use DT?

On BCM7xxx (STB) kernels, we could assume the chip ID was in a known
register, and also we could call back into the bootloader to get a
somewhat-accurate board name.

On BCM63xx there is logic in arch/mips/bcm63xx/cpu.c to try to guess
the chip identity from the CPU type/revision (because the latter can
be read directly from CP0).

These systems were never really designed to support multiplatform
kernels.  The ARM BCM7xxx variants, by contrast, were.


[1] https://github.com/Broadcom/aeolus
