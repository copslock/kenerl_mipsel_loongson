Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Dec 2012 01:23:27 +0100 (CET)
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:50834
        "EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828008Ab2LAAXZ200cC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Dec 2012 01:23:25 +0100
Received: from mail15-db3-R.bigfish.com (10.3.81.237) by
 DB3EHSOBE010.bigfish.com (10.3.84.30) with Microsoft SMTP Server id
 14.1.225.23; Sat, 1 Dec 2012 00:23:17 +0000
Received: from mail15-db3 (localhost [127.0.0.1])       by mail15-db3-R.bigfish.com
 (Postfix) with ESMTP id 68520480094;   Sat,  1 Dec 2012 00:23:17 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.240.213;KIP:(null);UIP:(null);IPV:NLI;H:BL2PRD0711HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 0
X-BigFish: PS0(zz936eIzz1de0h1202h1d1ah1d2ahzz177df4h8275eh17326ah8275dha1495iz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1155h)
Received: from mail15-db3 (localhost.localdomain [127.0.0.1]) by mail15-db3
 (MessageSwitch) id 1354321395192378_4310; Sat,  1 Dec 2012 00:23:15 +0000
 (UTC)
Received: from DB3EHSMHS018.bigfish.com (unknown [10.3.81.252]) by
 mail15-db3.bigfish.com (Postfix) with ESMTP id 2D1902E0054;    Sat,  1 Dec 2012
 00:23:15 +0000 (UTC)
Received: from BL2PRD0711HT002.namprd07.prod.outlook.com (157.56.240.213) by
 DB3EHSMHS018.bigfish.com (10.3.87.118) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Sat, 1 Dec 2012 00:23:09 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.104.165) with Microsoft SMTP Server (TLS) id 14.16.239.5; Sat, 1 Dec
 2012 00:23:09 +0000
Message-ID: <50B94DEB.3020608@caviumnetworks.com>
Date:   Fri, 30 Nov 2012 16:23:07 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Pull request for v3.8 Octeon specific changes.
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 35164
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

The ATA changes are alredy Acked-by the ATA mainainer.

The EDAC changes are just an extension of what you added for 3.8, they
were sent to the EDAC list here:

http://marc.info/?l=linux-edac&m=135302283022318&w=2

But no response yet.  My reasoning is that they should be OK as they
just improve things that only touch OCTEON.

The following changes since commit fbb3876de77cd31739fbca01bd82a1bc56e2ed5e:

   Merge branch 'mips-next' of http://dev.phrozen.org/githttp/mips-next 
into mips-for-linux-next (2012-11-30 17:34:25 +0100)

are available in the git repository at:


   git://git.linux-mips.org/pub/scm/daney/upstream-daney.git octeon-for-3.8

for you to fetch changes up to d2eb0719add2c471adf1ffb116e38bd5776c66d5:

   MIPS/EDAC: Improve OCTEON EDAC support. (2012-11-30 15:32:11 -0800)

----------------------------------------------------------------
David Daney (5):
       MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.
       ata: pata_octeon_cf: Use correct byte order for DMA in when built 
little-endian.
       MIPS: OCTEON: Add OCTEON family defintions to octeon-model.h
       MIPS: OCTEON: Add definitions for OCTEON memory contoller registers.
       MIPS/EDAC: Improve OCTEON EDAC support.

  arch/mips/cavium-octeon/octeon-irq.c           |    1 -
  arch/mips/cavium-octeon/octeon-platform.c      |  102 -
  arch/mips/cavium-octeon/setup.c                |   30 +-
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
  15 files changed, 4157 insertions(+), 581 deletions(-)
  create mode 100644 arch/mips/include/asm/octeon/cvmx-lmcx-defs.h
  delete mode 100644 drivers/edac/octeon_edac-lmc.h
