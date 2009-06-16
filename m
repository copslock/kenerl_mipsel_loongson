Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 18:32:45 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:56786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491816AbZFPQcV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 18:32:21 +0200
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 98CC687D82;
	Tue, 16 Jun 2009 18:31:13 +0200 (CEST)
Date:	Tue, 16 Jun 2009 09:26:48 -0700
From:	Greg KH <gregkh@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
Message-ID: <20090616162648.GI26879@suse.de>
References: <4A00DA84.5040101@caviumnetworks.com> <20090506051438.GA6134@suse.de> <20090616100137.GB13622@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090616100137.GB13622@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Tue, Jun 16, 2009 at 11:01:37AM +0100, Ralf Baechle wrote:
> On Tue, May 05, 2009 at 10:14:38PM -0700, Greg KH wrote:
> 
> > On Tue, May 05, 2009 at 05:32:04PM -0700, David Daney wrote:
> > > This patch set introduces the octeon-ethernet driver into the
> > > drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
> > > family.
> > > 
> > > The first five patches are small tweaks to the existing octeon support
> > > that are required by the ethernet driver.  I would expect them to be
> > > merged via Ralf's linux-mips.org tree.
> > > 
> > > The last two are the driver, and would probably be merged via the
> > > drivers/staging tree.  However since they depend on the first five,
> > > they probably shouldn't be merged until those five are merged.
> > 
> > Ralf, if you want to take the 2 staging driver patches, that's fine with
> > me to make it easier.  Or if you want me to merge it, on the next merge
> > window, with the mips patches through my tree, I can do that as well.
> > 
> > Which ever is easier for you.
> 
> As per recent discussions I've queued the driver.  Will go to Linus as part
> of the next pull.

Great, thanks for doing this.

greg k-h
