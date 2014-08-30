Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 09:55:06 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:62715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007517AbaH3HzE6mFGW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 09:55:04 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0LuLSB-1YOZeg0esp-011mPi; Sat, 30 Aug 2014 09:54:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] MIPS: GIC: Add device-tree support
Date:   Sat, 30 Aug 2014 09:54:40 +0200
Message-ID: <15153439.zUXECAnL7k@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1409350479-19108-6-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <1409350479-19108-6-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:qhuEkoRlNK7oyK54wx9D4aSDSMkNfBIB51tKwzfmloK
 ZkRmj9JQFusuI1L3eYgmQXzTVZz/Ur6ngnE0Iu6ocFJ8DiMlEM
 NyJqxsS8xWkAas/iHZuF/my4ZCEE+q9myRpODkd5sCD8ZYSPvY
 i1B7A9AKhsjX8DxPJ6k5oat4asaIlyt+LwmJRtXz/0qjmCR+fd
 gIjupxkT7JJ3VOhG0T16W/+Jn0I4r+HXbc9Xh34PjiR8QqeFEU
 ENXFYvdyElma+FL0YQKEIuuULSChnR3v0ZaEAZM0gu+/ouDjBl
 O/D7VtU9m+F3I6oWQ3UELbBsYSReJQoJK1GnCYWG+G1E4NbksJ
 lwiWu4NcNdW4hsBm/QLo=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42344
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

On Friday 29 August 2014 15:14:32 Andrew Bresticker wrote:
> Add device-tree support for the MIPS GIC.  With DT, no per-platform
> static device interrupt mapping is supplied and instead all device
> interrupts are specified through the DT.  The GIC-to-CPU interrupts
> must also be specified in the DT.
> 
> Platforms using DT-based probing of the GIC need only supply the
> GIC_NUM_INTRS and, if necessary, MIPS_GIC_IRQ_BASE values and
> call of_irq_init() with an of_device_id table including the GIC.
> 
> Currenlty only legacy and vecotred interrupt modes are supported.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/mips/include/asm/gic.h |  15 ++++++
>  arch/mips/kernel/irq-gic.c  | 122 +++++++++++++++++++++++++++++++++++++++++++-
> 


Can you move this to drivers/irqchip and use the IRQCHIP_DECLARE()
macro to define the entry point?

	Arnd
