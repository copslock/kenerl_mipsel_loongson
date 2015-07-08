Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 10:55:39 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:44796 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009407AbbGHIziYncJW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 10:55:38 +0200
Received: from tock (unknown [176.0.10.208])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 249934C80F2;
        Wed,  8 Jul 2015 10:55:26 +0200 (CEST)
Date:   Wed, 8 Jul 2015 10:55:14 +0200
From:   Alban <albeu@free.fr>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: ath79: Remove the unused GPIO function API
Message-ID: <20150708105514.1156aba3@tock>
In-Reply-To: <CAHNKnsSgyzQu5uxZHu80X9MRQ5sJ+WEBatv9599QYxBsty66pg@mail.gmail.com>
References: <1435914709-15092-1-git-send-email-albeu@free.fr>
        <1435914709-15092-2-git-send-email-albeu@free.fr>
        <CAHNKnsSgyzQu5uxZHu80X9MRQ5sJ+WEBatv9599QYxBsty66pg@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 4 Jul 2015 19:58:32 +0300
Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:

> 2015-07-03 12:11 GMT+03:00 Alban Bedel <albeu@free.fr>:
> > To prepare moving the GPIO driver to drivers/gpio remove the
> > platform specific pinmux API. As it is not used by any board,
> > and such functionality should better be implemented using the
> > pinmux subsystem just removing it seems to be the best option.
> >
> For reference: OpenWRT uses this functions to activate UART.

The pinctrl-single driver should be usable for all SoC where this code
was used. I haven't tried it yet, but it should only be a matter of
writing the DTS down.

Alban
