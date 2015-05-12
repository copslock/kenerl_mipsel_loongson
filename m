Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 00:35:20 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27010776AbbELWfSNofl0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 00:35:18 +0200
Date:   Tue, 12 May 2015 23:35:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Paul Martin <paul.martin@codethink.co.uk>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Fix a preemption issue with thread's FPU
 defaults
In-Reply-To: <20150512211443.GA21142@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505122237400.1538@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1505121432540.1538@eddie.linux-mips.org> <20150512211443.GA21142@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47355
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

On Tue, 12 May 2015, Ralf Baechle wrote:

> On systems with multiple types of FPUs this would also result in a
> more consistent behaviour when a process is scheduled between different
> CPUs.

 Hmm, do we support SMP systems where individual FPUs (or CPUs, for that 
matter) are different significantly enough to matter?  E.g. anyhow 
beyond FIR[15:0], that the relevant machine instructions read directly 
from hardware where implemented anyway (and likewise FCSR).

 I think eventually we should migrate properties that have to be uniform 
across all the CPUs in a SMP system outside the per-CPU `cpu_data' array 
and have a single global copy only.  This will include the ISA level, 
some options like the exception and cache model (not the particular 
topology though), VM size, etc.

 I think this FPU (and also MSA, specifically `msa_id') stuff will 
belong there as well, unless proven otherwise.  That is unless we have a 
mixed system really available in the first place (QEMU does not count, 
sorry) or one is at least is being considered, and then we actually want 
to support it beyond finding the common set of features across all the 
CPUs and limiting userland to using them only (well, if limiting would 
at all be possible, that is, via appropriate knobs requiring privilege 
to control).

  Maciej
