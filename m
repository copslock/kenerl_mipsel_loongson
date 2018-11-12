Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 15:20:32 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990398AbeKLOSfoxFW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 15:18:35 +0100
Date:   Mon, 12 Nov 2018 14:18:35 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MIPS: SiByte: Handle PCI DMA with 64-bit memory
 addressing
Message-ID: <alpine.LFD.2.21.1811121413230.9637@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

 This mini patch series enables correct support for DMA in the presence of 
memory outside the 32-bit address range with the Broadcom SiByte SOCs and 
the relevant development boards.

 There is a quirk in the BCM1250, BCM1125 and BCM1125H SOCs in that their 
onchip 32-bit PCI host bridge does not support DAC, however the HT link 
(where available) does support 40-bit addressing as per the HT spec.  
Therefore the first patch sets the bus mask accordingly, and then the 
second patch enables swiotlb.  See individual change descriptions for 
additional details; there's also a further discussion alongside.

 This has been verified with a Broadcom SWARM board equipped with 3200MiB 
of RAM (2176MiB of which the address decoder in the SOC maps above 4GiB), 
a pair of DEFPA FDDI adapters and an XHCI USB adapter.  There were also 
some other PCI and PCIe devices present in the system, though not actively 
used beyond being probed at boot, and none has shown any symptoms of 
breakage.

 This v2 of the series updates the original one according to feedback 
received from Christoph Hellwig.

 Please apply.

  Maciej
