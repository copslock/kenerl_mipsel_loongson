Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 21:25:56 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50519 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492729Ab0HBTZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Aug 2010 21:25:52 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o72JPjjU032287;
        Mon, 2 Aug 2010 20:25:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o72JPiTX032212;
        Mon, 2 Aug 2010 20:25:44 +0100
Date:   Mon, 2 Aug 2010 20:25:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/4] MIPS: BCM47xx: Fill values for b43 into ssb sprom
Message-ID: <20100802192543.GA31070@linux-mips.org>
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
 <1280261566-8247-3-git-send-email-hauke@hauke-m.de>
 <20100802153103.GB11598@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100802153103.GB11598@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 02, 2010 at 04:31:03PM +0100, Ralf Baechle wrote:
> Date: Mon, 2 Aug 2010 16:31:03 +0100
> From: Ralf Baechle <ralf@linux-mips.org>
> To: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH 2/4] MIPS: BCM47xx: Fill values for b43 into ssb sprom
> Content-Type: text/plain; charset=us-ascii
> 
> Thanks, applied.

Causes warnings which then break the build.  Dropped.

  Ralf
