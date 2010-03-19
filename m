Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 14:22:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38809 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492155Ab0CSNWm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 14:22:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2JDMWBo018169;
        Fri, 19 Mar 2010 14:22:35 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2JDMSuF018166;
        Fri, 19 Mar 2010 14:22:28 +0100
Date:   Fri, 19 Mar 2010 14:22:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] MIPS: bcm63xx: initialize gpio_out_low & out_high to
 current value at boot.
Message-ID: <20100319132223.GQ4554@linux-mips.org>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
 <1264872898-28149-8-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264872898-28149-8-git-send-email-mbizon@freebox.fr>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 30, 2010 at 06:34:58PM +0100, Maxime Bizon wrote:

> To avoid glitch during gpio initialisation, fetch gpio output
> registers values left by bootloader.

Applied as well.

Thanks,

  Ralf
