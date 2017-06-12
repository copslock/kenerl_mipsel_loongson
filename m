Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 11:55:05 +0200 (CEST)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:33724
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdFLJy5jDOho (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2017 11:54:57 +0200
Received: by mail-ot0-x244.google.com with SMTP id k4so10555669otd.0;
        Mon, 12 Jun 2017 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5UD3gm0jnS4PGM3GtYlJtJw697j54IOqC5FYpDahZCM=;
        b=CI1xk7y/avGUkC4KtVI5MFor5K46ZCeEQCiY5IoPxbVNDYuyCjMahUmchP8+pFBVQg
         BPV75isr8030AyboHjNoz61/WiIw8i1Mfst6is4XbAz6r+my0K4VExPN8GliMm7x8G8s
         Wtt39B4gVkweXsRgop3a2PItVTt+E0Euf+pWejf7AlYheD3q0r+GpJGx1DECcxgPY+n5
         VpVTyc+zuf50s/bgEg6Cfm020aHfwx049vsStyeByCTq5OS9CyH5XV3d8VquWuD4eiYd
         zCsJL0yIVYa65hL/HTvNWIquj1y7C0nUziemlJjJITkaJ+7wjsVkaftUXMtOQ7GU7dB5
         gd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5UD3gm0jnS4PGM3GtYlJtJw697j54IOqC5FYpDahZCM=;
        b=XE1J4deKSds6Bo0KWPS4OQoEpOOAUreprpVhbeYhbYHyTggxtivB+uHMNBq0T0hL6o
         jAyf+xblbFoiCj8FgIcRoL/vwDMZVcIH7AnWTgqM+CawwiIsR8c4By5jHfVoKkW+ErOs
         e13xsWrR3sDpJR9rmLkd5kxke9hOBMH01Xd7Oqcdk5LP2vdJIkmH3B8bjtSj0dLDzvKH
         D+JOWRH6iPIHJSJz2M4oTymp0aJCDfD9b3vWYGd2SzleKsN7F1QYqcxNk/vrnY8u87Qp
         6C3i78V5tQcgBfyH7uH8uyMX+ONthLSJZFIL6jaU1yvluo7eSZvHnRHsTPBYyqXvwBc8
         IRIQ==
X-Gm-Message-State: AODbwcBGfy5RGCQHvhufI2MZZXhkUJzKYaVT/XpiO8qXWDYyfcHsjL7Y
        M3G09czdNtwn6rX45d6AayyQglCXGw==
X-Received: by 10.157.16.110 with SMTP id o43mr29434285oto.71.1497261291773;
 Mon, 12 Jun 2017 02:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Mon, 12 Jun 2017 02:54:51 -0700 (PDT)
In-Reply-To: <20170610164351.7sxzvj4ojj3fbc7h@kozik-lap>
References: <20170608160836.12196-1-krzk@kernel.org> <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
 <20170610164351.7sxzvj4ojj3fbc7h@kozik-lap>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Jun 2017 11:54:51 +0200
X-Google-Sender-Auth: HPJDK_g4Qj08aIFbujAvzrIT1jo
Message-ID: <CAK8P3a3YN+5aJdqxwnpZaVpuucsmQUE3BuEpAf+q7uPXa1dgZw@mail.gmail.com>
Subject: Re: [PATCH 00/35] defconfig: Cleanup from old entries
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>,
        Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, linux-omap@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58410
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

On Sat, Jun 10, 2017 at 6:43 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Jun 09, 2017 at 09:59:48PM +0200, Arnd Bergmann wrote:
>> On Thu, Jun 8, 2017 at 6:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > Hi,
>> >
>> > While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
>> > similar obsolete entries in other files.
>> >
>> > Except the ARM, no dependencies.
>> > For ARM, the rest of patches depend on the first change (otherwise
>> > it might not apply cleanly).
>>
>> Great work!
>>
>> I looked at all the ARM patches, and everything looks good to me (the
>> changlog linewrapping may be suboptimal for readability in some cases,
>> if I had to say anything negative ;-) ).
>>
>> Please add my Acked-by to the ARM patches and send a pull request.
>
> Thanks, I'll send you ARM part in pull request.

Ok

> As for the rest, I think respective arch/platform maintainers should
> take it.

I suspect most will apply the patches, but some architectures maintainers
are not very active. If you are motivated, you could resend the ones
that missed out to Andrew Morton, or you just leave the architectures
to bitrot more. ;-)

     Arnd
