Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 18:13:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53751 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492380Ab0CORNC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Mar 2010 18:13:02 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2FHClUr020278;
        Mon, 15 Mar 2010 18:12:48 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2FHCkct020276;
        Mon, 15 Mar 2010 18:12:46 +0100
Date:   Mon, 15 Mar 2010 18:12:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: AR7: fix phat finger of reset bit in
 vlynq_high_data
Message-ID: <20100315171246.GA20055@linux-mips.org>
References: <4thq67-rjo.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4thq67-rjo.ln1@chipmunk.wormnet.eu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 12, 2010 at 07:39:48PM +0000, Alexander Clouter wrote:
> From: Alexander Clouter <alex@digriz.org.uk>
> Date:   Fri, 12 Mar 2010 19:39:48 +0000
> To: linux-mips@linux-mips.org
> Subject: [PATCH] MIPS: AR7: fix phat finger of reset bit in vlynq_high_data
> 
> Seems in my whitespace cleanup 7084338eb8eb0cc021ba86c340157bad397f3f0b
> caused AR7 to no longer get as far as init.  Fixed my phat fingering.

Patch looks good but it seems you phat fingered the commit ID which is
0f2536082d01448daeced8d9e82c3ba1751fefa3 (lmo) rsp.
8c2961da46abd85a71d20f2b169bf80618e (kernel.org).

Applied,

  Ralf
