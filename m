Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2015 08:53:07 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:39561 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007369AbbJBGxEAZ6qq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Oct 2015 08:53:04 +0200
Received: from tock (unknown [78.50.246.201])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 94746940048;
        Fri,  2 Oct 2015 08:52:55 +0200 (CEST)
Date:   Fri, 2 Oct 2015 08:52:54 +0200
From:   Alban <albeu@free.fr>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aban Bedel <albeu@free.fr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: ath79: Convert to the state container design
 pattern
Message-ID: <20151002085254.6a929c58@tock>
In-Reply-To: <CACRpkdbX+cMmS-j85zqhPSa8XRQHtus6HXqZrLo9b++KAHDc5g@mail.gmail.com>
References: <1441100282-13584-1-git-send-email-albeu@free.fr>
        <CACRpkdbX+cMmS-j85zqhPSa8XRQHtus6HXqZrLo9b++KAHDc5g@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49411
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

On Fri, 25 Sep 2015 09:39:51 -0700
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Sep 1, 2015 at 2:38 AM, Alban Bedel <albeu@free.fr> wrote:
> 
> > Turn the ath79 driver into a true driver supporting multiple
> > instances. While at it also removed unneed includes and make use of
> > the BIT() macro.
> >
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >
> > This patch apply on top of my previous MIPS GPIO patches that are
> > pending for 4.3, so it might be better to take it thru the MIPS
> > tree.
> 
> Patch applied (for v4.4).
> 
> Would you consider sending a patch adding yourself as maintainer
> for this file in MAINTAINERS?

Yes, I'll send that soon.

However while looking at adding IRQ support I stumbled upon the bgpio
API from the generic gpio driver. I think it might make more sense
to simply move to this API instead of doing the above cleanup. I'll
send a patch for this in the next days.

Alban
