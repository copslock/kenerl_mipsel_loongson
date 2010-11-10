Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 00:30:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35424 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491918Ab0KJXa4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 00:30:56 +0100
Date:   Wed, 10 Nov 2010 23:30:56 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Tony Wu <tung7970@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Separate two consecutive loads in memset.S
In-Reply-To: <20101110140945.GA29377@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1011102330090.26479@eddie.linux-mips.org>
References: <20101110134815.GA28312@metis> <20101110140945.GA29377@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Nov 2010, Ralf Baechle wrote:

> Only R2000/R3000 class processors are lacking the the load-user interlock
> and even some of those got it retrofitted.  With R2000/R3000 being fairly
> uncommon these days the impact of this bug should be minor but the last
> R3000 DECstation user on this list may be interested ;-)

 Good catch Tony, thanks!

  Maciej
