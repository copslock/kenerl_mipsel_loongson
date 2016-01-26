Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 17:28:07 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.133]:52842 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011610AbcAZQ2F0qMiC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 17:28:05 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0M3OHE-1a6R3m1HdI-00qxr8; Tue, 26 Jan
 2016 17:27:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date:   Tue, 26 Jan 2016 17:27:46 +0100
Message-ID: <3724678.Yr2Z2lv3F9@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20160126053504.GA22301@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <20160126053050.GB20385@wfg-t540p.sh.intel.com> <20160126053504.GA22301@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:natST0jdrO9kRfP5rruw6NdlFuep8iGsSaTrnz2P/6MQarCOC25
 x3DeQpEao5LI/0wS961rvpyt8O1H5COoD0rHLvbRORmYdp4VSNFMDogldjeXlVkmxz+pAmz
 LWMW3YoXGQfxFo5A04jZcOejzxk6Gtc5ZtX2FRZFlSrrcQ0ZQVp17oJsa1k3Qogr/vYE0Q3
 tN79Ri7FVN6G+XMpio6ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D4OlsMYT9Xs=:QyojN+RSzYc2d6MJJAqrTT
 pwkqKz2P/TUyNh5Zk31Lws5Nj9gbBx7ecdEJPTueqhFMTcQ35SHEDxU8MkFEt56SkBuU3oL00
 uqn0RObRZ76HFXkbw2aAn/iIAjdKsw1uUYOMpWmTPz38oag8QvYJrOGI/XwW1jFTHfVNhzUTa
 OnfH0ESbt7A7wlQLqdX8GYN6Q9ezVn4xpaWd6CqaAZAta6Mu5w23WDj5+qYytGcTvXDbeP7Gw
 4twJWhMpguGPa5oE57xnoOQ0xxjhTAji3DTBzBZfD6F2/BkX/jpO3TwZJ7HtOgX01QoIZ17bV
 i7sTJ1v266tiqeZsoMz9FVGsxLMg0Ebno0qdQK8PsyXOneFG+UdTQGvRXh3FFd36Zs5yhx5PS
 urBF/oasq4TUL68GBZ4JidkJjDdW3bZ2B4mOyLrmfUYQapwvSDD3NxIFQuUtPusWxUuel3sEN
 a65haJCod96d2+mOkb9Qf13NieJI5Yk2hgCioTnfwDwrebxgbAnVmBksVVYYzFwkNURCpMIE9
 wY4Hez9WPbOP0D/eClQtnXTwgnjJTYd/2yPq+2c2s1rMmzUKXWNTaqVymKQMOwW9+clvxLwOE
 hgBApXscjCtjm9kDTbHBpShbn0cYdhqeEfYzMN4WwAXhYWVGUd6qwBg7c1qQL3LoaTYw3eEBa
 6DnUye9WFqr5UIqq8t6aymJbd4qd8bVsFDkwtix90xa2fv+2QLz7FC6VNAm8TiyB8iYqnY/53
 PGkYwh3yd4JvX6If
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51413
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

On Tuesday 26 January 2016 13:35:04 Fengguang Wu wrote:
> > There are a fixed set of config files for fast build tests (which I
> > selected randomly, feel free to ask me to change the list to more
> > reasonable ones):
> > 
> >       arm-allnoconfig
> >       arm-at91_dt_defconfig
> >       arm-at_hdmac
> >       arm-ep93xx
> >       arm-imx_v6_v7_defconfig
> >       arm-iop-adma
> >       arm-marzen_defconfig
> >       arm-prima2_defconfig
> >       arm-sa1100
> >       arm-samsung
> >       arm-sh
> >       arm-spear13xx_defconfig
> 
> And there is another set of best effort configs whose priority is
> in-between the above list and the arch/*/configs/* ones.
> 
>         arm-arm5
>         arm-arm67
>         arm-mmp
>         arm-omap2plus_defconfig
>         arm-s3c2410_defconfig
>         arm-tegra_defconfig
> 

I think we want at least one ARMv7-M NOMMU target in the list,
I'd pick efm32_defconfig as it has the least overlap with the
drivers in the other configs.

I don't know what arm-sh is, but I assume it's a superset of
marzen, so you can probably drop marzen or move it down to the
low-prio set. Similarly, the at_hdmac is likely a subset of
at91_dt_defconfig and could be dropped.

prima2, ep93xx and spear13xx, mmp and s3c2410 are all
slow-moving platforms, I would not expect to see much
results from running those compared to the more active
platforms.

The platforms with the most changes these days are omap2plus,
sunxi, shmobile, and exynos (samsung), followed by some
that are widely used but not changed as much including
tegra, imx_v6_v7, mvebu_v7, and qcom (previously msm).

iop and sa1100 are rather old and won't change much, but it
can be good to keep them in there because they are for older
CPU architectures and behave a little different from the
modern ones. It might be better to replace iop with ixp4xx,
as this one is the only big-endian defconfig build we have,
and that sometimes catches build-time bugs.

	Arnd
