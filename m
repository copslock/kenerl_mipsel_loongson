Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 00:21:30 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:48957 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492943AbZFWWVY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jun 2009 00:21:24 +0200
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2B3375FC9F;
	Wed, 24 Jun 2009 00:18:09 +0200 (CEST)
Date:	Tue, 23 Jun 2009 14:32:57 -0700
From:	Greg KH <gregkh@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: octeon-ethernet: Convert to use
	net_device_ops.
Message-ID: <20090623213257.GA6691@suse.de>
References: <1245782048-24058-1-git-send-email-ddaney@caviumnetworks.com> <20090623212559.GA9358@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090623212559.GA9358@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Tue, Jun 23, 2009 at 10:25:59PM +0100, Ralf Baechle wrote:
> On Tue, Jun 23, 2009 at 11:34:08AM -0700, David Daney wrote:
> 
> > Convert the driver to use net_device_ops as it is now mandatory.
> > 
> > Also compensate for the removal of struct sk_buff's dst field.
> > 
> > The changes are mostly mechanical, the content of ethernet-common.c
> > was moved to ethernet.c and ethernet-common.{c,h} are removed.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > ---
> > 
> > Although it is a staging driver, we may want to merge it via Ralf's
> > tree as Octeon is a MIPS SOC.
> 
> Yes, this way it'll receive most testing.
> 
> Greg, I assume you're ok with me merging this patch to Linus so I've
> commited it into the linux-mips.org repository.

No objection from me at all.

thanks,

greg k-h
