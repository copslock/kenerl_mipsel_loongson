Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 10:14:19 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48277 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491775Ab0GEIOQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 10:14:16 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o658E5o8004421;
        Mon, 5 Jul 2010 09:14:06 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o658E3YB004419;
        Mon, 5 Jul 2010 09:14:03 +0100
Date:   Mon, 5 Jul 2010 09:14:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Shane McDonald <mcdonald.shane@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 5/9] Removing dead CONFIG_BLK_DEV_IDE
Message-ID: <20100705081402.GB740@linux-mips.org>
References: <cover.1275925108.git.siccegge@cs.fau.de>
 <73e9e4bd7615488c9567f02f8962825386956365.1275925108.git.siccegge@cs.fau.de>
 <AANLkTillx50SaxZU2cT9YSlS4uRF_ED5-wlG-JwfXfFT@mail.gmail.com>
 <20100616113548.GA10065@faui48a.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100616113548.GA10065@faui48a.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 16, 2010 at 01:35:48PM +0200, Christoph Egger wrote:

> On Thu, Jun 10, 2010 at 12:23:06PM -0600, Shane McDonald wrote:
> >   I wonder if, instead of deleting the code, the constant should be
> > changed from CONFIG_BLK_DEV_IDE to CONFIG_IDE.  The original
> > patch that removed CONFIG_BLK_DEV_IDE seemed to make this change:
> > http://kerneltrap.org/mailarchive/linux-kernel/2008/8/13/2929444
> > 
> > Shane
> 
> You're probably right, updated patch below
> 
> -------
> From: Christoph Egger <siccegge@cs.fau.de>
> Date: Mon, 7 Jun 2010 17:29:48 +0200
> Subject: [PATCH 5/9] Removing dead CONFIG_BLK_DEV_IDE
> 
> CONFIG_BLK_DEV_IDE doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
> diff --git a/arch/mips/mti-malta/malta-setup.c
> b/arch/mips/mti-malta/malta-setup.c
> index b7f37d4..f6a5ea8 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -105,7 +105,7 @@ static void __init fd_activate(void)
>  }
>  #endif
>  
> -#ifdef CONFIG_BLK_DEV_IDE
> +#ifdef CONFIG_IDE

This doesn't fly too well either.  CONFIG_BLK_DEV_IDE was a bool but
CONFIG_IDE is tristate.  But changing the ifdef to

#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)

wouldn't really work either.  I think this needs some generic infrastructure
to get the PCI clock.

Or maybe this is just another reason to scrap IDE support.

  Ralf
