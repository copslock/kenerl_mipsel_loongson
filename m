Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:28:01 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4030 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817975Ab3FJH1Kb10vF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:27:10 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:23:16 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:26:55 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:26:55 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 03F24F2D72; Mon, 10
 Jun 2013 00:26:53 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 0/2] SWIOTLB support for Netlogic XLP
Date:   Mon, 10 Jun 2013 12:58:07 +0530
Message-ID: <1370849289-4877-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7DABA16E31W33899119-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Two patches for using the SWIOTLB lib in Netlogic XLP code.

The first one adds support for SWIOTLB in generic MIPS operations.
Without this platforms cannot use generic MIPS dma ops when SWIOTLB
is enabled.  The second adds SWIOTLB based dma ops for Netlogic XLP,
which will be used by a few drivers which cannot do 64-bit DMA.

Comments welcome.

Regards,
JC.


Ganesan Ramalingam (1):
  MIPS: Netlogic: SWIOTLB dma ops for 32-bit DMA

Jayachandran C (1):
  MIPS: Support SWIOTLB in default dma operations

 arch/mips/include/asm/mach-generic/dma-coherence.h |   12 +++
 arch/mips/include/asm/netlogic/common.h            |    3 +
 arch/mips/mm/dma-default.c                         |    3 +
 arch/mips/netlogic/Kconfig                         |   11 ++
 arch/mips/netlogic/common/Makefile                 |    1 +
 arch/mips/netlogic/common/nlm-dma.c                |  107 ++++++++++++++++++++
 6 files changed, 137 insertions(+)
 create mode 100644 arch/mips/netlogic/common/nlm-dma.c

-- 
1.7.9.5
