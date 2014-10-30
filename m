Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 10:03:44 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:53215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012245AbaJ3JDiOBZ0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 10:03:38 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue002) with ESMTP (Nemesis)
        id 0Li5LP-1YNRuY12uZ-00nRe4; Thu, 30 Oct 2014 10:03:17 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 15/15] irqchip: bcm7120-l2: Enable big endian register accesses on BE kernels
Date:   Thu, 30 Oct 2014 10:03:16 +0100
Message-ID: <2482894.SCbMWLltbW@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414635488-14137-16-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-16-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:tpoEWdDuQjtQSdA6jmm335RXXRtiOEcNq5MXn7sgzn6
 rHFqAiMg7Re8oHrY3okyopfINNlxvZdZRhmyZOLn8wM3NOLI+T
 MEHm2ZsdsoGPonjhUlxj9+bccJ4iLEdBWH996ywWR29b2l5JLg
 B+MJeaGG1COg1o7yv3Kpk4bMN8YYcY8EQF9ff5QRe/Ln238lT5
 i+iROb+NVV3XoC78XPGcglbtc7vqLwyhZKkx7112rUsILm3X8v
 5kSrKpGBqkOP/kThMmtKoO0i2iLHG9fpoCpdBVe2rRdpYLYiQ9
 yIV9kqilGcgsZUdW31AmHQGcJhlegx7QGCO9JJb4YvCOu+8516
 DRTZ0nkByr9kEicYiVak=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43758
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

On Wednesday 29 October 2014 19:18:08 Kevin Cernekee wrote:
> 
> +       flags = IRQ_GC_INIT_MASK_CACHE;
> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +               flags |= IRQ_GC_BE_IO;
> +
> 

As I said before, I think you should take this from a DT property instead
of making it dependent on the CPU endianess. Otherwise things go horribly
wrong e.g. when someone runs a big-endian kernel on one of the ARM
based chips.

	Arnd
