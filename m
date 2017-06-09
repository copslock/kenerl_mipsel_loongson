Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 22:00:02 +0200 (CEST)
Received: from mail-ot0-x241.google.com ([IPv6:2607:f8b0:4003:c0f::241]:35803
        "EHLO mail-ot0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993942AbdFIT7zX1hCn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 21:59:55 +0200
Received: by mail-ot0-x241.google.com with SMTP id t31so6672480ota.2;
        Fri, 09 Jun 2017 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M/BQl55VmesotpcAqSTq4QLVPVScYx1VDtsDCdeVK4g=;
        b=RpnkHqlv541c4ruRGaf7oqPvb88KfVLxq8iTdACPivcdeNvkewdyAW+i26ExF6npsC
         ZwJxGIR4UvZzes7kIW5FX49msBjAMdQkVWgga6cRYEb/lqUBkXzJkETNcE+BpkWbVUBo
         NHivxr09uSf9iqPiVa8pPc2FyafTnCWpa+A88kjLGH+w3IseKRyw12F/u089XHHnJ/io
         a/YrvhbZ2veTuAlTmgGAstuk5mFIicwiwLd5SQsXm+zfEE1cB7DQKCoE3hykdXXRRYeW
         NCB2Q3D1L2XZrfkfw3sEC47UYBv7fNmsB8p0FlWaTpRMvSy1csqSC/2CdJNWML/inGgA
         i9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M/BQl55VmesotpcAqSTq4QLVPVScYx1VDtsDCdeVK4g=;
        b=NtlzyoK3d9JeA5VR/vLmnvfRRgz+qXBBYeKcOPCD3UCQtgeoQ+Dc3CJywts2Pn1mLX
         +2DNHtyZxREfVNIHEV2gHbahfo8eDcCA+Nh7jx2fbFy8nmiXvvZ5hLep+MJHxdRp72ah
         KWtn2Z4CTTJmiS/2nZhs/qIWYiIKDEzz9ONNyi5OsZZ2UyXL55dtOhQUwD3Q4gKFw8iD
         rShSgLP8hoHpy8etzgdm3iOAD89Kg+zysKhlovIORrPp12UB/dlL+Gy0M6ik0UjuM2Uw
         uzwet7H987onjmQTa60fwKHFWmUVnKew4DuX+KiSMIENNswG1sAH5IgKNHZtwypnSCfp
         IndA==
X-Gm-Message-State: AODbwcDSJ0mDfLl7vkR4JggB7kK4XgH3MKyW+ObW+/MSlafTk4kx3Awt
        1AOb4B/z91a5utwuXVBUebXYWCXmuQ==
X-Received: by 10.157.11.18 with SMTP id a18mr21242051ota.253.1497038389382;
 Fri, 09 Jun 2017 12:59:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Fri, 9 Jun 2017 12:59:48 -0700 (PDT)
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Jun 2017 21:59:48 +0200
X-Google-Sender-Auth: yfex4lpANlwZXP277Z-Njd3yBs4
Message-ID: <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
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
X-archive-position: 58387
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

On Thu, Jun 8, 2017 at 6:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
> similar obsolete entries in other files.
>
> Except the ARM, no dependencies.
> For ARM, the rest of patches depend on the first change (otherwise
> it might not apply cleanly).

Great work!

I looked at all the ARM patches, and everything looks good to me (the
changlog linewrapping may be suboptimal for readability in some cases,
if I had to say anything negative ;-) ).

Please add my Acked-by to the ARM patches and send a pull request.

        Arnd
