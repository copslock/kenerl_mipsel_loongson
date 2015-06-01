Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 21:53:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46914 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026890AbbFATxs5I0b4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jun 2015 21:53:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t51JrgR4003652;
        Mon, 1 Jun 2015 21:53:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t51JrdOg003651;
        Mon, 1 Jun 2015 21:53:39 +0200
Date:   Mon, 1 Jun 2015 21:53:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Valentin Rothberg <valentinrothberg@gmail.com>
Cc:     Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <andreas.ruprecht@fau.de>,
        hengelein Stefan <stefan.hengelein@fau.de>, tglx@linutronix.de,
        jason@lakedaemon.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: MIPS/IRQCHIP: some remainders of IRQ_CPU
Message-ID: <20150601195339.GB29986@linux-mips.org>
References: <CAD3Xx4K_qq-FZPymp4Ss7rG2FC4iK3TF1sJnBMO+7haMFN_wFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD3Xx4K_qq-FZPymp4Ss7rG2FC4iK3TF1sJnBMO+7haMFN_wFg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47767
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

On Mon, Jun 01, 2015 at 04:51:48PM +0200, Valentin Rothberg wrote:

> Hi Ralf,
> 
> your commit 1f1786e60b53 ("MIPS/IRQCHIP: Move irq_chip from arch/mips
> to drivers/irqchip.") is in today's linux-next tree (i.e.,
> next-20150601).  It renames the Kconfig option IRQ_CPU to
> IRQ_MIPS_CPU, but misses to rename a few Kconfig selects (see git
> grep) in arch/mips.
> 
> If you agree, I can send a trivial patch that renames those remainders?

sed -i -e 's@\bIRQ_CPU\b@IRQ_MIPS_CPU@' $(git grep -l -w IRQ_CPU)

or something like that.

> I detected the issue with ./scripts/checkkconfigsymbols.py by diffing
> the last and today's linux tree.
> 
> Some advertisement for a small tool I started a few month a go, which
> is made for such cases.  With vgrep [1] you can grep for symbols in
> the current directory tree and afterwards open specific lines in your
> editor.  It's more or less a comfortable wrapper around (git) grep.  I
> use it a lot to study source code as well as to manage code changes.
> The most prominent user I know is Greg KH who uses it as a replacement
> for cgvg.
> 
> Kind regards,
>  Valentin
> 
> [1] https://github.com/vrothberg/vgrep

Thanks for reporting!

  Ralf
