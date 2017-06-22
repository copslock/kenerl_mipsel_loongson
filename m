Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 15:42:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58332 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991867AbdFVNmnjHk9q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jun 2017 15:42:43 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5MCoXqX029317;
        Thu, 22 Jun 2017 14:50:33 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5MCoOPP029313;
        Thu, 22 Jun 2017 14:50:24 +0200
Date:   Thu, 22 Jun 2017 14:50:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix a long-standing mistake in mips_atomic_set()
Message-ID: <20170622125024.GB9002@linux-mips.org>
References: <1498128345-6827-1-git-send-email-chenhc@lemote.com>
 <20170622123159.GA31455@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622123159.GA31455@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58744
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

On Thu, Jun 22, 2017 at 01:31:59PM +0100, James Hogan wrote:

> Hi Huacai,
> 
> On Thu, Jun 22, 2017 at 06:45:45PM +0800, Huacai Chen wrote:
> > This mistake comes from the commit f1e39a4a616cd99 ("MIPS: Rewrite
> > sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler"). In the
> > common case 'bnez' should be 'beqz' (as same as older kernels before
> > 2.6.32), otherwise this syscall may cause an endless loop.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> 
> Thats a coincidence. 8 years its been broken and I submitted an
> identical patch only a few weeks ago, along with some other related
> fixes:
> 
> https://patchwork.linux-mips.org/project/linux-mips/list/?series=313&state=*

I take it as a proof that everybody is using LL/SC (or the LL/SC emulation)
these days and sysmips(MIPS_ATOMIC_SET) finally has been obsoleted and is
only useful for stoneage binary compatibility.

Which is really good.  Unless people are using silly hacks such as $k0/$k1
being overwriten by exception handlers ...

  Ralf
