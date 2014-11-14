Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 17:38:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34863 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013747AbaKNQis6nvcn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 17:38:48 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAEGcj2p018773;
        Fri, 14 Nov 2014 17:38:45 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAEGciRf018772;
        Fri, 14 Nov 2014 17:38:44 +0100
Date:   Fri, 14 Nov 2014 17:38:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel}
 accessors
Message-ID: <20141114163843.GH29662@linux-mips.org>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
 <1415342669-30640-2-git-send-email-cernekee@gmail.com>
 <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44174
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

On Mon, Nov 10, 2014 at 09:13:49AM +0100, Geert Uytterhoeven wrote:

> On Fri, Nov 7, 2014 at 7:44 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> > Defining these macros way down in arch/sh/.../irq.c doesn't cause
> > kernel/irq/generic-chip.c to use them.  As far as I can tell this code
> > has no effect.
> >
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 
> Compared preprocessor and asm output before and after, no difference
> except for line numbers, so
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I noticed the remainder of of this series is now in Jason Cooper's irqchip
tree.  Is anybody still taking care of SH?  If not I can funnel it
through the MIPS tree.

  Ralf
