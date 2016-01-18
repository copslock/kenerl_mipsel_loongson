Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 14:36:15 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:47174 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010681AbcARNgOWluwm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 14:36:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 73F4928C6BF;
        Mon, 18 Jan 2016 14:35:32 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com [209.85.217.175])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A3DB528C6AC;
        Mon, 18 Jan 2016 14:35:29 +0100 (CET)
Received: by mail-lb0-f175.google.com with SMTP id bc4so345942396lbc.2;
        Mon, 18 Jan 2016 05:36:08 -0800 (PST)
X-Gm-Message-State: ALoCoQnCsfFKi5gqT+dHJSgs0Y5/y3/t6rqI4QPBuA4C5MVf5xKR7fkmADXyu4BXbTme7hB3lIn2awzDpILTfVUYGBnxcQ/cgA==
X-Received: by 10.112.148.131 with SMTP id ts3mr8461451lbb.102.1453124167839;
 Mon, 18 Jan 2016 05:36:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.130 with HTTP; Mon, 18 Jan 2016 05:35:48 -0800 (PST)
In-Reply-To: <BF36180D-DB32-42A5-AFF7-2B282F5A81DC@gmail.com>
References: <1453030101-14794-1-git-send-email-noltari@gmail.com>
 <0BC6030C-7485-4193-B86D-E690BF673952@gmail.com> <BF36180D-DB32-42A5-AFF7-2B282F5A81DC@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 18 Jan 2016 14:35:48 +0100
X-Gmail-Original-Message-ID: <CAOiHx=kD2Rj4wKpXkHeMYP8efuBA1PjirqxpX4RNkrTyNARV4A@mail.gmail.com>
Message-ID: <CAOiHx=kD2Rj4wKpXkHeMYP8efuBA1PjirqxpX4RNkrTyNARV4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] bmips: add BCM6358 support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51195
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

Hi,

On 18 January 2016 at 10:42, Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> I can refine it to support a custom offset for each cpu instead of a generic one, but defining a custom offset for new SoCs such as BCM6368 or BCM6328 would actually break them, since that way the address wouldn't be remapped to 0xb0000000.
> See: https://github.com/torvalds/linux/blob/master/arch/mips/include/asm/io.h#L213
> In those CPUs the remapping is done automatically (from 0x10000000 to 0xb0000000), since the registers are located in the low 512MB of address space (0x1fffffffULL).
>
> However, the older CPUs such as BCM6358 (or BCM3368) need that custom ioremap, since those registers aren't located in the low 512MB of address space.
> If you want, I can do something like this: https://gist.github.com/Noltari/bc5fe029c52cf053a454
> And after that we could add other CPUs such as the BCM3368, which needs a different offset: "{ "brcm,bcm3368", 0xfff80000 }"
>
> What do you think? Should we keep a generic offset (0xfff00000) or should we add SoC specific compatible strings with each custom offset?

How about using the arm approach [1] and adding support for
registering static mappings? That way we avoid adding a custom
plat_ioremap() and keep the amount of bmips code to a minimum.


Jonas

[1]:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ed8fd2186a4e4f3b98434093b56f9b793d48443e
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=101eeda38c0ab8a4f916176e325d9e036d981a24
