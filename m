Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2014 19:35:43 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:43930 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007692AbaHaRflhDHtl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Aug 2014 19:35:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D56C828BB43;
        Sun, 31 Aug 2014 19:35:22 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com [209.85.216.172])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 42BB028BB54;
        Sun, 31 Aug 2014 19:35:00 +0200 (CEST)
Received: by mail-qc0-f172.google.com with SMTP id o8so4602565qcw.3
        for <multiple recipients>; Sun, 31 Aug 2014 10:35:16 -0700 (PDT)
X-Received: by 10.140.101.145 with SMTP id u17mr36107054qge.10.1409506516066;
 Sun, 31 Aug 2014 10:35:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Sun, 31 Aug 2014 10:34:55 -0700 (PDT)
In-Reply-To: <1409350479-19108-2-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <1409350479-19108-2-git-send-email-abrestic@chromium.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 31 Aug 2014 19:34:55 +0200
Message-ID: <CAOiHx=kKzkSD7fRK+dO97HzrifBuaN4gw8XM-47Af0P077d7TQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] MIPS: Provide a generic plat_irq_dispatch
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
        Jason Cooper <jason@lakedaemon.net>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Aug 30, 2014 at 12:14 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> For platforms which boot with device-tree and use the MIPS CPU interrupt
> controller binding, a generic plat_irq_dispatch() can be used since all
> CPU interrupts should be mapped through the CPU IRQ domain.  Implement a
> plat_irq_dispatch() which simply handles the highest pending interrupt.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>

I gave this a short test by hackishly adding IRQ_DOMAIN support to
bcm63xx and removing the local plat_irq_dispatch, and it booted fine,
and cascaded interrupts were still working. Therefore

Tested-by: Jonas Gorski <jogo@openwrt.org>


Jonas
