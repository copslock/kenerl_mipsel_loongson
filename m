Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 13:26:38 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:54675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009202AbbHHL0hH1sjw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2015 13:26:37 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPSA (Nemesis) id 0LhzeA-1Z2Ql62xec-00n6ve; Sat, 08 Aug
 2015 13:26:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Robert Richter <robert.richter@caviumnetworks.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, David Daney <ddaney.cavm@gmail.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
Date:   Sat, 08 Aug 2015 13:26:23 +0200
Message-ID: <2414262.jivbxTLuUW@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20150807104320.GQ1820@rric.localhost>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <55C467A0.4020601@linaro.org> <20150807104320.GQ1820@rric.localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:ngwOWlh6U5rmCmjpmPat7MfXSuqz6+M7HE+AE1ReOaKc2WD+Gku
 ZMTVON6lJtS+ji68LWLJzMA2cjFB5gVQzOiIlsq4q9y9rR2nmtzruxsUhtsUrk/bTNPE+HK
 2ayJCgY/8xONZx4VyyRuG4+45xNTmZDCkuHwYhEseGYwb87KBVomRPdaLSHPicJ5h3qwZRC
 mY2fYT/zsHBM04r7ve3Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zc8F4WS4RUY=:rxHDZoUigrMugXopqyiFVP
 uAPMuBFNqAeXyTHuPYvGU7fzc7oMcnK02Kq5A41fKSXEelEgllcjZzy6tXtWcX8Q6rRAQUEIs
 OkYmBc7fTSVf6EPxQ+uN9ods6i2Ej1U/wZ+WRXPqW3+Ch5Vedt9AlQc6j/mvz9fwPtgOhwmlx
 N3HsXPYROwdXmpQsAJW0M2+GlYv5zgjFgt4SwdsTtlAluV5a7fJPxlv/nN4JmaO08XcPlvnXs
 iE3FCZLfZMKy0UVU9a/MtrhWJ4wH7w6dVBDgP17aH0YcohOxMEGEBGYvHFuIv08Odl/VhAANO
 21E0oadBeU/O0eQqSv2gIs4A4V+y0O47fCnIpuhd282VixFgKv1QYwz7evki5seV2MJ1XKbS5
 ZatE47NWuSjaMHgTi0bOTO+bKueTfz7eYsF79nrAOCLAfy2yj4Vwe4tvL/Mf0YJj1HyXTIx67
 PBXROF8SNf76zuISqZGkIcLu0FChGWC6/YRlExLtmlFrj00YKWpoAYAQl+zZFcA1G0rCy4j8i
 KPVhusOUkDPQqHYbbYxDiURS36h0MwqQJYJKGlChlsDagQDDf+OKLW/6tltVw2DZzKOfH0d0z
 abLIuEKU5Nw+gZmQ6GHhuAkrVhsmTPQiKU8efIDHqVHwUv5TkTcmb+SGS1sQZAGsoxciQqY/4
 yXaR5zWpCyAjIsl88Ticjfz0cZ2zkei7eCzAhMQOg6/iJKTZYcH8QvZLlLahH5Il+J+1Ov68G
 utVtzDxj2MnVCYrW
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48734
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

On Friday 07 August 2015 12:43:20 Robert Richter wrote:
> 
> I would not pollute bgx_probe() with acpi and dt specifics, and instead
> keep bgx_init_phy(). The typical design pattern for this is:
> 
> static int bgx_init_phy(struct bgx *bgx)
> {
> #ifdef CONFIG_ACPI
>         if (!acpi_disabled)
>                 return bgx_init_acpi_phy(bgx);
> #endif
>         return bgx_init_of_phy(bgx);
> }
> 
> This adds acpi runtime detection (acpi=no), does not call dt code in
> case of acpi, and saves the #else for bgx_init_acpi_phy().
> 

What you should really do is to use the same function for both,
using the generic device properties API. If that is not possible,
explain in a comment why not.

Aside from that, if you do have to use compile-time conditionals,
use 'if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled)' instead of
#ifdef, for readability. The compiler will produce the same binary,
but also give helpful warnings about incorrect code that you don't
get with #ifdef.

	Arnd
