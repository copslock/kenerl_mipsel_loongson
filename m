Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 16:39:28 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:34208 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27031940AbcFNOjZhAKk0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 16:39:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D618DB8006C;
        Tue, 14 Jun 2016 16:39:24 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B3412B80029;
        Tue, 14 Jun 2016 16:39:07 +0200 (CEST)
Received: by mail-vk0-f46.google.com with SMTP id j2so47663887vkg.2;
        Tue, 14 Jun 2016 07:39:07 -0700 (PDT)
X-Gm-Message-State: ALyK8tKfNDaLGyeatPNRNgXxxUPtdvdS8Yhse6HTm/Ee0n5I4x41d831N2B53f+ZnNaeSPIIZrYch4YMTY6/Ww==
X-Received: by 10.31.61.86 with SMTP id k83mr9066113vka.66.1465915146751; Tue,
 14 Jun 2016 07:39:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.141 with HTTP; Tue, 14 Jun 2016 07:38:47 -0700 (PDT)
In-Reply-To: <1465803534-25840-1-git-send-email-noltari@gmail.com>
References: <1465803534-25840-1-git-send-email-noltari@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 14 Jun 2016 16:38:47 +0200
X-Gmail-Original-Message-ID: <CAOiHx=kmkkMyHQQ5wm7J7UGgrsgpMv6dcBxHhwv4yFUc6zzwDw@mail.gmail.com>
Message-ID: <CAOiHx=kmkkMyHQQ5wm7J7UGgrsgpMv6dcBxHhwv4yFUc6zzwDw@mail.gmail.com>
Subject: Re: [PATCH 1/6] MIPS: BMIPS: add missing console to bcm96358nb4ser
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh@kernel.org>, Simon Arlott <simon@fire.lp0.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54047
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

Hi Álvaro,

On 13 June 2016 at 09:38, Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> Console definition is needed in order to avoid a warning in earlycon to
> console transition.
>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm96358nb4ser.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> index f412117..702eae2 100644
> --- a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> +++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts

Unfortunately I haven't seen this earlier, but please don't name the
dts file bcm9* unless it's an actual reference/eval board from
Broadcom.

A more sensible name would be neufbox4-sercom.dts or
bcm6358-neufbox4-sercom.dts.


Regards
Jonas
