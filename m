Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:46:59 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:54498 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011823AbaJ2Hq5BWRlt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:46:57 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue102) with ESMTP (Nemesis)
        id 0MhDFZ-1XNiDe0tQf-00MN2x; Wed, 29 Oct 2014 08:46:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 07/11] irqchip: brcmstb-l2: Use irq_reg_* accessors
Date:   Wed, 29 Oct 2014 08:46:46 +0100
Message-ID: <4282257.X5Vskr4CUy@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414555138-6500-7-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-7-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:x66CgA/gIhMve7bKeYJA7ynZM23zOSJrtMUjulodbag
 /qZkLviO27Ncl5HbB2CR5nFrN7HoGmTW0Kg4Pd8LWvg2xCqOIi
 S2ziwCEjzg31w1X4MNBTlQs6vm211UR5amEoDMUGFqnMrlFo/k
 x0NZvkzLBAJS4kikoMbhGRqdHIyk3+Og0AVZmWcRfq2Tej2bsE
 EnbHRA3PoCsVH0Z18u7JSlp0YzQaIkewNQ3S07WCG1L0IEbn4q
 MwDerOc3XWHO3THmiUQLGd6FRB4L6h2PPHftllE6ZG+K+QSZn7
 wwlWSfUIG2ubU6d35oDoAEqsmZb3/j82zLtPYuppvz6eeOMNg/
 oRCISJUumAI5mFnpMClk=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43688
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

On Tuesday 28 October 2014 20:58:54 Kevin Cernekee wrote:
> This change was just made on bcm7120-l2, so let's keep things consistent
> between the two drivers.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
