Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 13:44:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56318 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492292Ab0CSMo4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 13:44:56 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2JCiscv017101;
        Fri, 19 Mar 2010 13:44:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2JCirPa017099;
        Fri, 19 Mar 2010 13:44:53 +0100
Date:   Fri, 19 Mar 2010 13:44:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] MIPS: bcm63xx: call board_register_device from
 device_initcall()
Message-ID: <20100319124453.GO4554@linux-mips.org>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
 <1264872898-28149-7-git-send-email-mbizon@freebox.fr>
 <20100319123430.GN4554@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100319123430.GN4554@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 19, 2010 at 01:34:31PM +0100, Ralf Baechle wrote:

> > Some device registration (eg leds), expect subsystem initcall to be
> > run first, so move board device registration to device_initcall().
> 
> Applied.  Thanks,

And pulled again.  Florian posted his NACK together with a new patch
which get sorted separately by patchworks so I didn't see the NACK right
away.

To avoid that sort of things do me a favor, post comments to an old
patch and submissions of new patches in separate emails.  Thanks.

  Ralf
