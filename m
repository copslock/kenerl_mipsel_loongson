Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 16:54:20 +0100 (CET)
Received: from p57B0EBE7.dip.t-dialin.net ([87.176.235.231]:45865 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491021Ab0L1PyR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 16:54:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBSFsDKH001790;
        Tue, 28 Dec 2010 16:54:14 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBSFsCUm001778;
        Tue, 28 Dec 2010 16:54:12 +0100
Date:   Tue, 28 Dec 2010 16:54:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Use WARN() in uasm for better diagnostics.
Message-ID: <20101228155411.GB31111@linux-mips.org>
References: <1293502709-11454-1-git-send-email-ddaney@caviumnetworks.com>
 <4D1A05D9.9050707@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D1A05D9.9050707@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 28, 2010 at 06:44:25PM +0300, Sergei Shtylyov wrote:

> > static inline __uasminit u32 build_jimm(u32 arg)
> > {
> >-	if (arg & ~((JIMM_MASK) << 2))
> >-		printk(KERN_WARNING "Micro-assembler field overflow\n");
> >+	WARN(arg & ~((JIMM_MASK) << 2),
> 
>    Could drop parens around JIMM_MASK while at it...

Done.

  Ralf
