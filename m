Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 07:42:41 +0100 (BST)
Received: from cantor2.suse.de ([195.135.220.15]:38914 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022702AbZEFGmf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 May 2009 07:42:35 +0100
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 545B48655F;
	Wed,  6 May 2009 08:42:28 +0200 (CEST)
Date:	Tue, 5 May 2009 22:14:38 -0700
From:	Greg KH <gregkh@suse.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
Message-ID: <20090506051438.GA6134@suse.de>
References: <4A00DA84.5040101@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Tue, May 05, 2009 at 05:32:04PM -0700, David Daney wrote:
> This patch set introduces the octeon-ethernet driver into the
> drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
> family.
> 
> The first five patches are small tweaks to the existing octeon support
> that are required by the ethernet driver.  I would expect them to be
> merged via Ralf's linux-mips.org tree.
> 
> The last two are the driver, and would probably be merged via the
> drivers/staging tree.  However since they depend on the first five,
> they probably shouldn't be merged until those five are merged.

Ralf, if you want to take the 2 staging driver patches, that's fine with
me to make it easier.  Or if you want me to merge it, on the next merge
window, with the mips patches through my tree, I can do that as well.

Which ever is easier for you.

thanks,

greg k-h
