Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 19:05:21 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:51761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491978Ab0DBRFN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Apr 2010 19:05:13 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id 662CE86391;
        Fri,  2 Apr 2010 19:05:13 +0200 (CEST)
Date:   Fri, 2 Apr 2010 10:04:24 -0700
From:   Greg KH <gregkh@suse.de>
To:     David Miller <davem@davemloft.net>
Cc:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix ethernet driver for Octeon based Movidis
        hardware
Message-ID: <20100402170424.GC32293@suse.de>
References: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com> <20100401.182045.106908204.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100401.182045.106908204.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Thu, Apr 01, 2010 at 06:20:45PM -0700, David Miller wrote:
> From: David Daney <ddaney@caviumnetworks.com>
> Date: Thu,  1 Apr 2010 18:17:53 -0700
> 
> > The Movidis X16 bootloader doesn't enable the mdio bus.  The first
> > patch fixes this by enabling the mdio bus when the driver is
> > initialized.
> > 
> > Also the addresses of the PHYs was unknown for this device.  The
> > second patch adds the corresponding PHY addresses.
> > 
> > With both patches applied I can successfully use all eight Ethernet
> > ports.
> > 
> > Please consider for 2.6.34.  Since Octeon is an embedded MIPS SOC it
> > is unlikely to break the kernel for any workstations.  Any or all of
> > these could be considered for merging via Ralf's linux-mips.org tree.
> 
> Ralf please merge this via your MIPS tree, thanks:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

I agree, Ralf, please take these and you can add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to them.

thanks,

greg k-h
