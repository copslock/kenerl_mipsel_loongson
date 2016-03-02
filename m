Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 09:58:43 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:63017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007233AbcCBI6mDLR0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 09:58:42 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0Lr24R-1Zx2tX34yJ-00eZ36; Wed, 02 Mar
 2016 09:58:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-pcmcia <linux-pcmcia@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pcmcia: db1xxx: use correct irq_to_gpio helper
Date:   Wed, 02 Mar 2016 09:58:07 +0100
Message-ID: <60750044.6kqqL7c64M@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAOLZvyHH4-uq_fnpjrRptkMfjR1+1kzxXM+AUtj_Zb5V3AL-yQ@mail.gmail.com>
References: <1547427.xN2rd1Mon4@wuerfel> <CAOLZvyHH4-uq_fnpjrRptkMfjR1+1kzxXM+AUtj_Zb5V3AL-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:a8xv+gpf4zg4aZYzLvCJ4ZhN/80JhmDnvbugjpGfEoS8b8Rx067
 uymFVvSl8/8Na5DWSAWlGhK1FaJs2EaGpd6ab8bwG74HNe89vL6nxBRfcRJGOBzH8o0QEX/
 qw41LEpi/6TD1czjQhitxn0ghg3Rl9EgWCLf9HzOJHExSJt2UeoZ3dRa368SYYH7IhTcr45
 ffvXpfDpT0qwqh7mawY+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ksGpQQqdbLI=:7ippiybbjgpYdUzA+KnQxD
 KN44XaGoxDqyAxketcX5gKNyhGUGaDlDtIAnFAPU0xu4Ld0rWRbJY7fSFZO8C48nJih9a01Ah
 SbjQMMwcCxJ7olkz1wyO6fZ0arsYGiJGJd4UuqCAeW5iaSHmBma+ewO3rvtLp4cB4R+CI8PZA
 98RQQ2deIGHoPl70ruLrUneh5EZBeCN3PznQb1h+dn5Jcm/CSHVpyfEBrAuKPi/PbtqLujpn/
 Cok6KaysmZVBkBouFHBvRIDZC1UAE0Q6LHZHbMwtIc0xWo+WqzfF0MvTJLJ4wpEIx9iSMVwCN
 3NEHMJapchKO2fOg8KwhGQQRrhWljSfOlGvt0vRN0Wycy3ll9NT9S6QIg/hBw9VbVr8r7LYsy
 r2CtuJd4XlGM+tXuzI+d/8XnqCWtL1QKks2SajA16V0raT8XBioiZBVooiwXawitaGUX+g9gv
 xp3AaQaBfxGaDXzPg+USUWMTbD7uWyQvijhLUnvI9wPqryS4fsXXWtRxgKumY6SM+Ou+YDkk+
 nn762pBs279UQyaYkUjAZ1uZN+DpFAgccWPqheHq1U7Gem0hxbkCeia+Eh8wCDpKEBT6+IwIG
 lzLRitMGjSilWOZRUjS9yAYOvPvn3WeeUH1It2q8vnk/XNu4hvBf2SxbLijJhxzoEob1BIsy1
 StNJEXEq/lKD9118IJeTd+eGhIY5UnO3vuT82uoMOeVF76ZRJAfb4KK6AWRsj8whHmKmpPr4m
 ZggVoc5GNXT6IDjc
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52414
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

On Wednesday 02 March 2016 07:50:28 Manuel Lauss wrote:
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: stable@vger.kernel.org # v4.3
> > Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> > ---
> > I think this is now the last holdout of the irq_to_gpio function,
> > and it's been broken for a while. Maybe Ralf can queue it up through
> > the MIPS tree along with the other fix for irq_to_gpio?
> 
> It's not broken though..  this driver on current linus-git works fine!

Ah, so it doesn't actually need the gpio line then?

irq_to_gpio() unconditionally returns -EINVAL since 4.3, so the easiest
fix would be to remove the card-detect function in the driver, right?

	Arnd
