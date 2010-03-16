Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 18:34:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55168 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492423Ab0CPReG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Mar 2010 18:34:06 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2GHY2re004509;
        Tue, 16 Mar 2010 18:34:03 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2GHY03S004501;
        Tue, 16 Mar 2010 18:34:00 +0100
Date:   Tue, 16 Mar 2010 18:33:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Ferber <af@chaos-agency.de>
Cc:     Markus Wigge <markus@cultcom.de>, Michael Buesch <mb@bu3sch.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: Fix SSB PCIcore IO resource management
Message-ID: <20100316173359.GB20160@linux-mips.org>
References: <20100316113551.GB19241@marcant.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100316113551.GB19241@marcant.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 16, 2010 at 12:35:51PM +0100, Andreas Ferber wrote:

> The SSB PCIcore code reused the IO resource fixup code from the original
> 2.4.x Broadcom patch for BCM47xx based devices, which was a quick hack
> for doing PCI IO resource configuration back then (the boot loader
> doesn't configure PCI devices on this platform).
> 
> However, this code is no longer necessary since the kernel now can do
> PCI resource management fine all by itself, so remove the old code.
> 
> When removing the code, it becomes obvious that the mem_offset setting
> in the PCIcore driver was wrong, however this was masked by the fixup
> code before, except in a few cases involving yenta_socket. For
> BCM47xx, the correct offset is 0, and since this is the only device
> using PCIcore in host mode, the offset can simply be removed
> unconditionally.

Thanks, applied.

  Ralf
