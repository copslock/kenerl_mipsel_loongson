Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 11:54:04 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490970Ab0IIJyB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Sep 2010 11:54:01 +0200
Date:   Thu, 9 Sep 2010 11:53:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: Allow UserLocal on MIPS_R1 processors
Message-ID: <20100909095359.GA27815@linux-mips.org>
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>
 <d57a8d9cc346a9235a93e528beac4c40@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57a8d9cc346a9235a93e528beac4c40@localhost>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7083

On Wed, Sep 08, 2010 at 04:02:14PM -0700, Kevin Cernekee wrote:

> Some MIPS32R1 processors implement UserLocal (RDHWR $29) to accelerate
> programs that make extensive use of thread-local storage.  Therefore,
> setting up the HWRENA register should not depend on cpu_has_mips_r2.

Interesting - which R1 processor has RDHWR?  When UserLocal was conceived
R2 was already long released.

  Ralf
