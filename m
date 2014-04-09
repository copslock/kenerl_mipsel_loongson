Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 12:11:34 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:54081 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822098AbaDIKLcMq2TG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Apr 2014 12:11:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A73D22841EC
        for <linux-mips@linux-mips.org>; Wed,  9 Apr 2014 12:10:45 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com [209.85.192.48])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 23E5828028D
        for <linux-mips@linux-mips.org>; Wed,  9 Apr 2014 12:10:45 +0200 (CEST)
Received: by mail-qg0-f48.google.com with SMTP id i50so2038422qgf.21
        for <linux-mips@linux-mips.org>; Wed, 09 Apr 2014 03:11:28 -0700 (PDT)
X-Received: by 10.224.151.130 with SMTP id c2mr11022315qaw.67.1397038288744;
 Wed, 09 Apr 2014 03:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.109.97 with HTTP; Wed, 9 Apr 2014 03:11:08 -0700 (PDT)
In-Reply-To: <53450AE7.802@imgtec.com>
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
 <CAGVrzcZXUWmWO3iuDGPPtKaT1O5qr50LpeSPPHxFCqovkQXzag@mail.gmail.com> <53450AE7.802@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 9 Apr 2014 12:11:08 +0200
Message-ID: <CAOiHx=nVZ8M12ggf6s1dvQik4rQP9fM3Hr0FGia34tBggVxjQA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Initial BPF-JIT support for MIPS
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39742
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

On Wed, Apr 9, 2014 at 10:55 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> I used in fact only R2 devices. I also use R2 specific instructions such as
> "ins" and "wsbh". I haven't really considered supporting older ISAs for a
> couple of reasons. R2 has been around for a long time so a ~7y old device is
> probably R2 capable. Furthermore, I was not sure whether mips32/64R1 devices
> are likely to run the latest kernel (and/or use BPF-JIT at all). But I could
> easily be wrong.
> Having said that, it's possible to support R1 devices but I'd like to avoid
> the overhead so a few #ifdefs are needed in the code. My personal preference
> is to support R2 in the initial patch, and add R1 support later on (along
> with the optimizations I have in mind).

As far as I can tell on a first glance, you are only using "wsbh", and
only if the device is running little endian. There is code to emit
"ins", but it isn't evoked from anywhere.

The biggest supplier of linux-running R1 chips is probably Broadcom
with its xDSL/GPON SoCs; there are still 4k cores, even (afaik) the
newest ones introduced last year. And since they started introducing
ARM based variants, the I would assume the chances of them switching
to R2 or newer are nil. Luckily they are running in big endian mode,
so they should be able to run it even now.

That said, I don't see a problem in making it R2 first, then adding R1
support later.


Regards
Jonas
