Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 13:00:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37030 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492058Ab0CSMAz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 13:00:55 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2JC0idh015774;
        Fri, 19 Mar 2010 13:00:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2JC0dM6015772;
        Fri, 19 Mar 2010 13:00:40 +0100
Date:   Fri, 19 Mar 2010 13:00:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/7] MIPS: bcm63xx: fix double gpio registration.
Message-ID: <20100319120037.GK4554@linux-mips.org>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
 <1264872898-28149-4-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264872898-28149-4-git-send-email-mbizon@freebox.fr>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 30, 2010 at 06:34:54PM +0100, Maxime Bizon wrote:

> bcm63xx_gpio_init is already called from prom_init to allow board to
> use them early, so we can remove the unneeded arch_initcall.

Applied, thanks.

  Ralf
