Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 17:52:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33376 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861301AbaGPPvyYOfCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 17:51:54 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7CE8B100D7737;
        Wed, 16 Jul 2014 16:51:44 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 16 Jul
 2014 16:51:46 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 16 Jul 2014 16:51:46 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 16 Jul 2014 16:51:46 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <m.szyprowski@samsung.com>, <mina86@mina86.com>
CC:     <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-arch@vger.kernel.org>
Subject: [PATCH 0/4] mips: Add cma support to mips
Date:   Wed, 16 Jul 2014 16:51:28 +0100
Message-ID: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Here we have 4 patches that add cma support to mips.

Patch 1 adds dma-contiguous.h to asm-generic
Patch 2 and 3 make arm64 and x86 use dma-contiguous from asm-generic
Patch 4 adds cma to mips.

I'd like to request ralf to take these set of 4 patches via his tree.

acks from asm-generic, arm64 and x86 welcome.

patches based on linux-next b997a07604562f1a54cc531fe1cf7447f0ed6078

Zubair Lutfullah Kakakhel (4):
  asm-generic: Add dma-contiguous.h
  arm64: use generic dma-contiguous.h
  x86: use generic dma-contiguous.h
  mips: dma: Add cma support

 arch/arm64/include/asm/Kbuild           |  1 +
 arch/arm64/include/asm/dma-contiguous.h | 28 -------------------------
 arch/mips/Kconfig                       |  1 +
 arch/mips/include/asm/Kbuild            |  1 +
 arch/mips/kernel/setup.c                |  9 ++++++++
 arch/mips/mm/dma-default.c              | 37 ++++++++++++++++++++++-----------
 arch/x86/include/asm/Kbuild             |  1 +
 arch/x86/include/asm/dma-contiguous.h   | 12 -----------
 include/asm-generic/dma-contiguous.h    |  9 ++++++++
 9 files changed, 47 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm64/include/asm/dma-contiguous.h
 delete mode 100644 arch/x86/include/asm/dma-contiguous.h
 create mode 100644 include/asm-generic/dma-contiguous.h

-- 
1.9.1
