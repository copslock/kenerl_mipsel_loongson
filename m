Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 05:15:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52242 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491093Ab0EYDPq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 05:15:46 +0200
Date:   Tue, 25 May 2010 04:15:46 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Kernel unaligned access
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404E2D299@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Message-ID: <alpine.LFD.2.00.1005250413430.4344@eddie.linux-mips.org>
References: <20100524173624.2d3ffc3d.yuasa@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404E2D299@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 24 May 2010, Anoop P.A. wrote:

> I am trying to run 32 bit RFS with a 64 bit kernel on a RM9000 based
> processor board. The board is equipped with 2 GB DIMM.  When ever I
> initiate ftp transfer of 1 GB file I am getting following unaligned
> access error
[...]
> Kindly help me with your pointers to debug the issue. I am running
> 2.6.18 kernel.

 Please try something less rotten.  That version is almost four years old.  
Lots of issues have been fixed since then.  The current version is 2.6.34.

  Maciej
