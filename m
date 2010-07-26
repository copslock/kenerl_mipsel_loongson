Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 23:58:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56513 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492391Ab0GZV6a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jul 2010 23:58:30 +0200
Date:   Mon, 26 Jul 2010 22:58:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
cc:     linux-mips@linux-mips.org, Mark E Mason <mason@broadcom.com>
Subject: Re: Problems with BCM91125E
In-Reply-To: <AANLkTinJzB_yWW40tsPhE5mp6w_1=RsoLC=h7kYS5bkx@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1007262250090.16898@eddie.linux-mips.org>
References: <AANLkTinJzB_yWW40tsPhE5mp6w_1=RsoLC=h7kYS5bkx@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 26 Jul 2010, Matt Turner wrote:

> I checked the manual [0] to verify that all switches were in the
> default positions, and they were. I plugged my serial cable in and
> turned it on, and it printed
> 
> """
> [HELO]
> [L1CI]
> [L2CI]
> [DRAM]
> [RAMX]
> """
> 
> and then it stops. According to this document [1] 'RAMX' means "Fatal
> error. Displayed if there is no RAM in the system" which is
> particularly odd as RAM chips are soldiered on the board.

 I had one of these briefly in my hands, but never got to powering it up, 
so the only advice I can give is to check whether the SOC doesn't 
overheat.  In particular the heatsink/fan combo used with these boards 
surprisingly enough were not from the upper shelf and the fan would fail 
rather quickly typically causing the device to hang even before CFE has 
finished initialisation.

 Have you tried it in the device or the standalone mode?

  Maciej
