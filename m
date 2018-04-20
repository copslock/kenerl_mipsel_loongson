Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 21:23:40 +0200 (CEST)
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:29204 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994619AbeDTTXbxcPVz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 21:23:31 +0200
Received: from belgarion ([90.55.212.125])
        by mwinf5d13 with ME
        id cjPK1x00G2itRW203jPK7M; Fri, 20 Apr 2018 21:23:26 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 20 Apr 2018 21:23:26 +0200
X-ME-IP: 90.55.212.125
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
References: <20180419200015.15095-1-wsa@the-dreams.de>
        <20180419200015.15095-2-wsa@the-dreams.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 20 Apr 2018 21:23:19 +0200
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de> (Wolfram Sang's
        message of "Thu, 19 Apr 2018 22:00:07 +0200")
Message-ID: <874lk53cns.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <robert.jarzmik@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63648
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

Wolfram Sang <wsa@the-dreams.de> writes:

> This header only contains platform_data. Move it to the proper directory.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Take it through your tree, no problem for the pxa part.

Cheers.

--
Robert
