Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Sep 2017 14:03:51 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:51923 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991797AbdICMDhTnQr7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Sep 2017 14:03:37 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v83C2ZoB023699;
        Sun, 3 Sep 2017 07:02:37 -0500
Message-ID: <1504440154.2250.1.camel@kernel.crashing.org>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        monstr@monstr.eu,
        Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Date:   Sun, 03 Sep 2017 22:02:34 +1000
In-Reply-To: <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
         <1504390854.4974.108.camel@kernel.crashing.org>
         <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.5 (3.24.5-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Sun, 2017-09-03 at 06:43 -0400, Robert P. J. Day wrote:
>   however, given the diff stat of the change to remove every single
> reference to that node name in the current kernel source:
> 
>  arch/microblaze/kernel/prom.c | 3 +--
>  arch/mips/generic/yamon-dt.c  | 4 ----
>  arch/powerpc/boot/oflib.c     | 7 ++-----
>  drivers/of/base.c             | 2 --
>  drivers/of/fdt.c              | 5 +----
>  5 files changed, 4 insertions(+), 17 deletions(-)
> 
> it seems inconsistent that three architectures would be testing for
> that node, but none of the rest. consistency suggests that every
> architecture should take it into account, or none should.
> 
>   anyway, not a big deal, i'm fine with any decision.

powerpc is the only one of the 3 who has an actual open firmware
implementation afaik.

In any case, I think you can probably remove from microblaze and
possibly mips but I'm a bit worried about the generic case and powerpc
boot.

Cheers,
Ben.
