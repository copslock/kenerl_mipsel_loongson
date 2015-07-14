Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 13:58:24 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57437 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009249AbbGNL6WeX1U0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 13:58:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 79F78284DFE
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 13:57:59 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com [209.85.192.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 2A422280906
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 13:57:53 +0200 (CEST)
Received: by qgef3 with SMTP id f3so2880973qge.0
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 04:58:14 -0700 (PDT)
X-Received: by 10.55.41.229 with SMTP id p98mr33570072qkp.99.1436875094325;
 Tue, 14 Jul 2015 04:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.82.200 with HTTP; Tue, 14 Jul 2015 04:57:54 -0700 (PDT)
In-Reply-To: <1436865969-2977-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-15-git-send-email-markos.chandras@imgtec.com> <1436865969-2977-1-git-send-email-markos.chandras@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 14 Jul 2015 13:57:54 +0200
Message-ID: <CAOiHx=nk21aCw-ZFQJDrPX2W29e5GNZ1s5huFwpJ8b0+88BrTw@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] drivers: irqchip: irq-mips-gic: Extend GIC
 accessors for 64-bit CMs
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48268
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

Hi,

On Tue, Jul 14, 2015 at 11:26 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> Previously, the GIC accessors were only accessing u32 registers but
> newer CMs may actually be 64-bit on MIPS64 cores. As a result of which,
> extended these accessors to support 64-bit reads and writes.

Have you tested this with a 32-bit build? IIRC the *q accessors are
only available on 64-bit builds.


Jonas
