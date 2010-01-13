Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 14:48:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59211 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492539Ab0AMNsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jan 2010 14:48:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0DDmkt0030194;
        Wed, 13 Jan 2010 14:48:47 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0DDmiBM030192;
        Wed, 13 Jan 2010 14:48:44 +0100
Date:   Wed, 13 Jan 2010 14:48:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
Message-ID: <20100113134843.GC20354@linux-mips.org>
References: <200912121757.56365.ffainelli@freebox.fr>
 <200912150144.04051.ffainelli@freebox.fr>
 <20091215082521.GA16778@linux-mips.org>
 <200912161129.07023.ffainelli@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200912161129.07023.ffainelli@freebox.fr>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8569

On Wed, Dec 16, 2009 at 11:29:06AM +0100, Florian Fainelli wrote:

> From: Florian Fainelli <ffainelli@freebox.fr>
> Subject: [PATCH v3] MIPS: add readl/write_be accessors
> 
> MIPS currently lacks the readl_be and writel_be accessors
> which are required by BCM63xx for OHCI and EHCI support.
> Let's define them globally for MIPS. This also fixes the
> compilation of the bcm63xx defconfig against USB.

Queued; I've added the b, w and q variants to make the patch feature
complete even though there are probably no users atm.

  Ralf
