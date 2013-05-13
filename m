Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 May 2013 23:03:19 +0200 (CEST)
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:31757
        "EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823114Ab3EMVDRQ3Kdv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 May 2013 23:03:17 +0200
Received: from mail131-ch1-R.bigfish.com (10.43.68.249) by
 CH1EHSOBE002.bigfish.com (10.43.70.52) with Microsoft SMTP Server id
 14.1.225.23; Mon, 13 May 2013 21:03:10 +0000
Received: from mail131-ch1 (localhost [127.0.0.1])      by
 mail131-ch1-R.bigfish.com (Postfix) with ESMTP id C5829410A3;  Mon, 13 May
 2013 21:03:10 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.1.197;KIP:(null);UIP:(null);IPV:NLI;H:BLUPRD0712HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 0
X-BigFish: PS0(zz936eIzz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275dhz2dh2a8h668h839h947he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1889i1155h)
Received: from mail131-ch1 (localhost.localdomain [127.0.0.1]) by mail131-ch1
 (MessageSwitch) id 1368478988310061_21717; Mon, 13 May 2013 21:03:08 +0000
 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])        by mail131-ch1.bigfish.com (Postfix) with ESMTP id
 4930926005F;   Mon, 13 May 2013 21:03:07 +0000 (UTC)
Received: from BLUPRD0712HT002.namprd07.prod.outlook.com (132.245.1.197) by
 CH1EHSMHS004.bigfish.com (10.43.70.4) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Mon, 13 May 2013 21:03:06 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.163) with Microsoft SMTP Server (TLS) id 14.16.305.3; Mon, 13 May
 2013 21:03:06 +0000
Message-ID: <51915508.7080205@caviumnetworks.com>
Date:   Mon, 13 May 2013 14:03:04 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Pull request for MIPS v3.10-rc1 fixes.
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36398
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

The following changes since commit 1f638766ffcd9f08209afcabb3e2df961552fe18:

   Merge tag 'spi-v3.10-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2013-05-13 
08:12:18 -0700)

are available in the git repository at:


   git://git.linux-mips.org/pub/scm/daney/upstream-daney.git dd-3.10-rc1

for you to fetch changes up to aea277b5753da8346147912eac2b21c09f1246f6:

   MIPS: Make virt_to_phys() work for all unmapped addresses. 
(2013-05-13 13:38:15 -0700)


These are four patches that are on the mailing list and are required
to boot on OCTEON.  All packaged for a hopefully easy pull.

David Daney

----------------------------------------------------------------
David Daney (3):
       Revert "MIPS: microMIPS: Support dynamic ASID sizing."
       Revert "MIPS: Allow ASID size to be determined at boot time."
       MIPS: Make virt_to_phys() work for all unmapped addresses.

Thomas Gleixner (1):
       MIPS: Enable interrupts in arch_cpu_idle()

  arch/mips/include/asm/io.h          |  2 +-
  arch/mips/include/asm/mmu_context.h | 95 
++++++++++++++-----------------------
  arch/mips/include/asm/page.h        |  2 +-
  arch/mips/kernel/genex.S            |  2 +-
  arch/mips/kernel/process.c          | 13 +++--
  arch/mips/kernel/smtc.c             | 10 ++--
  arch/mips/kernel/traps.c            |  6 +--
  arch/mips/lib/dump_tlb.c            |  5 +-
  arch/mips/lib/r3k_dump_tlb.c        |  7 ++-
  arch/mips/mm/tlb-r3k.c              | 20 ++++----
  arch/mips/mm/tlb-r4k.c              |  2 +-
  arch/mips/mm/tlb-r8k.c              |  2 +-
  arch/mips/mm/tlbex.c                | 79 ------------------------------
  13 files changed, 71 insertions(+), 174 deletions(-)
