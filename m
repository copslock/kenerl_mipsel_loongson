Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2009 03:00:24 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:27869 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1492462AbZFSBAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2009 03:00:17 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Kconfig oversight for BCM1480: no CPU_HAS_PREFETCH.
Date:	Thu, 18 Jun 2009 17:58:18 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501C34B35@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kconfig oversight for BCM1480: no CPU_HAS_PREFETCH.
Thread-Index: AcnweQjmaZapUOePQOuxtDIdAiOGsQ==
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hi All,

Ther is no ``select CPU_HAS_PREFETCH'' for the BCM1480 based boards,
and no prompt to enable it.  I don't think that this is intentional;
prefetch is not known to be buggy on these chips. The only chips
with known buggy prefetch are the 1250's with a Pass 2 SB-1.

I think I know how this situation came about.

Back in August 2005, Ralf made a commit which accidentally disabled
prefetch for
a bunch of CPU's like the R10000.

Subject: Get rid of the nonsense in the CONFIG_CPU_HAS_PREFETCH block.
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1f53fe8..6ab95e3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1327,8 +1327,7 @@ config SIBYTE_DMA_PAGEOPS
 	  SiByte Linux port.  Seems to give a small performance benefit.
 
 config CPU_HAS_PREFETCH
-	bool "Enable prefetches" if CPU_SB1 && !CPU_SB1_PASS_2
-	default y if CPU_MIPS32 || CPU_MIPS64 || CPU_RM7000 ||
CPU_RM9000 || CPU_R10000
+	bool
 
 config MIPS_MT
 	bool "Enable MIPS MT"



Note how the previous version provides a prompt for "Enable prefetches"
if the CPU is SB1, and the board support has selected neither
CPU_SB1_PASS_2,
nor CPU_HAS_PREFETCH.

Prior to the above patch, if you added a new kind of Sibyte chip to
arch/mips/sibyte/Kconfig, but neglected to declare CPU_HAS_PREFETCH
or CPU_SB1_PASS_2, you would have been given a prompt at configuration
time.

Now you no longer have a prompt for the SB1.

After the patch, CPU_HAS_PREFETCH is still correctly set up for the
SiByte systems, because they take care of this in the SiByte Kconfig.

The use of prefech is now missing from systems based on the R10000 and
others.

In the meanwhile, Andrew Isaacson (I surmise) was working on the BCM1480
support. 

In an October 29, 2005 commit, Ralf realizes the mistake. In a big
patch that splits up and cleans up the Kconfig, he adds the
``select CPU_HAS_PREFETCH'' to the R10000 and other CPU configs.
But of course, he does not add this to the SB1 CPU config.
Ralf is working with a kernel tree in which the Sibyte-based boards
all set up the prefetch option on a case by case basis. 
So why would he resurrect a prompt for this? If anyone adds a new
Sibyte board, they will just set this up, right?

Now Isaacson's BCM1480 patch comes right on the heels of Ralf's cleanup.
The patch neglects to set up CPU_HAS_PREFETCH. For the 1250 and 112x
boards, there are additional prompts to select the steppings,
and it's these steppings configurations that publish either
CPU_HAS_PREFETCH or CPU_SB1_PASS_2.

Isaacson would have been working against a kernel in which he didn't get
the ``Enable prefetch'' prompt any more for his new board definition
(he was probably up to the August patch), and so he wasn't alerted
to the issue.
