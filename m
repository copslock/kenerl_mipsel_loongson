Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 18:44:20 +0200 (CEST)
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33323 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993886AbdFJQoLoYCpq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 18:44:11 +0200
Received: by mail-wr0-f194.google.com with SMTP id v104so13026447wrb.0;
        Sat, 10 Jun 2017 09:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RYXNVC0gz1XGTuCcbcpCZnif+AWJ1e8zcm44B/zPWRg=;
        b=Abt5vRQw5+uak7QAxqBTLtxbKzu2e4fFJ8+QRh5jVX0GP77C+88WJRREKL0lXx5nsV
         h60QCAbaQJALFZxgmtAWofe9cqUMhew6MSghJuU1/bH0NkBWwiWmM6Qt8NF0w/KMufDN
         zhKiuefWrkDHP41G98wLoUdwbqGrOuBGS77sTfv7HRC18qNEGNAc9aLylxqPUhQKWDBO
         a/bv7KWPHiaY0C8K/IfDW7pYIdKN1K9YMmesSZ5WGbAZ3x4B+aDqj3//N0idl+s45Y0R
         p5CtmpyD5joJDCzXpgNgH4ZNkfwwNJ82V6T35FcOV0ukpew8pgE1KDIe4nW69yf8/9jG
         SAdA==
X-Gm-Message-State: AKS2vOy6yT+Xv2dse2E/0NDLXVv01QrdwwEj/251rKTljIvNtaPc944Q
        f0aF/Z0Tgw1GqA==
X-Received: by 10.80.207.7 with SMTP id c7mr1384881edk.59.1497113046455;
        Sat, 10 Jun 2017 09:44:06 -0700 (PDT)
Received: from kozik-lap (pub082136089155.dh-hfc.datazug.ch. [82.136.89.155])
        by smtp.googlemail.com with ESMTPSA id r28sm2409099edd.33.2017.06.10.09.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Jun 2017 09:44:05 -0700 (PDT)
Date:   Sat, 10 Jun 2017 18:43:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
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
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [PATCH 00/35] defconfig: Cleanup from old entries
Message-ID: <20170610164351.7sxzvj4ojj3fbc7h@kozik-lap>
References: <20170608160836.12196-1-krzk@kernel.org>
 <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <k.kozlowski.k@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

On Fri, Jun 09, 2017 at 09:59:48PM +0200, Arnd Bergmann wrote:
> On Thu, Jun 8, 2017 at 6:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
> > similar obsolete entries in other files.
> >
> > Except the ARM, no dependencies.
> > For ARM, the rest of patches depend on the first change (otherwise
> > it might not apply cleanly).
> 
> Great work!
> 
> I looked at all the ARM patches, and everything looks good to me (the
> changlog linewrapping may be suboptimal for readability in some cases,
> if I had to say anything negative ;-) ).
> 
> Please add my Acked-by to the ARM patches and send a pull request.

Thanks, I'll send you ARM part in pull request.

As for the rest, I think respective arch/platform maintainers should
take it.

Best regards,
Krzysztof
