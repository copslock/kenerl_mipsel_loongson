Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 20:54:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38735 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824787Ab3FHSyafCuhm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 20:54:30 +0200
Date:   Sat, 8 Jun 2013 19:54:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: DEC: remove unbuildable promcon.c
In-Reply-To: <1369909215.23034.39.camel@x61.thuisdomein>
Message-ID: <alpine.LFD.2.03.1306081950280.21418@linux-mips.org>
References: <1369909215.23034.39.camel@x61.thuisdomein>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36754
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

On Thu, 30 May 2013, Paul Bolle wrote:

> promcon.o is built if CONFIG_PROM_CONSOLE is set. But there's no Kconfig
> symbol PROM_CONSOLE, so promcon.c is unbuildable. Remove it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
> 
> 1) There used to be a Kconfig symbol PROM_CONSOLE. But it was SPARC
> specific and it was removed in v2.6.32, see commit 09d3f3f0e0 ("sparc:
> Kill PROM console driver.").
> 
> 2) Actually, it seems that it has never been possible to set
> PROM_CONSOLE for MIPS ever since this file was added in v2.3.9. I guess
> no-one noticed because (what seems to be) comparable functionality is
> provided in arch/mips/dec/prom/console.c.

 Yeah, I think over the years the file mostly served documentation 
purposes.  Given that we've had (as you also noticed) a working early-boot 
console available:

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 Thanks for this clean-up.

  Maciej
