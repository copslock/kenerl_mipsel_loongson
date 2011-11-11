Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 01:46:38 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:49771 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904249Ab1KKAqa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 01:46:30 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id E8ABC89471;
        Fri, 11 Nov 2011 01:46:29 +0100 (CET)
Date:   Thu, 10 Nov 2011 16:45:17 -0800
From:   Greg KH <gregkh@suse.de>
To:     ddaney.cavm@gmail.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/3] Move some Octeon support files out of staging.
Message-ID: <20111111004517.GA32432@suse.de>
References: <1320971387-29343-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320971387-29343-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9877

On Thu, Nov 10, 2011 at 04:29:44PM -0800, ddaney.cavm@gmail.com wrote:
> From: David Daney <david.daney@cavium.com>
> 
> First patch:
> 
> In preparation for my next set of patches to add device tree support
> for Octeon, move some files out of drivers/staging/octeon to common
> location.  There are two basic types of files I am moving:
> 
> 1) Register definition files.  Most Octeon register definition files
>    are in arch/mips/include/asm/octeon, put the rest there too.
> 
> 2) Low level packet port type probing code.  This is needed by both
>    the Ethernet driver and the code that fixes up the in-kernel device
>    trees.  Although new board pass a device tree to the kernel,
>    support of legacy boards requires that this probing code be used to
>    fix up an in-kernel device tree template.
> 
> 
> Second patch:
> 
> Update support for legacy boards.
> 
> 
> Third patch:
> 
> Seperate probing and initialization of packet ports.
> 
> 
> Since these are MIPS architecture files we could merge via Ralf's tree
> if approved.

If Ralf approves of these changes, that's fine with me and they can go
through his tree:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


thanks,

greg k-h
