Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 15:26:53 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:62135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010833AbcASO0vWq2eV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 15:26:51 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0MP0B5-1aFloQ45wN-006M7j; Tue, 19 Jan
 2016 15:26:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date:   Tue, 19 Jan 2016 15:26:16 +0100
Message-ID: <1534543.eobSKFEFfp@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:yTdvr1Vd+IKbhJpIwBomnn1PSjJ6V4SM1hzankAhD8l4NXpaaHY
 1hs2tHbZAAAvo/F2Tqty1E6dbWfUi3bRSdbqG6NPVlmQusH6xM1JjENcPKPJKvJp3Wv0CNC
 K8bYOBpWLIKbU4Hw2XqkOzRAFki0ezhb3QWSuGmSICyrxBySE6nvAQdkvbMwWFmaSNE5A16
 BqMCVghqfERPeVtw60Duw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hH1iu22MZm0=:ezlObkAqqbFDYv8CSgYYMp
 Qpc0+V55vEMUX2M3NnYXocg9Dro4mUZXwiazdwoKJJPPVdsStkf043Chjp/vXfnGdhIjvP4Q+
 9LNdg6gEbj/qisS8vtaQHL9wEUDP27c9aDbrG1EsrtAOIup8b1H9ki6XNGJ2/Tq86JtrBnMLd
 Yw8au6TgJoOJ1aahJMizJWqvSMAVO4jfWaaGZQvoHm6a2szTegQLTRYbvJS+r2vqdtQW77CIC
 X6dZXGMCKwtiHIpeWdBUpBqORrNSYxjg0L07VeQvcnEuB9BjqFuUYfI3iY4ifqppmX3O7MERj
 SYS152VbVXHvWQcYG6sL1hMzRVVUFdGhM+bxIc97pHtXZa8/FN+MSLX8/1tEIJfCcsGNEcD8G
 s4obGv9qmWdpGq3bX24+rofGVfMY1fdNQS2q4gTZwH6tJLVvLaLnhfxnmZ3lle3kQCtDDHCu6
 9dGcOnd/IYzKre225ihfAZ7sfJqc7NfkBVaMbDGAbDD5rI/fX8MRFMsZ//PeT3DC9Yz2/Pda2
 2FTsCUbgIBuOzrJ4D+Q9dVow6MDsTv5Y/8QoHe9Me+zvrXITq6vCsFfMetId2BT9dNoLxlfAX
 R+5EehNz9MkSkbhiTiDVmV8+CdeD6qibjR/xLFAB3E5aR+BKXLPjZCKE41sIOCcjuT7oI8t/l
 XOC6BIp26GAXCPT98hvV4KhfbWFkkM01W/89fAfrUMbHJVYEDX0P3f4jMYb0P/OGzMrLL8pX5
 7vpcW3xKLnbriwgP
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51222
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

On Tuesday 19 January 2016 19:27:55 kbuild test robot wrote:
> arm                               allnoconfig
> arm                         at91_dt_defconfig
> arm                                  at_hdmac
> arm                                    ep93xx
> arm                       imx_v6_v7_defconfig
> arm                                  iop-adma
> arm                          marzen_defconfig
> arm                          prima2_defconfig
> arm                                    sa1100
> arm                                   samsung
> arm                                        sh
> arm                       spear13xx_defconfig
> 

Hi Fengguang,

Sorry for hijacking this thread. I have never seen the list of arm defconfigs
you are building before, and it seems to be a surprising selection, as a number
of platforms (ep93xx, iop, sa1100, spear13xx) are rather obscure, but the
configurations that I tend to use most (multi_v7_defconfig, multi_v5_defconfig,
allmodconfig) are not included.

Do you always build the same set of configurations, or is this a different
each time?

Can you always include the three I mentioned?

	Arnd
