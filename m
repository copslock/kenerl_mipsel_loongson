Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 19:11:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48874 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993917AbdH1RLDR5Q2u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2017 19:11:03 +0200
Date:   Mon, 28 Aug 2017 18:11:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Fredrik Noring <noring@nocrew.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <20170828135305.GA20466@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1708281808190.30639@eddie.linux-mips.org>
References: <20170827132309.GA32166@localhost.localdomain> <20170828135305.GA20466@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59836
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

On Mon, 28 Aug 2017, Ralf Baechle wrote:

> > Signed-off-by: Fredrik Noring <noring@nocrew.org>
> > ---
> >  arch/mips/Kconfig                | 13 +++++++++++++
> >  arch/mips/include/asm/cpu-type.h |  4 ++++
> >  arch/mips/include/asm/cpu.h      |  6 ++++++
> >  arch/mips/include/asm/module.h   |  2 ++
> >  arch/mips/kernel/cpu-probe.c     | 10 ++++++++++
> >  5 files changed, 35 insertions(+)
> 
> Patch is looking perfect at a glance but without support for an R5900
> system that is the PS2 it kinda pointless so I'd like to wait and
> review and apply everything at once.

 I've had some concerns anyway though, which I'll post tomorrow (as 
today's a UK bank holiday).

  Maciej
