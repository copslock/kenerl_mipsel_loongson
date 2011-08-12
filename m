Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 18:05:53 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:36903 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491873Ab1HLQFr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2011 18:05:47 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id C5D398D40D;
        Fri, 12 Aug 2011 18:05:46 +0200 (CEST)
Date:   Fri, 12 Aug 2011 09:04:54 -0700
From:   Greg KH <gregkh@suse.de>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/8] MIPS: Alchemy: abstract USB block control register
 access
Message-ID: <20110812160454.GA11898@suse.de>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
 <1313141985-5830-2-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1313141985-5830-2-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9498

On Fri, Aug 12, 2011 at 11:39:38AM +0200, Manuel Lauss wrote:
> Alchemy chips have one or more registers which control access
> to the usb blocks as well as PHY configuration.  I don't want
> the OHCI/EHCI glues to know about the different registers and bits;
> new arch code hides the gory details of USB configuration from them.
> 
> Cc: linux-usb@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> CC'ed Greg for an Ack on the USB glue parts.  I'd like this to go through the
>  MIPS tree since other changes in it depend on it.

Fine with me on the USB portions, you are just deleting code, which I
like :)

But should the "common" USB code really live under arch/mips/alchemy/ ?
The goal is to move driver code out of arch/ and into drivers/.  Why are
you moving stuff backwards here?

greg k-h
