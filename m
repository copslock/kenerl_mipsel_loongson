Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2018 13:50:08 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994586AbeJBLuAvKkbM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2018 13:50:00 +0200
Date:   Tue, 2 Oct 2018 12:50:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPS: memset: Fix `noreorder' issues
Message-ID: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66656
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

 A recent change broke CPU_DADDI_WORKAROUNDS support in memset.S, due to a 
delay-slot instruction expanding to multiple hardware operations for the 
affected configurations.

 The underlying cause is the excessive use of the `noreorder' assembly 
mode, while it is only needed in couple of places where either there is a 
data dependency between a branch and its delay slot instruction, or there 
is a section switch involved that would prevent automatic delay slot 
scheduling.

 These changes address both problems and for clarity, not to mix multiple 
conceptually separate changes and to make backporting easier I made them a 
small patch series.  See individual change descriptions for details.

 This has been build-time and run-time verified with 32-bit and 64-bit 
DECstation configurations, build-time verified with big-endian and 
little-endian 64-bit SWARM configurations.  Build-time verification was 
made by running `objdump -d arch/mips/lib/memset.o' with a pristine and 
and a patched build to make sure there has been no change in machine code 
generation, except for the delay-slot multiple instruction with the 64-bit 
CPU_DADDI_WORKAROUNDS DECstation configuration.

 Please apply.

  Maciej
