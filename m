Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 00:45:13 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41927 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491164Ab0DMWpJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 00:45:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3DMj4rV026035;
        Tue, 13 Apr 2010 23:45:05 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3DMj3Tt025997;
        Tue, 13 Apr 2010 23:45:03 +0100
Date:   Tue, 13 Apr 2010 23:45:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix up residual devboard
 poweroff/reboot code.
Message-ID: <20100413224501.GB24077@linux-mips.org>
References: <1269554138-4620-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1269554138-4620-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 25, 2010 at 10:55:38PM +0100, Manuel Lauss wrote:

> Clean out stray unused board_reset() calls in pb1x boards,
> the pb1000 is different from the rest and gets private methods.
> 
> (Cleanup after 32fd6901a6d8d19f94e4de6be4e4b552ab078620)
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks, queued for 2.6.35.

  Ralf
