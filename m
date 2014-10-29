Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:47:58 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:53550 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011823AbaJ2Hr4zR7JH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:47:56 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0MaG3Y-1XU2zC23x2-00JqSi; Wed, 29 Oct 2014 08:47:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 08/11] irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
Date:   Wed, 29 Oct 2014 08:47:29 +0100
Message-ID: <1877870.yMDyCEjdc0@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414555138-6500-8-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-8-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:QtHJgeqZlTaMz3c9iNjwQ5ul9CGpEMg9Spwin0ZZwP3
 YARE8Z9q/k487Zw8AujrPC6bobTafMuRVDiNmuvdEAS6F8zwiW
 XAucotgEd4lM4RVSATlzpqQEpOviJ1500nbCt9ZFMa6OuYwDtn
 lMEJckQDnuf4ruGykybWAV/L+eByDMxYTEzs5QS++8ZcYPdAC5
 EeRDaGCrTRABrVTF7l/c+7ATIhDzPHBy837zxDRnyaOGuj6LIP
 OrAVdHXxjoSDYyBm1YPL/mxI6qv1e5sezQ8Mxy+4BzSIv3WuEP
 vESUJxI6Uuubxg2TBhrTsDXbI2GFOocG3HpR2xNJjWDMAYbXYT
 zJXb4ZUDLV/Zs7QuGciA=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43689
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

On Tuesday 28 October 2014 20:58:55 Kevin Cernekee wrote:
> This mask should have been 0xffff_ffff, not 0x0fff_ffff.
> 
> The change should not have an effect on current users (STB) because bits
> 31:27 are unused.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
