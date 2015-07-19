Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Jul 2015 23:16:58 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55173 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010887AbbGSVQ4ZW5L4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Jul 2015 23:16:56 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 25D5128BB92;
        Sun, 19 Jul 2015 23:16:28 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com [209.85.192.43])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6988F28B738;
        Sun, 19 Jul 2015 23:16:25 +0200 (CEST)
Received: by qgeu79 with SMTP id u79so10104081qge.1;
        Sun, 19 Jul 2015 14:16:49 -0700 (PDT)
X-Received: by 10.55.41.229 with SMTP id p98mr40009907qkp.99.1437340609436;
 Sun, 19 Jul 2015 14:16:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.82.200 with HTTP; Sun, 19 Jul 2015 14:16:30 -0700 (PDT)
In-Reply-To: <CAL_JsqKwQHqUauyOxYg2PF4rBy1DC_UC9s8orWuXUsxMf66bMA@mail.gmail.com>
References: <1437309769-8382-1-git-send-email-jogo@openwrt.org> <CAL_JsqKwQHqUauyOxYg2PF4rBy1DC_UC9s8orWuXUsxMf66bMA@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 19 Jul 2015 23:16:30 +0200
Message-ID: <CAOiHx=mChjd5sMDat2qPW73Hjjxoqs11s5SoHz+9AxV0K7MiYA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix build with CONFIG_OF=y for non OF-enabled targets
To:     Rob Herring <robh@kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48350
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

On Sun, Jul 19, 2015 at 11:06 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jul 19, 2015 at 7:42 AM, Jonas Gorski <jogo@openwrt.org> wrote:
>> Commit 01306aeadd75 ("MIPS: prepare for user enabling of CONFIG_OF")
>> changed the guards in asm/prom.h from CONFIG_OF to CONFIG_USE_OF, but
>> missed the actual function declarations in kernel/prom.c, which have
>> additional dependencies.
>
> Just curious, what machine do you hit this on?

bcm63xx without my local WIP OF-patches applied, but still CONFIG_OF=y
in the .config. So more accidentally found than intentionally OF
enabled.


Jonas
