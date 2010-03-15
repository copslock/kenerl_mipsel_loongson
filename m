Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 18:17:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40528 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492385Ab0CORRa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Mar 2010 18:17:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2FHHIFr020469;
        Mon, 15 Mar 2010 18:17:18 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2FHHII8020467;
        Mon, 15 Mar 2010 18:17:18 +0100
Date:   Mon, 15 Mar 2010 18:17:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: AR7: fix phat finger of cpmac fixed_phy_add
Message-ID: <20100315171718.GB20055@linux-mips.org>
References: <bm1r67-9mq.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bm1r67-9mq.ln1@chipmunk.wormnet.eu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 13, 2010 at 12:09:15AM +0000, Alexander Clouter wrote:

> Seems I trimmed one too many lines in
> 7084338eb8eb0cc021ba86c340157bad397f3f0b which led to no functioning
> Ethernet on my WAG54Gv2.  This patch restores the AWOL line.

Phat-freely applied.  Thanks!

  Ralf
