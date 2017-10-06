Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 22:53:06 +0200 (CEST)
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:54219 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991743AbdJFUw6Q3W1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 22:52:58 +0200
Received: from belgarion ([90.55.206.157])
        by mwinf5d57 with ME
        id JLsq1w00H3QH74y03LsrjQ; Fri, 06 Oct 2017 22:52:52 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 06 Oct 2017 22:52:52 +0200
X-ME-IP: 90.55.206.157
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/7] i2c: gpio: Augment all boardfiles to use open drain
References: <20170917093906.16325-1-linus.walleij@linaro.org>
        <20170917093906.16325-5-linus.walleij@linaro.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 06 Oct 2017 22:52:50 +0200
In-Reply-To: <20170917093906.16325-5-linus.walleij@linaro.org> (Linus
        Walleij's message of "Sun, 17 Sep 2017 11:39:03 +0200")
Message-ID: <87bmlkf17h.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <robert.jarzmik@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.jarzmik@free.fr
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

Linus Walleij <linus.walleij@linaro.org> writes:

> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
>
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Collected ACKs.
>
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
