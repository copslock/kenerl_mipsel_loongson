Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Dec 2014 16:52:35 +0100 (CET)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34504 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010431AbaLaPwdGUm62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Dec 2014 16:52:33 +0100
Received: by mail-ie0-f175.google.com with SMTP id x19so14520308ier.6;
        Wed, 31 Dec 2014 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rTJGz3UueviGtoF8CitS5aNg8bb6E7NsaTsQNZuHuFM=;
        b=NVWZ+aifLIrDEKZ0H/1NuGh+44kChS5vlx0w7AkweCF/PtlGSViyzImkqO1JlCa0Ew
         VivTmptc2qjX06Zqw8As9Wn8zzQoYdy+YgzYReaooAnEOCerKBpIxk5XeiKJZZ9EH0Pf
         dS/QK/koV1p0erwExxoQGhDvKbsL/hR72KDhcEfdHbD192h0VkAMksmHA10f414nCy8w
         xeGIz8GybyKgpOBNYT1Jn4R5BougLJfAuFiYnZF4lKNGrJSp3wCbSH6JoZrSS5LJCp8H
         mWriCAQ1nv4SfRGD3bYdw+zIRtb4fBCXHowwfHeL5xLMve/M0HjhGZPwJ1n/FXJlkL/w
         8xWA==
X-Received: by 10.50.112.196 with SMTP id is4mr35838544igb.10.1420041146958;
 Wed, 31 Dec 2014 07:52:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.165.65 with HTTP; Wed, 31 Dec 2014 07:51:46 -0800 (PST)
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 31 Dec 2014 07:51:46 -0800
Message-ID: <CAGVrzcboyES2DHLY5CW3srz9uf9gFJnjJDRVCo+-+_McA0PgHQ@mail.gmail.com>
Subject: Re: [PATCH V6 00/25] Generic BMIPS kernel
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>, Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-12-25 9:48 GMT-08:00 Kevin Cernekee <cernekee@gmail.com>:
> V5->V6: Incorporate several fixes/enhancements from Jaedon Shin:
>
>  - Fix register read/modify/write in RAC flush code.
>
>  - Fix use of "SYS_HAS_CPU_BMIPS32_3300" Kconfig symbol.
>
>  - Add base platform support for 7358 and 7362.
>
> The DTS files follow Andrew Bresticker's new per-vendor directory layout.
>
> This series applies on top of Linus' current head of tree.
>
> Patch 01 (Fix outdated use of mips_cpu_intc_init()) is REQUIRED for 3.19
> to fix a build failure seen in 3.19-rc.  The other patches can
> be queued for 3.20 or later.

For this entire patch series:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
--
Florian
