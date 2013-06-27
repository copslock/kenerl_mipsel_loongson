Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 02:01:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50375 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835016Ab3F0AAE2sVmP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 02:00:04 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5R001Up005031;
        Thu, 27 Jun 2013 02:00:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5R001DB005030;
        Thu, 27 Jun 2013 02:00:01 +0200
Date:   Thu, 27 Jun 2013 02:00:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] Use scratch registers when MIPS_PGD_C0_CONTEXT is
 not set
Message-ID: <20130627000001.GP7171@linux-mips.org>
References: <1372011381-18600-1-git-send-email-jchandra@broadcom.com>
 <51CB79BB.9090905@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51CB79BB.9090905@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Jun 26, 2013 at 06:31:07PM -0500, Steven J. Hill wrote:

> >Jayachandran C (3):
> >   MIPS: Move generated code to .text for microMIPS
> >   MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
> >   MIPS: Move definition of SMP processor id register to header file
> >
> >  arch/mips/include/asm/mmu_context.h |   28 ++---
> >  arch/mips/include/asm/stackframe.h  |   24 +---
> >  arch/mips/include/asm/thread_info.h |   33 +++++-
> >  arch/mips/mm/Makefile               |    2 +-
> >  arch/mips/mm/tlb-funcs.S            |   37 ++++++
> >  arch/mips/mm/tlbex.c                |  224 ++++++++++++++++-------------------
> >  6 files changed, 187 insertions(+), 161 deletions(-)
> >  create mode 100644 arch/mips/mm/tlb-funcs.S
> >
> The microMIPS kernel compiles, but fails to boot. It stops at:
> 
>    Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> 
> and does not go any further. I will look at this later this evening.

I'll leave the series applied for now then.

  Ralf
