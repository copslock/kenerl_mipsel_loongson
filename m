Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 03:26:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40473 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492732Ab0D1B02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 03:26:28 +0200
Date:   Wed, 28 Apr 2010 02:26:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] net/sb1250: setup the pdevice within the soc code
In-Reply-To: <20100426210022.GE27656@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1004280224270.31578@eddie.linux-mips.org>
References: <20100426195229.GB22245@Chamillionaire.breakpoint.cc> <20100426202459.GD27656@linux-mips.org> <20100426204122.GA23697@Chamillionaire.breakpoint.cc> <20100426210022.GE27656@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 26 Apr 2010, Ralf Baechle wrote:

> > doing it within the driver does not look good.
> 
> And surely isn't how platform devices were meat to be used.
> 
> > Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> 
> Go ahead:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

 That was the long-term plan back when the driver was updated to its 
current form.  Thanks for pushing this forward.

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
