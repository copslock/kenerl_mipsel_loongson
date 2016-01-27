Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 10:12:21 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.73]:63458 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010410AbcA0JMTi6UWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 10:12:19 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MI6Uo-1aNnuQ1bEU-003saD; Wed, 27 Jan
 2016 10:11:52 +0100
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
Date:   Wed, 27 Jan 2016 10:11:47 +0100
Message-ID: <1947556.38OyJnvGS5@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20160127083745.GA9933@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <3724678.Yr2Z2lv3F9@wuerfel> <20160127083745.GA9933@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:j5ZKw1JUHAwgDRwKSPckHwJVfkGZJzujIrsHtb6ZYSddAt/DID/
 /NGiMuhGQPFhpMz173+DgbsGZo0YZqHLsdTfYNJJlVwKpYYBSP7+hIGuT/y1SsbkLjbFLn7
 vc7KqSi7hoa1vmv1ndYv6FmncQA8OW4kx5qewbCvRNzHNEd7nLZL5MCGdplzOuCZ6eA7Ljj
 mwyGZrNU/3YhCEO25hhFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mLqVvlk7wmM=:gk2jTlWqYntnAPR6SEJfR6
 aaZX0QF+4MvACXXxLlAjYTxq4VQWsNHIw9L/aep80DO6c/VTktC1ojVt5K9f7/Rsq1tG0RBSB
 pT1552usasH4VKaoPH/0hlhFvQ4HIvb2hoTRFSAXw6Nbyig1B0R41gHITOgOC3+ZLc/ONC2RV
 AJzFCPwp7fU2hJktCXTwec+Au91nniuJhY592scB/jVgK9sIpsshzxV8ZMcZVK34WX8kKCLhH
 oVgHoGslci7K75taB3q1LaA1UDFGJ19e2R+XOs04iNzDq2bINz0zBPRFz7mI1yygQIw5ipDgD
 Cd5LmjwNxVGHY4QGdXRbDZ8VwTSr0q97kacwrvbOnGpWOsFrt+SiBPAn6HbyT/4xZjnF4eTLF
 dxW5af7nXXUIp1ZYdCFGKusNIrI5fMVHh6z1qbIKr9t7dggQNTU5YG+Nc5TjzBd5wJ4dA1EOk
 ZE0sAkW3elxv2Uptz9M0x9iCHya3Dbqa1nd4vZWDNGoexFG/vsnth8DuJpJFbdc13qqqALlc0
 LI4ATsAk4p71JhlP+nIAk0d3Cr2lbG17nUMeAk2tRp6tjnHHD+E0apYoWvhgoR+QKQSbAMjFz
 iWTl9HbXqPDeIzOWl7krGRIIipcJ4UJZxhEz2aQJN68+Hs/Fq3n2OZbsR96SMPP7H8Gz2FaiQ
 aZKuUlRKJ5sX9ZQkvo74JJZ6xMsHWP2R7K2KMjONn6S3JKV63xWHRSSBGLdlQ/BATSmCfALpy
 x4ECreHExzxuamDC
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51460
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

On Wednesday 27 January 2016 16:37:45 Fengguang Wu wrote:
> 
> Thank you for the tips! I've updated the lists accordingly.
> 
> 1st priority
> ============
> 
> arm-allmodconfig
> arm-allnoconfig
> arm-at91_dt_defconfig
> arm-efm32_defconfig
> arm-exynos_defconfig
> arm-multi_v7_defconfig
> arm-multi_v8_defconfig
> arm-shmobile_defconfig
> arm-sunxi_defconfig
> 
> 2nd priority
> ============
> 
> arm-arm5
> arm-arm67
> arm-imx_v6_v7_defconfig
> arm-ixp4xx_defconfig
> arm-mvebu_v7_defconfig
> arm-omap2plus_defconfig
> arm-sa1100
> arm-samsung
> arm-sh
> arm-tegra_defconfig
> 
> 3nd priority
> ============
> 
> arch/*/configs/*

Looks good, I'm just unsure about "multi_v8_defconfig", this does not
exist. Do you mean multi_v5_defconfig?

I also wonder if you include 'randconfig' builds for some architectures.
I have patches for all remaining errors and warnings that I see with
ARM randconfig builds today. Not all of them are merged yet, but I could
probably come up with a file to be used as input to KCONFIG_ALLCONFIG
to eliminate the known-broken configurations, if you are interested.

Thanks!

	Arnd
