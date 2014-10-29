Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:46:38 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:49767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011823AbaJ2Hqgu1RoB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:46:36 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0MbLRw-1XSxXM25gK-00IjfL; Wed, 29 Oct 2014 08:46:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 06/11] irqchip: bcm7120-l2: Use irq_reg_* accessors
Date:   Wed, 29 Oct 2014 08:46:27 +0100
Message-ID: <1863628.skWLaDFD15@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414555138-6500-6-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-6-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:VK+AReuOC0/93uxhBMUn5lMvgS1iyW48utrMgduPnWt
 sWiBLM08etgVHXZGFw24Vehlj3pDWGPBcyqwg7q3mdQYsFn8hW
 1lBQjmOjErIRyL4yKupEondTeCy+YRMF021uDF1OXcBaE/a6Da
 roFHvhyTWR5nuIMtrhEDKE/XKRwMPJGIJFF2Kkpv1vVmxEsSSQ
 dMFeKQbVMNt+y1oaGve1f7XQoRPz6NHjniP4pPgfgaOpHjUuOB
 Iyf5N9prCc1uLV0qqc0q8LryKkbAUBAMFxYUZAMPvDsUfObnAY
 wGU8skbG0cun3NazsceWgwaTPJr+Pj/IUa/thM0SO7ObY8UUlT
 cu1L1w/NrHS0Yo1Q1M3U=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43687
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

On Tuesday 28 October 2014 20:58:53 Kevin Cernekee wrote:
> This keeps things consistent between the "core" bcm7120-l2 driver and the
> helpers in generic-chip.c.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
> 

Ah, you did. Nevermind my comment to patch 5 then ;-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
