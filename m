Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 01:19:38 +0100 (CET)
Received: from snt0-omc2-s6.snt0.hotmail.com ([65.55.90.81]:56930 "EHLO
        snt0-omc2-s6.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816503AbaCXATgaBS44 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Mar 2014 01:19:36 +0100
Received: from SNT145-W36 ([65.55.90.71]) by snt0-omc2-s6.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Sun, 23 Mar 2014 17:19:30 -0700
X-TMN:  [sIKfB2j6wHrHoVJGy7HWRHps55OXq1S3]
X-Originating-Email: [nickkrause@sympatico.ca]
Message-ID: <SNT145-W3682AF4AA1AE6F941FDC1BA57A0@phx.gbl>
From:   Nick Krause <nickkrause@sympatico.ca>
To:     "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: PATCH[60485 Bug adding breakpoint]
Date:   Mon, 24 Mar 2014 00:19:29 +0000
Importance: Normal
In-Reply-To: <SNT145-W982FA6E38A0213DE61456DA5780@phx.gbl>
References: <SNT145-W982FA6E38A0213DE61456DA5780@phx.gbl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 24 Mar 2014 00:19:30.0137 (UTC) FILETIME=[B946FC90:01CF46F6]
Return-Path: <nickkrause@sympatico.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nickkrause@sympatico.ca
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





Here is my new patch as corrected for the the bug 60845.
https://bugzilla.kernel.org/show_bug.cgi?id=60845
This is the link to the bug and my comments / conversation on to get the corrections needed.
 Below is my patch for the bug, please let me know if it gets added finally Alan .

 --- linux-3.13.6/arch/mips/pci/msi-octeon.c.orig    2014-03-22 17:32:44.762754254 -0400
 +++ linux-3.13.6/arch/mips/pci/msi-octeon.c    2014-03-22 17:34:19.974753699 -0400
 @@ -150,6 +150,7 @@ msi_irq_allocated:
          msg.address_lo =
              ((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
          msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV)>> 32;
 +        break;
      case OCTEON_DMA_BAR_TYPE_BIG:
        /* When using big bar, Bar 0 is based at 0 */
          msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff; Signed-off-by: nickkrause@sympatico.ca
Nick


 		 	   		  
From Paul.Burton@imgtec.com Mon Mar 24 11:20:00 2014
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:20:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49249 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503AbaCXKUAcLLTm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:20:00 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2B55DDDC4CE6F
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:19:52 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 24 Mar
 2014 10:19:54 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:19:53 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:19:53 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/12] CPS SMP fixes
Date:   Mon, 24 Mar 2014 10:19:23 +0000
Message-ID: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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
Content-Length: 1487
Lines: 35

This series provides a few fixes & cleanups mostly related to the
MIPS CPS SMP implementation, fixing a few potential build errors &
allowing use on cores without the MT ASE & without CONFIG_MIPS_MT.
The final two patches fix use on big endian systems.

Paul Burton (12):
  MIPS: add cpu_vpe_id macro
  MIPS: provide empty mips_mt_set_cpuoptions when CONFIG_MIPS_MT=n
  MIPS: fix core number detection for MT cores
  MIPS: remove ifdef around core number probe
  MIPS: smp-cmp: remove incorrect core number probe
  MIPS: smp-cps: fix build when CONFIG_MIPS_MT_SMP=n
  MIPS: smp-cps: don't run MT instructions if cpu doesn't have MT
  MIPS: smp-mt: use common GIC IPI implementation
  MIPS: Malta: GIC IPIs may be used without MT
  MIPS: fix warning when including smp-ops.h with CONFIG_SMP=n
  MIPS: CM: use __raw_ memory access functions
  MIPS: CPC: use __raw_ memory access functions

 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/cpu-info.h |  6 ++++++
 arch/mips/include/asm/mips-cm.h  |  4 ++--
 arch/mips/include/asm/mips-cpc.h |  4 ++--
 arch/mips/include/asm/mips_mt.h  |  5 +++++
 arch/mips/include/asm/smp-ops.h  |  6 +++---
 arch/mips/kernel/cpu-probe.c     |  7 ++++---
 arch/mips/kernel/smp-cmp.c       |  3 +--
 arch/mips/kernel/smp-cps.c       | 14 ++++++++++----
 arch/mips/kernel/smp-mt.c        | 23 +----------------------
 arch/mips/mti-malta/malta-int.c  | 19 +++++++++++--------
 11 files changed, 46 insertions(+), 46 deletions(-)

-- 
1.8.5.3
