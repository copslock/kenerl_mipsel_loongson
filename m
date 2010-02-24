Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 21:54:08 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:44871 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492474Ab0BXUxo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 21:53:44 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o1OKrWwK025978;
        Wed, 24 Feb 2010 14:53:32 -0600
Subject: Re: Reverting old hack
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>,
        Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-mips@linux-mips.org
In-Reply-To: <20100224164100.GD5130@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
         <1266815257.1959.23.camel@dc7800.home>
         <20100222132830.GA5017@linux-mips.org>
         <201002231601.15136.bjorn.helgaas@hp.com>
         <20100224090333.44a16d0a.yuasa@linux-mips.org>
         <20100224164100.GD5130@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 25 Feb 2010 07:53:31 +1100
Message-ID: <1267044811.23523.1691.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Wed, 2010-02-24 at 17:41 +0100, Ralf Baechle wrote:
> 
> The complicated solution is to reserve all address range that potencially
> could cause such aliases.  But with the PCI spec limiting port allocations
> for devices to a maximum of 256 bytes 16MB of port address space already is
> way more than one would ever expect to be used so I suggest to just limit
> the port address space to 16MB.
> 
> Could you test the patch below?

On PPC I set the top level IO resource to no more than 1M, actually even
as small as 64K on some bridges. There's no point doing more, x86 ony
have 64K of IO space anyways :-)

Cheers,
Ben.
