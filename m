Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 23:20:18 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:54727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011821AbaJTVUQ7hKSl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 23:20:16 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
        id 0LaDAk-1YQ4By47Zu-00m4sA; Mon, 20 Oct 2014 23:20:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org, geert@linux-m68k.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date:   Mon, 20 Oct 2014 23:20:08 +0200
Message-ID: <6216923.cK1phqtEXn@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1413838448-29464-5-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <1413838448-29464-5-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:MbDG0WeHUpZSBA2+EqjLjR5rlQEawA0/10+J+wMnBGw
 i36q8OYeVeT9I5aLoLmIjZ83mBw2K+yz8iHDzVd6l6Y3X/bq8E
 KiddXiBTfwWa/yzQzRqww6hX4nNFLIXU96FEW4+PVWZaYJC1d+
 EVKfrNH7sU9pt1TrUhsyidIGGdaW5OhdYXSNziIepXFwO/qXqd
 Vhwt8tQ5Uu7ca+k9n4ZJkM5EhAc3gwmV137d74un1TbBv/uCzI
 R8iiImfyiVsMPnOhvC3UaaYEGImDvHkzMfILZdZHpNh5+n4Kwg
 nBCU+UJF631lEUtb7Klr3WJUezrigTERVLOcOf8zOwYfOKrCYS
 3Tov8OUTI/5p5o+R1C9c=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43389
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

On Monday 20 October 2014 13:54:03 Kevin Cernekee wrote:
> +- clock-names: The appropriate output name in the referenced clock node.
> +
> +       uart0: serial@14e00520 {
> +               compatible = "brcm,bcm6345-uart";
> +               reg = <0x14e00520 0x18>;
> +               interrupt-parent = <&periph_intc>;
> +               interrupts = <2>;
> +               clocks = <&periph_clk>;
> +               clock-names = "periph";
> +       };
> +
> +       clocks {
> +               periph_clk: periph_clk@0 {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <54000000>;
> +                       clock-output-names = "periph";
> +               };
> +       };

In this example, the clock output name of the clock provider is
the same as the clock input of the consumer, that is almost always
a bug and would not be a good example at all.

I assume the output name is correct and the input is not. If you
have access to the HDL source of the bcm6345-uart, please check
if the input has a proper name, otherwise just call it "uart"
or remove the clock-names property completely.

In the documentation enough, you must document the specific name
of the clock that is supposed to be used by the uart driver.

	Arnd
