Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 16:52:35 +0100 (WEST)
Received: from cantor.suse.de ([195.135.220.2]:35499 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022475AbZFDPw3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 16:52:29 +0100
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2E5F590847;
	Thu,  4 Jun 2009 17:52:23 +0200 (CEST)
Date:	Thu, 4 Jun 2009 08:29:44 -0700
From:	Greg KH <gregkh@suse.de>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>,
	David Daney <ddaney@caviumnetworks.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
Message-ID: <20090604152944.GB19600@suse.de>
References: <4A00DA84.5040101@caviumnetworks.com> <20090603235428.GB19375@kroah.com> <200906040949.53167.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200906040949.53167.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 09:49:52AM +0200, Florian Fainelli wrote:
> Le Thursday 04 June 2009 01:54:28 Greg KH, vous avez écrit :
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
> > Ok, as Ralf doesn't seem to have responded to my previous query, I'll
> > just merge the last driver, and mark it CONFIG_BROKEN which you can turn
> > off when the infrastructure portions go in.
> >
> > Sound reasonable?
> 
> Cannot we get this driver merged via David Miller's tree instead ? It has been 
> rock solid here and does not seem too ugly for a net-next-2.6 inclusion imho.

That's up to the submitter, it seemed that they wanted it in staging
first for some reason.

thanks,

greg k-h
