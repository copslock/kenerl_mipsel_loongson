Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 02:37:00 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994248AbeJHAgz10KrL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 02:36:55 +0200
Date:   Mon, 8 Oct 2018 01:36:55 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] MIPS: Ordering enforcement fixes for MMIO accessors
Message-ID: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66716
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

 This patch series is a follow-up to my earlier consideration about MMIO 
access ordering recorded here: <https://lkml.org/lkml/2014/4/28/201>.

 As I have learnt in a recent Alpha/Linux discussion starting here: 
<https://marc.info/?i=alpine.LRH.2.02.1808161556450.13597%20()%20file01%20!%20intranet%20!%20prod%20!%20int%20!%20rdu2%20!%20redhat%20!%20com> 
related to MMIO accessor ordering barriers ports are actually required to 
follow the x86 strongly ordered semantics.  As the ordering is not 
specified in the MIPS architecture except for the SYNC instruction we do 
have to put explicit barriers in MMIO accessors as otherwise ordering may 
not be guaranteed.

 Fortunately on strongly ordered systems SYNC is expected to be as cheap 
as a NOP, and on weakly ordered ones it is needed anyway.  As from 
revision 2.60 of the MIPS architecture specification however we have a 
number of SYNC operations defined, and SYNC 0 has been upgraded from an 
ordering to a completion barrier.  We currently don't make use of these 
extra operations and always use SYNC 0 instead, which this means that we 
may be doing too much synchronisation with the barriers we have already 
defined.

 This patch series does not make an attempt to optimise for SYNC operation 
use, which belongs to a separate improvement.  Instead it focuses on 
fixing MMIO accesses so that drivers can rely on our own API definition.

 Following the original consideration specific MMIO barrier operations are 
added.  As they have turned out to be required to be implied by MMIO 
accessors there is no immediate need to make them form a generic 
cross-architecture internal Linux API.  Therefore I defined them for the 
MIPS architecture only, using the names originally coined by mostly taking 
them from the PowerPC port.

 Then I have used them to fix `mmiowb', and then `readX' and `writeX' 
accessors.  Finally I have updated the `_relaxed' accessors to avoid 
unnecessary synchronisation WRT DMA.

 See individual commit descriptions for further details.

 As a follow-up clean-up places across the architecture tree could be 
reviewed for barrier use that is actually related to MMIO rather than 
memory and updated to use the new names of the MMIO barrier operations.  I 
plan to do this for the DECstation and possibly the SiByte platform, 
however I am leaving it for someone else to do it elsewhere.

 Similarly I think the DMA barrier in `readX' and `inX' should be using 
`dma_rmb' rather than `rmb', but I'm leaving it for someone else to 
handle.

 These changes have been verified at run time with an R3000 (MIPS I) 
DECstation machine (32-bit kernel, little endianness), an R4400 (MIPS III) 
DECstation machine (64-bit kernel, little endianness) and an SB-1 (MIPS64) 
SWARM machine (64-bit kernel, big endianness), by booting them into the 
multiuser mode and running them for a couple of hours.

 Please apply.

  Maciej
