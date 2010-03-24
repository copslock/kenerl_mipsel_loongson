Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 01:21:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46765 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492514Ab0CXAVA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Mar 2010 01:21:00 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2O0KvEx019776;
        Wed, 24 Mar 2010 01:20:58 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2O0Kusm019745;
        Wed, 24 Mar 2010 01:20:56 +0100
Date:   Wed, 24 Mar 2010 01:20:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] bcm63xx: fix build failure in board_bcm963xx.c
Message-ID: <20100324002055.GV4554@linux-mips.org>
References: <201003231030.09003.ffainelli@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201003231030.09003.ffainelli@freebox.fr>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 23, 2010 at 10:30:08AM +0100, Florian Fainelli wrote:

> Since 2083e832, the SPROM is now registered in the board_prom_init callback,
> but it references variables and functions which are declared below. Move the
> variables and functions above board_prom_init.

Thanks, applied!

  Ralf
