Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 00:07:24 +0100 (CET)
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:2658 "EHLO
        va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825931Ab2KOXHWqdoMy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2012 00:07:22 +0100
Received: from mail230-va3-R.bigfish.com (10.7.14.238) by
 VA3EHSOBE011.bigfish.com (10.7.40.61) with Microsoft SMTP Server id
 14.1.225.23; Thu, 15 Nov 2012 23:07:15 +0000
Received: from mail230-va3 (localhost [127.0.0.1])      by
 mail230-va3-R.bigfish.com (Postfix) with ESMTP id 41E457000E9; Thu, 15 Nov
 2012 23:07:15 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.236.133;KIP:(null);UIP:(null);IPV:NLI;H:BY2PRD0710HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -1
X-BigFish: PS-1(zz936eIzz1de0h1202h1d1ah1d2ahzz8275dhz2dh2a8h668h839hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1155h)
Received: from mail230-va3 (localhost.localdomain [127.0.0.1]) by mail230-va3
 (MessageSwitch) id 1353020833954883_382; Thu, 15 Nov 2012 23:07:13 +0000
 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.253]) by
 mail230-va3.bigfish.com (Postfix) with ESMTP id E6F9F3A003F;   Thu, 15 Nov 2012
 23:07:13 +0000 (UTC)
Received: from BY2PRD0710HT002.namprd07.prod.outlook.com (157.56.236.133) by
 VA3EHSMHS016.bigfish.com (10.7.99.26) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Thu, 15 Nov 2012 23:07:13 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.86.37) with Microsoft SMTP Server (TLS) id 14.16.233.3; Thu, 15 Nov
 2012 23:07:07 +0000
Message-ID: <50A5759A.6090109@caviumnetworks.com>
Date:   Thu, 15 Nov 2012 15:07:06 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: 3.8 pull request for OCTEON changes.
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 35019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Ralf,

A few changes for you (hopefully for 3.8)

The following changes since commit 4d72c9c50c5db19e16afa7b769ad276dfc5bc93c:

   Merge branch 'current/for-linus' into mips-for-linux-next (2012-11-15 
15:20:33 +0100)

are available in the git repository at:


   git://git.linux-mips.org/pub/scm/daney/upstream-daney.git octeon-for-next

for you to fetch changes up to d8b7a52d37e06e45b5e920216d5bf45eb3f6adca:

   MIPS/EDAC: Improve OCTEON EDAC support. (2012-11-15 13:58:59 -0800)

----------------------------------------------------------------
David Daney (6):
       MIPS: OCTEON: Remove garbage left from bad merge.
       MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.
       ata: pata_octeon_cf: Use correct byte order for DMA in when built 
little-endian.
       MIPS: OCTEON: Add OCTEON family defintions to octeon-model.h
       MIPS: OCTEON: Add definitions for OCTEON memory contoller registers.
       MIPS/EDAC: Improve OCTEON EDAC support.

  arch/mips/cavium-octeon/octeon-irq.c           |    1 -
  arch/mips/cavium-octeon/octeon-platform.c      |  102 -
  arch/mips/cavium-octeon/setup.c                |   43 +-
  arch/mips/include/asm/mach-cavium-octeon/irq.h |    1 -
  arch/mips/include/asm/octeon/cvmx-lmcx-defs.h  | 3457 
++++++++++++++++++++++++
  arch/mips/include/asm/octeon/octeon-model.h    |    6 +
  arch/mips/include/asm/octeon/octeon.h          |    7 -
  arch/mips/mm/c-octeon.c                        |   39 +-
  arch/mips/pci/pci-octeon.c                     |    3 +-
  drivers/ata/pata_octeon_cf.c                   |  423 ++-
  drivers/edac/octeon_edac-l2c.c                 |  178 +-
  drivers/edac/octeon_edac-lmc.c                 |  232 +-
  drivers/edac/octeon_edac-lmc.h                 |   78 -
  drivers/edac/octeon_edac-pc.c                  |  137 +-
  drivers/edac/octeon_edac-pci.c                 |   44 +-
  15 files changed, 4157 insertions(+), 594 deletions(-)
  create mode 100644 arch/mips/include/asm/octeon/cvmx-lmcx-defs.h
  delete mode 100644 drivers/edac/octeon_edac-lmc.h
