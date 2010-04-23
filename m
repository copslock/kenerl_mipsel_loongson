Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 09:31:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58065 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491909Ab0DWHbf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Apr 2010 09:31:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3N7VP1m006598;
        Fri, 23 Apr 2010 08:31:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3N7VOlq006587;
        Fri, 23 Apr 2010 08:31:24 +0100
Date:   Fri, 23 Apr 2010 08:31:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     tbm@cyrius.com, linux-mips@linux-mips.org
Subject: Re: mips: enable PATA platform on SWARM and LITTLESUR
Message-ID: <20100423073123.GA6052@linux-mips.org>
References: <20100418132636.GA32350@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100418132636.GA32350@Chamillionaire.breakpoint.cc>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 18, 2010 at 03:26:36PM +0200, Sebastian Andrzej Siewior wrote:

> according to include/asm/sibyte/swarm.h both systems provide a
> platform device for the ide controler. Until now the IDE subsystem was
> used which is deprecated by now. The same structure can be used with the
> PATA driver.
> This was tested on SWARM.

Thanks, applied.

  Ralf
