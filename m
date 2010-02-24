Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 12:06:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50810 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491094Ab0BXLG2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 12:06:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OB6PSa030127;
        Wed, 24 Feb 2010 12:06:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OB6O3J030125;
        Wed, 24 Feb 2010 12:06:24 +0100
Date:   Wed, 24 Feb 2010 12:06:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: TITAN ethernet driver  exist only in linux-mips
Message-ID: <20100224110623.GB31516@linux-mips.org>
References: <20100224164535.944fb156.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100224164535.944fb156.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 04:45:35PM +0900, Yoichi Yuasa wrote:

> The four files exist only in linux-mips.
> 
> drivers/net/titan_mdio.h
> drivers/net/titan_mdio.c
> drivers/net/titan_ge.h
> drivers/net/titan_ge.c
> 
> What should we do to these?

It's not in the shape to be merged upstream and has suffered severe
bitrot.  I've had it sit there until somebody feels mercy with the poor
sod and fixes it up or maybe takes the old, never merged driver for the
Basler eXcite and brings that into shape for merging upstream or at
least drivers/staging.

  Ralf
