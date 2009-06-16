Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 12:03:19 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42628 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492785AbZFPKDI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 12:03:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5GA1bIg014411;
	Tue, 16 Jun 2009 11:01:37 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5GA1bSX014410;
	Tue, 16 Jun 2009 11:01:37 +0100
Date:	Tue, 16 Jun 2009 11:01:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg KH <gregkh@suse.de>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
Message-ID: <20090616100137.GB13622@linux-mips.org>
References: <4A00DA84.5040101@caviumnetworks.com> <20090506051438.GA6134@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090506051438.GA6134@suse.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 05, 2009 at 10:14:38PM -0700, Greg KH wrote:

> On Tue, May 05, 2009 at 05:32:04PM -0700, David Daney wrote:
> > This patch set introduces the octeon-ethernet driver into the
> > drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
> > family.
> > 
> > The first five patches are small tweaks to the existing octeon support
> > that are required by the ethernet driver.  I would expect them to be
> > merged via Ralf's linux-mips.org tree.
> > 
> > The last two are the driver, and would probably be merged via the
> > drivers/staging tree.  However since they depend on the first five,
> > they probably shouldn't be merged until those five are merged.
> 
> Ralf, if you want to take the 2 staging driver patches, that's fine with
> me to make it easier.  Or if you want me to merge it, on the next merge
> window, with the mips patches through my tree, I can do that as well.
> 
> Which ever is easier for you.

As per recent discussions I've queued the driver.  Will go to Linus as part
of the next pull.

  Ralf
