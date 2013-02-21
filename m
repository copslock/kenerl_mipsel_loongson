Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2013 12:28:55 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:51457 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827542Ab3BUPqQTy8pj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Feb 2013 16:46:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 9518A56F5F6;
        Thu, 21 Feb 2013 17:46:15 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id poeBTS-V-lWL; Thu, 21 Feb 2013 17:46:14 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 759C65BC010;
        Thu, 21 Feb 2013 17:46:13 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Thu, 21 Feb 2013 17:46:12 +0200
Date:   Thu, 21 Feb 2013 17:46:12 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Patrik, Kluba" <pkluba@dension.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: bug: keep_bootcon and early printk together can lead to
 (invisible) kernel panic
Message-ID: <20130221154612.GA11617@blackmetal.musicnaut.iki.fi>
References: <20130221153717.31400a88.pkluba@dension.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130221153717.31400a88.pkluba@dension.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35805
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Feb 21, 2013 at 03:37:17PM +0100, Patrik, Kluba wrote:
> I had a silent lockup on one of our embedded system under development.
> It was not easy to track it down, so here's what I discovered, in case
> somebody runs into similar trouble.
> Using 'keep_bootcon' command line parameter, and enabling early printk
> can lead to a kernel panic. At least on MIPS, it does. The problem is
> that in arch/mips/kernel/early_printk.c everything is declared as
> __init and __initdata, so they are being freed, when the kernel
> frees .init.* sections. If 'keep_bootcon' is given, the early console
> does not get unregistered, and the entry in the console_drivers list
> can point (will, believe me) to garbage data. It's up to you to imagine
> the effects...

I also ran into this recently, this should fix it:

	http://marc.info/?l=linux-kernel&m=136062078931024&w=2

A.
