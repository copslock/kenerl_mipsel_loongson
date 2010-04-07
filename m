Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 17:35:15 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34431 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492357Ab0DGPfK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Apr 2010 17:35:10 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o37FZ07F024941;
        Wed, 7 Apr 2010 16:35:00 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o37FYuwt024936;
        Wed, 7 Apr 2010 16:34:56 +0100
Date:   Wed, 7 Apr 2010 16:34:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: db1200: remove custom wait implementation
Message-ID: <20100407153454.GA24682@linux-mips.org>
References: <1270307223-3825-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1270307223-3825-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 03, 2010 at 05:07:03PM +0200, Manuel Lauss wrote:

> While playing with the out-of-tree MAE driver module, the system
> would panic after a while in the db1200 custom wait code after
> wakeup due to a clobbered k0 register being used as target address
> of a store op.
> 
> Remove the custom wait implementation and revert back to the
> Alchemy-recommended implementation already set as default.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> I've played a few hours worth of video from a SD card now without
> a hitch; usually the panic would occur after ~10 minutes.
> 
> Please add this to the 2.6.34 queue, Thanks!

Yes, this use of k0 was definately looking fishy - and I'm not talking
about the kind of fish in a bouillabaisse ;-)

Applied.  Thanks!

  Ralf
