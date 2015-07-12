Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 00:01:56 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34170 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010172AbbGLWBzAoH52 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 00:01:55 +0200
Received: by igvi1 with SMTP id i1so20372277igv.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=vm+llnLKuJ98kWsRukKf4ELJz+mj1f+Wk9P4dgdlL2A=;
        b=JFUmISTSl80ujcZafLRQnswcfIhluszmB64GDxvBcLsyFhu0ukEZcZQ3DK7G7X4ce6
         1YCjVPeOY/KlftBkce7YCBO4vXcsBf0kB8V4cmuMFvMBId8m2Uq6qQWFoxTcV9fYYueq
         ylZWt2mwsdcBiPheFiOMgP5zY1mH7FLxg3bl1HNnUnu/e8+JpJ7jO1bon2DCg4VMQ/jl
         2WbDp1bYnTFLOZWC+mwnBEs2vemeKRLGFp5MYvEkIHwnaT6daLoleX3WFLiJSV9gKW9z
         nRqXqk5X1ZcO+GwybMXiHF7Qtj5DKr1nP64BMmc1v38xtVlapAU1ki3bwk6QDbVMJD9L
         gBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=vm+llnLKuJ98kWsRukKf4ELJz+mj1f+Wk9P4dgdlL2A=;
        b=DWqIJBbmvwqXGQ72/3Pv+FhaQ0qU9Gh4ydCbA3DmBK4+moCiYSQD6OMRZgQkFKysmH
         REzCH8VuEWUsKv5GVoH+2OHChRBGRPq+7mZ3uKLFDf8XPrbYnCXrXnTFGZNJhjcT7vjA
         1uA2BEi+nFolmjSk9eczBwJXpPYjtdtYyVNGIVRR9r5Iq6AW4W5MFwOZRovOjA8u80b3
         ZTBztpsXQSauBCciDdEX1XakVsHD27bzQHSMy47JfFpnQ24x2J/U0teEB4quHW1dP8ba
         na974ux6xUgGLWHwTZ8Br1ynYDNQNHxE4wRbjiWMfWtUPBkh980GfJbLZc5zTgfGVgBZ
         cqlA==
X-Gm-Message-State: ALoCoQlPG/NjmEHk9H8a7M+KTpofamQ4EovKcaxuFwdNk+eywkHqX9xhmy0XT1CP8en5inxUgTe2
X-Received: by 10.107.148.8 with SMTP id w8mr16540433iod.116.1436738508793;
        Sun, 12 Jul 2015 15:01:48 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id ot6sm4382643igb.11.2015.07.12.15.01.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 15:01:47 -0700 (PDT)
Subject: [PATCH 0/3] IRQ trivial clarifications
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-alpha@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Sun, 12 Jul 2015 17:01:45 -0500
Message-ID: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

These don't fix anything at all.  But they might make code understanding
and debugging slightly easier.

---

Bjorn Helgaas (3):
      x86, irq: Rename VECTOR_UNDEFINED and VECTOR_RETRIGGERED to IRQ_*
      x86, irq: Clarify "No irq handler" message
      IRQ: Print "unexpected IRQ" messages consistently across architectures


 arch/alpha/kernel/irq.c            |    2 +-
 arch/blackfin/kernel/irqchip.c     |    2 +-
 arch/c6x/kernel/irq.c              |    2 +-
 arch/ia64/kernel/irq.c             |    2 +-
 arch/m68k/include/asm/hardirq.h    |    2 +-
 arch/mips/kernel/irq.c             |    2 +-
 arch/mn10300/kernel/irq.c          |    2 +-
 arch/parisc/include/asm/hardirq.h  |    2 +-
 arch/powerpc/include/asm/hardirq.h |    2 +-
 arch/s390/include/asm/hardirq.h    |    2 +-
 arch/sh/kernel/irq.c               |    2 +-
 arch/tile/kernel/irq.c             |    2 +-
 arch/x86/include/asm/hw_irq.h      |    4 ++--
 arch/x86/kernel/apic/vector.c      |   14 +++++++-------
 arch/x86/kernel/irq.c              |   19 +++++++++----------
 arch/x86/kernel/irqinit.c          |    4 ++--
 include/asm-generic/hardirq.h      |    2 +-
 17 files changed, 33 insertions(+), 34 deletions(-)
