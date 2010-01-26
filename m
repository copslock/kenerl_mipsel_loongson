Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 15:26:15 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45750 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493328Ab0AZO0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 15:26:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0QEQEQJ000657;
        Tue, 26 Jan 2010 15:26:15 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0QEQE3J000655;
        Tue, 26 Jan 2010 15:26:14 +0100
Date:   Tue, 26 Jan 2010 15:26:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] powertv: Fix support for timer interrupts when using >64
 external IRQs
Message-ID: <20100126142614.GC17849@linux-mips.org>
References: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16730

On Mon, Dec 21, 2009 at 05:49:22PM -0800, David VomLehn wrote:

> The MIPS processor is limited to 64 external interrupt sources. Using a
> greater number without IRQ sharing requires reading platform-specific
> registers. On such platforms, reading the IntCtl register to determine
> which interrupt corresponds to a timer interrupt will not work.
> 
> On MIPSR2 systems there is a solution--the TI bit in the Cause register,
> specifically indicates that a timer interrupt has occured. This patch
> uses that bit to detect interrupts for MIPSR2 processors, which may be
> expected to work regardless of how the timer interrupt may be routed
> in the hardware.

I think this isn't relevant for any currently in-tree supported platforms (?)
so I've queued this for 2.6.34.

Thanks,

  Ralf
