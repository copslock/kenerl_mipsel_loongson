Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2011 02:12:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33833 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491083Ab1BPBMS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Feb 2011 02:12:18 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p1G1C7sk011909;
        Wed, 16 Feb 2011 02:12:07 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1G1C4oi011903;
        Wed, 16 Feb 2011 02:12:04 +0100
Date:   Wed, 16 Feb 2011 02:12:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jiri Slaby <jirislaby@gmail.com>
Cc:     Nikolay Ledovskikh <nledovskikh@gmail.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, lrodriguez@atheros.com,
        mickflemm@gmail.com, me@bobcopeland.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] ath5k: Use mips generic dma-mapping functions to avoid
 seqfault on AHB chips
Message-ID: <20110216011203.GA5773@linux-mips.org>
References: <20110215220929.1cc6e9d4.nledovskikh@gmail.com>
 <4D5AD6A6.8090505@gmail.com>
 <AANLkTiks9rG2CzM2LabNerK3zgJ+R+weytQgvXxDbNe7@mail.gmail.com>
 <4D5AE52B.80002@gmail.com>
 <AANLkTinnCOEXF835yhNeJDfBdKjx_dss6TFeUmjL-Yk2@mail.gmail.com>
 <4D5AFB3B.6080407@gmail.com>
 <4D5AFBCB.1090907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D5AFBCB.1090907@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@duck.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 15, 2011 at 11:18:51PM +0100, Jiri Slaby wrote:

> > There, the res->start may be either of the following:
> > AR531X_WLAN0 .. 0x18000000
> > AR531X_WLAN1 .. 0x18500000
> 
> 
> > AR2315_WLAN0 .. 0xB0000000
> 
> Or maybe this should be 0x10000000 in openwrt in the first place? Then
> ioremap should do the right thing, right?

Yes - 0xb0000000 looks like it's a virtual address which is wrong.

Rule #1: Put physical addresses in headers and code only.
Rule #2: If using one of the KSEG address and address conversion macros,
get rid of them, use ioremap.  The KSEG macros are for use by arch core
code only; for use anywhere else I reject patches these days.

  Ralf
