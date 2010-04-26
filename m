Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 22:25:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44031 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491823Ab0DZUZI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Apr 2010 22:25:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3QKP0qY027704;
        Mon, 26 Apr 2010 21:25:00 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3QKOxeV027702;
        Mon, 26 Apr 2010 21:24:59 +0100
Date:   Mon, 26 Apr 2010 21:24:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC] net/sb1250: setup the pdevice within the soc code
Message-ID: <20100426202459.GD27656@linux-mips.org>
References: <20100426195229.GB22245@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100426195229.GB22245@Chamillionaire.breakpoint.cc>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 26, 2010 at 09:52:29PM +0200, Sebastian Andrzej Siewior wrote:

> doing it within the driver does not look good.
> 
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
> Ralf, if you fine with then I'm gonna to post it at netdev.
> 
>  arch/mips/sibyte/sb1250/setup.c |   55 ++++++++++++++++++
>  drivers/net/sb1250-mac.c        |  120 +--------------------------------------

Almost.  The idea is right but the driver is also being used by the
BCM1480-based platforms.  So either arch/mips/sibyte/bcm1480/setup.c
needs the same changes or - and better - you change
arch/mips/sibyte/swarm/platform.c instead.  Despite the swarm in the
path name that file is being used also for all other currently supported
Sibyte platforms.

  Ralf
