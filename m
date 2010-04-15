Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 12:46:17 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51646 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492631Ab0DOKqN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Apr 2010 12:46:13 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3FAkBaB012940;
        Thu, 15 Apr 2010 11:46:12 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3FAkB9J012938;
        Thu, 15 Apr 2010 11:46:11 +0100
Date:   Thu, 15 Apr 2010 11:46:10 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: add sysdev for DBDMA PM.
Message-ID: <20100415104610.GA8123@linux-mips.org>
References: <1271270024-26684-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271270024-26684-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 14, 2010 at 08:33:44PM +0200, Manuel Lauss wrote:

> Add a sysdev for DBDMA PM.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Tested on DB1200; no changes since yesterday.  It works as intended
> and per-channel sysdevs seem like overdoing it.

Agreed.  Thanks, queued for 2.6.35.

  Ralf
