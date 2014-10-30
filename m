Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 10:12:46 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:58919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011905AbaJ3JMkrH9Fx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 10:12:40 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue005) with ESMTP (Nemesis)
        id 0Lvg76-1Y9Kzq44jc-017RS8; Thu, 30 Oct 2014 10:12:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 10/15] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Thu, 30 Oct 2014 10:12:30 +0100
Message-ID: <2226258.WJYuvIUVPE@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414635488-14137-11-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-11-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:Np3i8NdMzrmBIwB5aK02n+NKgyCcgMtQmSykV9JP9Ky
 UCJ/K42KtALI2XozPSl0M3WGkthDqTFQ1+VesHiyd+MGWwnclb
 yHR8T2LJs5QbMdnjjdNJ2LUMOAOlS/313l6lmDpocJ7IW9VU9l
 EU5LFbzJG2U9SoGNaMibBcQ97vnVTD/2DQogRJwt/gGw9HRpMt
 vfxbyNaeq5aJu1xfDASNtZsMVsU0coE8EemOa2VumHx1nu2jZu
 fGIVEtZq/blnuJGylS9AWilmA33MAEj9h6gSnTKA8cp18n6KGo
 NIAwj0jkCg4ojmi7b1MKzhWI1Xn8w0Yl87jC7Ev1FDvU/+u9zm
 PRVXNT6cH1ATptHQTgyc=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43762
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

On Wednesday 29 October 2014 19:18:03 Kevin Cernekee wrote:
> A couple of accesses to IRQEN (base+0x00) just used "base" directly, so
> they would break if IRQEN ever became nonzero.  Make sure that all
> reads/writes specify the register offset constant.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Now you no longer convert them this driver to use irq_reg_{readl,writel}, which
breaks support for big-endian ARM.

	Arnd
